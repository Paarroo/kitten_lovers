import { Controller } from "@hotwired/stimulus"

/**
 * Stimulus controller for handling login form interactions
 * Manages form validation, loading states, and user feedback
 */
export default class extends Controller {
  // Define targets that can be accessed from the HTML
  static targets = [
    "emailInput",
    "passwordInput",
    "submitButton",
    "rememberCheck",
    "notice",
    "alert",
    "errors"
  ]

  /**
   * Called when the controller is connected to the DOM
   * Sets up initial state and event listeners
   */
  connect() {
    console.log("🔐 Sessions controller connected")
    this.initializeForm()
    this.setupAutoHideAlerts()
  }

  /**
   * Setup auto-hide functionality for server alerts
   */
  setupAutoHideAlerts() {
    // Auto-hide alerts after 5 seconds if they exist
    const alerts = document.querySelectorAll('.alert-danger, .alert-success')
    alerts.forEach(alert => {
      setTimeout(() => {
        if (alert && alert.style.display !== 'none') {
          alert.classList.add('fade-out')
          setTimeout(() => {
            alert.style.display = 'none'
          }, 300)
        }
      }, 5000) // Hide after 5 seconds
    })
  }

  /**
   * Called when the controller is disconnected from the DOM
   * Cleanup any remaining timers or event listeners
   */
  disconnect() {
    console.log("🔐 Sessions controller disconnected")
    this.clearValidationTimers()
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

    // Add event listeners to hide server errors when user starts typing
    this.addErrorClearingListeners()
  }

  /**
   * Add event listeners to clear server error messages when user interacts with form
   */
  addErrorClearingListeners() {
    const inputs = [this.emailInputTarget, this.passwordInputTarget]

    inputs.forEach(input => {
      if (input) {
        input.addEventListener('input', () => this.clearServerErrors())
        input.addEventListener('focus', () => this.clearServerErrors())
      }
    })
  }

  /**
   * Clear server error messages (from Devise)
   */
  clearServerErrors() {
    // Clear alert messages
    if (this.hasAlertTarget) {
      this.alertTarget.style.opacity = '0'
      setTimeout(() => {
        if (this.hasAlertTarget) {
          this.alertTarget.style.display = 'none'
        }
      }, 300)
    }

    // Clear errors div
    if (this.hasErrorsTarget) {
      this.errorsTarget.style.opacity = '0'
      setTimeout(() => {
        if (this.hasErrorsTarget) {
          this.errorsTarget.style.display = 'none'
        }
      }, 300)
    }

    // Also clear any error alerts in the DOM
    const errorAlerts = document.querySelectorAll('.alert-danger')
    errorAlerts.forEach(alert => {
      alert.style.opacity = '0'
      setTimeout(() => {
        alert.style.display = 'none'
      }, 300)
    })
  }

  /**
   * Validate email field in real-time
   * @param {Event} event - Input event from email field
   */
  validateEmail(event) {
    console.log("📧 Validating email:", event.target.value)
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
      } else {
        this.setFieldInvalid(event.target, "Format d'email invalide")
      }
      this.updateSubmitButtonState()
    }, 300)
  }

  /**
   * Validate password field in real-time
   * @param {Event} event - Input event from password field
   */
  validatePassword(event) {
    console.log("🔒 Validating password")
    const password = event.target.value

    // Clear existing validation timer
    if (this.passwordValidationTimer) {
      clearTimeout(this.passwordValidationTimer)
    }

    // Debounce validation
    this.passwordValidationTimer = setTimeout(() => {
      if (password.length === 0) {
        this.clearFieldValidation(event.target)
      } else if (password.length >= 1) {
        this.setFieldValid(event.target)
      } else {
        this.setFieldInvalid(event.target, "Mot de passe requis")
      }
      this.updateSubmitButtonState()
    }, 300)
  }

  /**
   * Handle form submission
   * @param {Event} event - Click event from submit button
   */
  submitLoginForm(event) {
    console.log("📝 Submitting login form")

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

    // Store remember me preference
    if (this.hasRememberCheckTarget) {
      localStorage.setItem('rememberMe', this.rememberCheckTarget.checked)
    }

    // Allow form to submit naturally
    return true
  }

  /**
   * Check if the form is valid for submission
   * @returns {boolean} True if form is valid
   */
  isFormValid() {
    const email = this.emailInputTarget.value.trim()
    const password = this.passwordInputTarget.value
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    return emailRegex.test(email) && password.length >= 1
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
        this.submitButtonTarget.style.opacity = "1"
      } else {
        this.submitButtonTarget.style.opacity = "0.6"
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
        this.submitButtonTarget.textContent = 'Connexion...'
      } else {
        this.submitButtonTarget.disabled = false
        this.submitButtonTarget.classList.remove('loading')
        this.submitButtonTarget.textContent = 'Se connecter'
      }
    }

    // Disable form inputs during loading
    if (this.hasEmailInputTarget) {
      this.emailInputTarget.disabled = loading
    }
    if (this.hasPasswordInputTarget) {
      this.passwordInputTarget.disabled = loading
    }
  }

  /**
   * Set field as valid
   * @param {HTMLElement} field - Input field element
   */
  setFieldValid(field) {
    field.classList.remove('is-invalid')
    field.classList.add('is-valid')
    field.style.borderColor = '#48bb78'
  }

  /**
   * Set field as invalid with error message
   * @param {HTMLElement} field - Input field element
   * @param {string} message - Error message to display
   */
  setFieldInvalid(field, message) {
    field.classList.remove('is-valid')
    field.classList.add('is-invalid')
    field.style.borderColor = '#f56565'

    // You could add error message display logic here
    console.warn(`Validation error for ${field.name}: ${message}`)
  }

  /**
   * Clear validation state for a field
   * @param {HTMLElement} field - Input field element
   */
  clearFieldValidation(field) {
    field.classList.remove('is-valid', 'is-invalid')
    field.style.borderColor = ''
  }

  /**
   * Clear all validation states
   */
  clearAllValidations() {
    if (this.hasEmailInputTarget) {
      this.clearFieldValidation(this.emailInputTarget)
    }
    if (this.hasPasswordInputTarget) {
      this.clearFieldValidation(this.passwordInputTarget)
    }
  }

  /**
   * Show form validation errors
   */
  showFormErrors() {
    console.warn("Form validation failed - please check all fields")

    // Clear any existing server errors first
    this.clearServerErrors()

    // Create a custom validation error message
    this.showCustomAlert("Veuillez vérifier tous les champs du formulaire", "danger")

    // Validate each field and show errors
    if (this.hasEmailInputTarget) {
      const email = this.emailInputTarget.value.trim()
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

      if (!emailRegex.test(email)) {
        this.setFieldInvalid(this.emailInputTarget, "Email requis et valide")
      }
    }

    if (this.hasPasswordInputTarget) {
      const password = this.passwordInputTarget.value

      if (password.length < 1) {
        this.setFieldInvalid(this.passwordInputTarget, "Mot de passe requis")
      }
    }
  }

  /**
   * Show custom alert message
   * @param {string} message - Message to display
   * @param {string} type - Alert type (success, danger, warning, info)
   */
  showCustomAlert(message, type = "info") {
    // Remove any existing custom alerts
    const existingAlerts = document.querySelectorAll('.custom-alert')
    existingAlerts.forEach(alert => alert.remove())

    // Create new alert
    const alertDiv = document.createElement('div')
    alertDiv.className = `alert alert-${type} custom-alert`
    alertDiv.innerHTML = `
      <p class="mb-0">${message}</p>
      <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>
    `

    // Insert at the top of the form
    const authCard = document.querySelector('.auth-card')
    const authHeader = document.querySelector('.auth-header')
    if (authCard && authHeader) {
      authCard.insertBefore(alertDiv, authHeader.nextSibling)
    }

    // Auto-hide after 4 seconds
    setTimeout(() => {
      if (alertDiv) {
        alertDiv.classList.add('fade-out')
        setTimeout(() => alertDiv.remove(), 300)
      }
    }, 4000)
  }

  /**
   * Clear any existing validation timers
   */
  clearValidationTimers() {
    if (this.emailValidationTimer) {
      clearTimeout(this.emailValidationTimer)
    }
    if (this.passwordValidationTimer) {
      clearTimeout(this.passwordValidationTimer)
    }
  }

  /**
   * Handle keyboard shortcuts
   * @param {KeyboardEvent} event - Keyboard event
   */
  handleKeydown(event) {
    // Submit form on Enter key
    if (event.key === 'Enter' && this.isFormValid()) {
      this.submitLoginForm(event)
    }
  }
}
