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
    "loginForm",
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
    const password = event.target.value

    // Clear existing validation timer
    if (this.passwordValidationTimer) {
      clearTimeout(this.passwordValidationTimer)
    }

    // Debounce validation
    this.passwordValidationTimer = setTimeout(() => {
      if (password.length === 0) {
        this.clearFieldValidation(event.target)
      } else if (password.length >= 6) {
        this.setFieldValid(event.target)
      } else {
        this.setFieldInvalid(event.target, "Mot de passe trop court")
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

    return emailRegex.test(email) && password.length >= 6
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
  }

  /**
   * Set field as invalid with error message
   * @param {HTMLElement} field - Input field element
   * @param {string} message - Error message to display
   */
  setFieldInvalid(field, message) {
    field.classList.remove('is-valid')
    field.classList.add('is-invalid')

    // You could add error message display logic here
    console.warn(`Validation error for ${field.name}: ${message}`)
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
    if (this.hasPasswordInputTarget) {
      this.clearFieldValidation(this.passwordInputTarget)
    }
  }

  /**
   * Show form validation errors
   */
  showFormErrors() {
    console.warn("Form validation failed - please check all fields")

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

      if (password.length < 6) {
        this.setFieldInvalid(this.passwordInputTarget, "Mot de passe requis (6 caractères minimum)")
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
