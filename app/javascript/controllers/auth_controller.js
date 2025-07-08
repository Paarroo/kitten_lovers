// app/javascript/controllers/auth_controller.js
// Authentication controller for login/signup forms with validation and interactions
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // === STIMULUS TARGETS ===
  // These are DOM elements we want to interact with
  static targets = [
    "loginForm",        // Login form element
    "signupForm",       // Signup form element
    "emailInput",       // Email input field
    "passwordInput",    // Password input field
    "passwordConfirmationInput", // Password confirmation field
    "firstNameInput",   // First name input field
    "submitButton",     // Submit button
    "rememberCheck",    // Remember me checkbox
    "errors"            // Error messages container
  ]

  // === CSS CLASSES (optional) ===
  // Define CSS classes that can be applied dynamically
  static classes = [
    "valid",            // CSS class for valid input
    "invalid",          // CSS class for invalid input
    "loading"           // CSS class for loading state
  ]

  // === STIMULUS VALUES ===
  // Values that can be passed from HTML data attributes
  static values = {
    minPasswordLength: { type: Number, default: 6 }
  }

  // === LIFECYCLE METHODS ===

  /**
   * Called when the controller connects to the DOM
   * This is like "document.ready" in jQuery
   */
  connect() {
    console.log("🚀 Auth controller connected")
    this.initializeValidation()
    this.setupFormEnhancements()
  }

  /**
   * Called when the controller disconnects from the DOM
   * Clean up any event listeners or timers here
   */
  disconnect() {
    console.log("👋 Auth controller disconnected")
    this.cleanup()
  }

  // === INITIALIZATION METHODS ===

  /**
   * Initialize form validation
   * Set up real-time validation for all inputs
   */
  initializeValidation() {
    // Add validation classes to inputs
    if (this.hasEmailInputTarget) {
      this.emailInputTarget.classList.add("validation-enabled")
    }

    if (this.hasPasswordInputTarget) {
      this.passwordInputTarget.classList.add("validation-enabled")
    }

    if (this.hasPasswordConfirmationInputTarget) {
      this.passwordConfirmationInputTarget.classList.add("validation-enabled")
    }

    if (this.hasFirstNameInputTarget) {
      this.firstNameInputTarget.classList.add("validation-enabled")
    }
  }

  /**
   * Setup additional form enhancements
   * Add animations, focus management, etc.
   */
  setupFormEnhancements() {
    // Add focus ring animation
    this.addFocusEnhancements()

    // Enable enter key submission
    this.enableEnterKeySubmission()
  }

  // === VALIDATION METHODS ===

  /**
   * Validate email input in real-time
   * @param {Event} event - Input event from email field
   */
  validateEmail(event) {
    const email = event.target.value
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    if (email.length === 0) {
      this.clearValidationState(event.target)
    } else if (emailRegex.test(email)) {
      this.setValidState(event.target)
    } else {
      this.setInvalidState(event.target)
    }

    this.updateSubmitButtonState()
  }

  /**
   * Validate password input in real-time
   * @param {Event} event - Input event from password field
   */
  validatePassword(event) {
    const password = event.target.value
    const minLength = this.minPasswordLengthValue

    if (password.length === 0) {
      this.clearValidationState(event.target)
    } else if (password.length >= minLength) {
      this.setValidState(event.target)
    } else {
      this.setInvalidState(event.target)
    }

    // Also validate password confirmation if it exists
    if (this.hasPasswordConfirmationInputTarget) {
      this.validatePasswordConfirmation({ target: this.passwordConfirmationInputTarget })
    }

    this.updateSubmitButtonState()
  }

  /**
   * Validate password confirmation matches password
   * @param {Event} event - Input event from password confirmation field
   */
  validatePasswordConfirmation(event) {
    const confirmation = event.target.value
    const password = this.hasPasswordInputTarget ? this.passwordInputTarget.value : ""

    if (confirmation.length === 0) {
      this.clearValidationState(event.target)
    } else if (confirmation === password && password.length > 0) {
      this.setValidState(event.target)
    } else {
      this.setInvalidState(event.target)
    }

    this.updateSubmitButtonState()
  }

  /**
   * Validate first name input
   * @param {Event} event - Input event from first name field
   */
  validateFirstName(event) {
    const firstName = event.target.value.trim()

    if (firstName.length === 0) {
      this.clearValidationState(event.target)
    } else if (firstName.length >= 2) {
      this.setValidState(event.target)
    } else {
      this.setInvalidState(event.target)
    }

    this.updateSubmitButtonState()
  }

  // === FORM SUBMISSION METHODS ===

  /**
   * Handle login form submission
   * @param {Event} event - Click event from submit button
   */
  submitLoginForm(event) {
    console.log("📝 Submitting login form")

    // Prevent double submission
    this.disableSubmitButton()

    // Add loading state
    this.setLoadingState(true)

    // Let the form submit naturally
    // Rails will handle the actual submission
  }

  /**
   * Handle signup form submission
   * @param {Event} event - Click event from submit button
   */
  submitSignupForm(event) {
    console.log("📝 Submitting signup form")

    // Prevent double submission
    this.disableSubmitButton()

    // Add loading state
    this.setLoadingState(true)

    // Let the form submit naturally
    // Rails will handle the actual submission
  }

  // === UI STATE MANAGEMENT ===

  /**
   * Set input field to valid state
   * @param {HTMLElement} input - Input element to style
   */
  setValidState(input) {
    input.classList.remove("ring-red-400", "border-red-400")
    input.classList.add("ring-green-400", "border-green-400")
  }

  /**
   * Set input field to invalid state
   * @param {HTMLElement} input - Input element to style
   */
  setInvalidState(input) {
    input.classList.remove("ring-green-400", "border-green-400")
    input.classList.add("ring-red-400", "border-red-400")
  }

  /**
   * Clear validation state from input field
   * @param {HTMLElement} input - Input element to clear
   */
  clearValidationState(input) {
    input.classList.remove("ring-red-400", "border-red-400", "ring-green-400", "border-green-400")
  }

  /**
   * Update submit button state based on form validation
   */
  updateSubmitButtonState() {
    if (!this.hasSubmitButtonTarget) return

    const isFormValid = this.isFormValid()

    if (isFormValid) {
      this.submitButtonTarget.disabled = false
      this.submitButtonTarget.classList.remove("opacity-50", "cursor-not-allowed")
    } else {
      this.submitButtonTarget.disabled = true
      this.submitButtonTarget.classList.add("opacity-50", "cursor-not-allowed")
    }
  }

  /**
   * Check if the entire form is valid
   * @returns {boolean} True if form is valid
   */
  isFormValid() {
    // Basic validation - check if required fields have values
    if (this.hasEmailInputTarget && !this.emailInputTarget.value.trim()) {
      return false
    }

    if (this.hasPasswordInputTarget && !this.passwordInputTarget.value.trim()) {
      return false
    }

    // For signup form, also check password confirmation
    if (this.hasPasswordConfirmationInputTarget) {
      if (!this.passwordConfirmationInputTarget.value.trim()) {
        return false
      }

      if (this.passwordInputTarget.value !== this.passwordConfirmationInputTarget.value) {
        return false
      }
    }

    return true
  }

  /**
   * Disable submit button to prevent double submission
   */
  disableSubmitButton() {
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.disabled = true
      this.submitButtonTarget.classList.add("opacity-50", "cursor-not-allowed")
    }
  }

  /**
   * Set loading state for the form
   * @param {boolean} loading - Whether form is in loading state
   */
  setLoadingState(loading) {
    if (!this.hasSubmitButtonTarget) return

    if (loading) {
      this.submitButtonTarget.innerHTML = `
        <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
        </svg>
        Connexion...
      `
    }
  }

  // === ENHANCEMENT METHODS ===

  /**
   * Add focus enhancements to form inputs
   */
  addFocusEnhancements() {
    const inputs = [
      this.emailInputTarget,
      this.passwordInputTarget,
      this.passwordConfirmationInputTarget,
      this.firstNameInputTarget
    ].filter(input => input) // Remove undefined targets

    inputs.forEach(input => {
      input.addEventListener("focus", () => {
        input.parentElement.classList.add("scale-105")
      })

      input.addEventListener("blur", () => {
        input.parentElement.classList.remove("scale-105")
      })
    })
  }

  /**
   * Enable form submission with Enter key
   */
  enableEnterKeySubmission() {
    const form = this.hasLoginFormTarget ? this.loginFormTarget : this.signupFormTarget

    if (form) {
      form.addEventListener("keypress", (event) => {
        if (event.key === "Enter" && this.isFormValid()) {
          event.preventDefault()
          this.hasSubmitButtonTarget && this.submitButtonTarget.click()
        }
      })
    }
  }

  // === CLEANUP METHODS ===

  /**
   * Clean up any resources when controller disconnects
   */
  cleanup() {
    // Remove any event listeners that were added manually
    // Clear any timers or intervals
    console.log("🧹 Cleaning up auth controller")
  }
}
