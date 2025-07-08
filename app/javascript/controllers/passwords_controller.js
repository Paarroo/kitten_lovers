import { Controller } from "@hotwired/stimulus"

/**
 * Stimulus controller for handling password reset form interactions
 * Manages form validation, loading states, and user feedback
 */
export default class extends Controller {
  // Define targets that can be accessed from the HTML
  static targets = [
    "emailInput",
    "submitButton",
    "resetForm",
    "notice",
    "alert",
    "errors"
  ]

  /**
   * Called when the controller is connected to the DOM
   * Sets up initial state and event listeners
   */
  connect() {
    console.log("🔑 Passwords controller connected")
    this.initializeForm()
    this.setupKeyboardShortcuts()
  }

  /**
   * Called when the controller is disconnected from the DOM
   * Cleanup any remaining timers or event listeners
   */
  disconnect() {
    console.log("🔑 Passwords controller disconnected")
    this.clearValidationTimers()
    this.removeKeyboardShortcuts()
  }

  /**
   * Initialize form state and validation
   */
  initializeForm() {
    // Set initial button state
    this.updateSubmitButtonState()

    // Clear any existing validation states
    this.clearAllValidations()

    // Focus on email field if empty
    if (this.hasEmailInputTarget && !this.emailInputTarget.value) {
      this.emailInputTarget.focus()
    }

    // Check if there's a pre-filled email from localStorage or URL params
    this.prefillEmailIfAvailable()
  }

  /**
   * Setup keyboard shortcuts for better UX
   */
  setupKeyboardShortcuts() {
    this.keydownHandler = this.handleKeydown.bind(this)
    document.addEventListener('keydown', this.keydownHandler)
  }

  /**
   * Remove keyboard shortcuts
   */
  removeKeyboardShortcuts() {
    if (this.keydownHandler) {
      document.removeEventListener('keydown', this.keydownHandler)
    }
  }

  /**
   * Prefill email if available from previous sessions
   */
  prefillEmailIfAvailable() {
    // Check URL parameters for email
    const urlParams = new URLSearchParams(window.location.search)
    const emailFromUrl = urlParams.get('email')

    // Check localStorage for remembered email
    const rememberedEmail = localStorage.getItem('lastEmail')

    if (this.hasEmailInputTarget && !this.emailInputTarget.value) {
      if (emailFromUrl) {
        this.emailInputTarget.value = emailFromUrl
        this.validateEmail({ target: this.emailInputTarget })
      } else if (rememberedEmail) {
        this.emailInputTarget.value = rememberedEmail
        this.validateEmail({ target: this.emailInputTarget })
      }
    }
  }

  /**
   * Validate email field in real-time
   * @param {Event} event - Input event from email field
   */
  validateEmail(event) {
    const email = event.target.value.trim()
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    // Clear existing validation timer
    if (this.emailValidationTimer) {
      clearTimeout(this.emailValidationTimer)
    }

    // Debounce validation to avoid excessive checks
    this.emailValidationTimer = setTimeout(() => {
      if (email.length === 0) {
        this.clearFieldValidation(event.target)
      } else if (emailRegex.test(email)) {
        this.setFieldValid(event.target)
        // Remember email for future use
        localStorage.setItem('lastEmail', email)
      } else {
        this.setFieldInvalid(event.target, "Format d'email invalide")
      }
      this.updateSubmitButtonState()
    }, 300)
  }

  /**
   * Handle form submission
   * @param {Event} event - Click event from submit button
   */
  submitResetForm(event) {
    console.log("📧 Submitting password reset form")

    // Prevent double submission
    if (this.submitButtonTarget.disabled) {
      event.preventDefault()
      return false
    }

    // Validate form before submission
    if (!this.isFormValid()) {
      event.preventDefault()
      this.showFormErrors()
      return false
    }

    // Set loading state
    this.setLoadingState(true)

    // Show loading overlay
    this.showLoadingOverlay()

    // Store email for potential retry
    const email = this.emailInputTarget.value.trim()
    localStorage.setItem('resetEmail', email)

    // Allow form to submit naturally
    return true
  }

  /**
   * Check if the form is valid for submission
   * @returns {boolean} True if form is valid
   */
  isFormValid() {
    const email = this.emailInputTarget.value.trim()
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    return emailRegex.test(email)
  }

  /**
   * Update submit button state based on form validity
   */
  updateSubmitButtonState() {
    if (this.hasSubmitButtonTarget) {
      const isValid = this.isFormValid()
      this.submitButtonTarget.disabled = !isValid

      // Update button appearance
      if (isValid) {
        this.submitButtonTarget.classList.remove('opacity-50')
      } else {
        this.submitButtonTarget.classList.add('opacity-50')
      }
    }
  }

  /**
   * Set loading state for the form
   * @param {boolean} loading - Whether form is in loading state
   */
  setLoadingState(loading) {
    if (this.hasSubmitButtonTarget) {
      if (loading) {
        this.submitButtonTarget.disabled = true
        this.submitButtonTarget.classList.add('loading')
        this.originalButtonText = this.submitButtonTarget.textContent
        this.submitButtonTarget.textContent = 'Envoi en cours...'
      } else {
        this.submitButtonTarget.disabled = false
        this.submitButtonTarget.classList.remove('loading')
        this.submitButtonTarget.textContent = this.originalButtonText || 'Envoyer le lien de réinitialisation'
      }
    }

    // Disable form inputs during loading
    if (this.hasEmailInputTarget) {
      this.emailInputTarget.disabled = loading
    }
  }

  /**
   * Show loading overlay
   */
  showLoadingOverlay() {
    // Create loading overlay if it doesn't exist
    if (!this.loadingOverlay) {
      this.loadingOverlay = document.createElement('div')
      this.loadingOverlay.className = 'loading-overlay'
      this.loadingOverlay.innerHTML = '<div class="loading-spinner"></div>'

      const authCard = document.querySelector('.auth-card')
      if (authCard) {
        authCard.appendChild(this.loadingOverlay)
      }
    }

    // Show overlay
    this.loadingOverlay.classList.add('active')

    // Auto-hide after successful submission (simulation)
    setTimeout(() => {
      this.hideLoadingOverlay()
    }, 2000)
  }

  /**
   * Hide loading overlay
   */
  hideLoadingOverlay() {
    if (this.loadingOverlay) {
      this.loadingOverlay.classList.remove('active')
    }
  }

  /**
   * Simulate successful email sent confirmation
   */
  showEmailSentConfirmation() {
    const email = this.emailInputTarget.value.trim()
    const authCard = document.querySelector('.auth-card')

    if (authCard) {
      authCard.classList.add('success')

      // Replace form content with confirmation message
      const formContainer = this.resetFormTarget.parentElement
      formContainer.innerHTML = `
        <div class="email-sent-confirmation">
          <span class="email-sent-icon">📧</span>
          <h2 class="email-sent-title">Email envoyé !</h2>
          <p class="email-sent-message">
            Nous avons envoyé un lien de réinitialisation à <strong>${email}</strong>.<br>
            Vérifiez votre boîte de réception et suivez les instructions.
          </p>
          <div class="auth-navigation-links">
            <a href="${this.getSessionPath()}" class="auth-secondary-link">Retour à la connexion</a>
          </div>
        </div>
      `
    }
  }

  /**
   * Get session path for navigation
   * @returns {string} Path to login page
   */
  getSessionPath() {
    // Try to get from Rails routes or use default
    return '/users/sign_in'
  }

  /**
   * Set field as valid
   * @param {HTMLElement} field - Input field element
   */
  setFieldValid(field) {
    field.classList.remove('is-invalid')
    field.classList.add('is-valid')

    // Add success animation
    field.style.transform = 'scale(1.02)'
    setTimeout(() => {
      field.style.transform = 'scale(1)'
    }, 150)
  }

  /**
   * Set field as invalid with error message
   * @param {HTMLElement} field - Input field element
   * @param {string} message - Error message to display
   */
  setFieldInvalid(field, message) {
    field.classList.remove('is-valid')
    field.classList.add('is-invalid')

    // Add shake animation
    field.style.animation = 'shake 0.4s ease-in-out'
    setTimeout(() => {
      field.style.animation = ''
    }, 400)

    console.warn(`Validation error for ${field.name || 'field'}: ${message}`)
  }

  /**
   * Clear validation state for a field
   * @param {HTMLElement} field - Input field element
   */
  clearFieldValidation(field) {
    field.classList.remove('is-valid', 'is-invalid')
  }

  /**
   * Clear all validation states
   */
  clearAllValidations() {
    if (this.hasEmailInputTarget) {
      this.clearFieldValidation(this.emailInputTarget)
    }
  }

  /**
   * Show form validation errors
   */
  showFormErrors() {
    console.warn("Form validation failed - please check email field")

    if (this.hasEmailInputTarget) {
      const email = this.emailInputTarget.value.trim()
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

      if (!email) {
        this.setFieldInvalid(this.emailInputTarget, "Email requis")
      } else if (!emailRegex.test(email)) {
        this.setFieldInvalid(this.emailInputTarget, "Format d'email invalide")
      }
    }
  }

  /**
   * Clear any existing validation timers
   */
  clearValidationTimers() {
    if (this.emailValidationTimer) {
      clearTimeout(this.emailValidationTimer)
    }
  }

  /**
   * Handle keyboard shortcuts
   * @param {KeyboardEvent} event - Keyboard event
   */
  handleKeydown(event) {
    // Submit form on Enter key
    if (event.key === 'Enter' && this.isFormValid()) {
      event.preventDefault()
      this.submitResetForm(event)
    }

    // Clear form on Escape key
    if (event.key === 'Escape') {
      if (this.hasEmailInputTarget) {
        this.emailInputTarget.value = ''
        this.clearAllValidations()
        this.updateSubmitButtonState()
      }
    }
  }

  /**
   * Handle successful form submission (called by Rails UJS or Turbo)
   */
  handleSuccess() {
    console.log("✅ Password reset email sent successfully")
    this.setLoadingState(false)
    this.hideLoadingOverlay()
    this.showEmailSentConfirmation()
  }

  /**
   * Handle form submission error
   */
  handleError() {
    console.error("❌ Error sending password reset email")
    this.setLoadingState(false)
    this.hideLoadingOverlay()
  }
}

// Add shake animation CSS if not already defined
if (!document.querySelector('#shake-animation-style')) {
  const style = document.createElement('style')
  style.id = 'shake-animation-style'
  style.textContent = `
    @keyframes shake {
      0%, 100% { transform: translateX(0); }
      25% { transform: translateX(-5px); }
      75% { transform: translateX(5px); }
    }
  `
  document.head.appendChild(style)
}
