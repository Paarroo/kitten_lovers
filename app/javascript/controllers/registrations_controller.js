import { Controller } from "@hotwired/stimulus"

/**
 * Stimulus controller for handling registration form interactions
 * Manages form validation, password strength, and user feedback
 */
export default class extends Controller {
  // Define targets that can be accessed from the HTML
  static targets = [
    "emailInput",
    "passwordInput",
    "passwordConfirmationInput",
    "submitButton",
    "signupForm",
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
    console.log(" Registrations controller connected")
    this.initializeForm()
    this.createPasswordStrengthIndicator()
  }

  /**
   * Called when the controller is disconnected from the DOM
   * Cleanup any remaining timers or event listeners
   */
  disconnect() {
    console.log(" Registrations controller disconnected")
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
   * Create password strength indicator
   */
  createPasswordStrengthIndicator() {
    if (this.hasPasswordInputTarget && !this.passwordInputTarget.nextElementSibling?.classList.contains('password-strength')) {
      const strengthIndicator = document.createElement('div')
      strengthIndicator.className = 'password-strength'
      strengthIndicator.innerHTML = '<div class="password-strength-bar"></div>'

      this.passwordInputTarget.parentNode.insertBefore(
        strengthIndicator,
        this.passwordInputTarget.nextSibling
      )
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
   * Validate password field and show strength indicator
   * @param {Event} event - Input event from password field
   */
  validatePassword(event) {
    const password = event.target.value

    // Clear existing validation timer
    if (this.passwordValidationTimer) {
      clearTimeout(this.passwordValidationTimer)
    }

    // Update password strength immediately
    this.updatePasswordStrength(password)

    // Debounce validation
    this.passwordValidationTimer = setTimeout(() => {
      if (password.length === 0) {
        this.clearFieldValidation(event.target)
      } else if (password.length >= 8 && this.getPasswordStrength(password) >= 2) {
        this.setFieldValid(event.target)
      } else if (password.length >= 6) {
        this.setFieldWarning(event.target, "Mot de passe faible")
      } else {
        this.setFieldInvalid(event.target, "Mot de passe trop court (6 caractères minimum)")
      }

      // Also validate password confirmation if it has a value
      if (this.hasPasswordConfirmationInputTarget && this.passwordConfirmationInputTarget.value) {
        this.validatePasswordConfirmation({ target: this.passwordConfirmationInputTarget })
      }

      this.updateSubmitButtonState()
    }, 300)
  }

  /**
   * Validate password confirmation field
   * @param {Event} event - Input event from password confirmation field
   */
  validatePasswordConfirmation(event) {
    const password = this.passwordInputTarget.value
    const passwordConfirmation = event.target.value

    // Clear existing validation timer
    if (this.passwordConfirmationValidationTimer) {
      clearTimeout(this.passwordConfirmationValidationTimer)
    }

    // Debounce validation
    this.passwordConfirmationValidationTimer = setTimeout(() => {
      if (passwordConfirmation.length === 0) {
        this.clearFieldValidation(event.target)
      } else if (password === passwordConfirmation) {
        this.setFieldValid(event.target)
      } else {
        this.setFieldInvalid(event.target, "Les mots de passe ne correspondent pas")
      }
      this.updateSubmitButtonState()
    }, 300)
  }

  /**
   * Calculate password strength score
   * @param {string} password - Password to analyze
   * @returns {number} Strength score (0-3)
   */
  getPasswordStrength(password) {
    let score = 0

    // Length check
    if (password.length >= 8) score++

    // Complexity checks
    if (/[a-z]/.test(password) && /[A-Z]/.test(password)) score++
    if (/\d/.test(password)) score++
    if (/[^A-Za-z0-9]/.test(password)) score++

    return Math.min(score, 3)
  }

  /**
   * Update password strength indicator
   * @param {string} password - Current password value
   */
  updatePasswordStrength(password) {
    const strengthBar = document.querySelector('.password-strength-bar')
    if (!strengthBar) return

    const strength = this.getPasswordStrength(password)

    // Remove existing strength classes
    strengthBar.classList.remove('password-strength-weak', 'password-strength-medium', 'password-strength-strong')

    if (password.length === 0) {
      strengthBar.style.width = '0%'
    } else if (strength === 1) {
      strengthBar.classList.add('password-strength-weak')
    } else if (strength === 2) {
      strengthBar.classList.add('password-strength-medium')
    } else if (strength >= 3) {
      strengthBar.classList.add('password-strength-strong')
    }
  }

  /**
   * Handle form submission
   * @param {Event} event - Click event from submit button
   */
  submitSignupForm(event) {
    console.log(" Submitting registration form")

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
    const passwordConfirmation = this.passwordConfirmationInputTarget.value
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    return emailRegex.test(email) &&
           password.length >= 6 &&
           password === passwordConfirmation
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
        this.submitButtonTarget.textContent = 'Inscription...'
      } else {
        this.submitButtonTarget.disabled = false
        this.submitButtonTarget.classList.remove('loading')
        this.submitButtonTarget.textContent = "S'inscrire"
      }
    }

    // Disable form inputs during loading
    if (this.hasEmailInputTarget) {
      this.emailInputTarget.disabled = loading
    }
    if (this.hasPasswordInputTarget) {
      this.passwordInputTarget.disabled = loading
    }
    if (this.hasPasswordConfirmationInputTarget) {
      this.passwordConfirmationInputTarget.disabled = loading
    }
  }

  /**
   * Set field as valid
   * @param {HTMLElement} field - Input field element
   */
  setFieldValid(field) {
    field.classList.remove('is-invalid', 'is-warning')
    field.classList.add('is-valid')
  }

  /**
   * Set field as invalid with error message
   * @param {HTMLElement} field - Input field element
   * @param {string} message - Error message to display
   */
  setFieldInvalid(field, message) {
    field.classList.remove('is-valid', 'is-warning')
    field.classList.add('is-invalid')

    console.warn(`Validation error for ${field.name}: ${message}`)
  }

  /**
   * Set field as warning (weak password)
   * @param {HTMLElement} field - Input field element
   * @param {string} message - Warning message to display
   */
  setFieldWarning(field, message) {
    field.classList.remove('is-valid', 'is-invalid')
    field.classList.add('is-warning')

    console.warn(`Validation warning for ${field.name}: ${message}`)
  }

  /**
   * Clear validation state for a field
   * @param {HTMLElement} field - Input field element
   */
  clearFieldValidation(field) {
    field.classList.remove('is-valid', 'is-invalid', 'is-warning')
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
    if (this.hasPasswordConfirmationInputTarget) {
      this.clearFieldValidation(this.passwordConfirmationInputTarget)
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

    if (this.hasPasswordConfirmationInputTarget) {
      const password = this.passwordInputTarget.value
      const passwordConfirmation = this.passwordConfirmationInputTarget.value

      if (password !== passwordConfirmation) {
        this.setFieldInvalid(this.passwordConfirmationInputTarget, "Les mots de passe doivent correspondre")
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
    if (this.passwordConfirmationValidationTimer) {
      clearTimeout(this.passwordConfirmationValidationTimer)
    }
  }
}
