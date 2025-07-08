// app/javascript/controllers/auth_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "loginForm",
    "signupForm",
    "emailInput",
    "passwordInput",
    "passwordConfirmationInput",
    "firstNameInput",
    "submitButton",
    "rememberCheck",
    "errors"
  ]

  static values = {
    minPasswordLength: { type: Number, default: 6 }
  }

  connect() {
    console.log("🎨 Auth controller connected")
    this.initializeValidation()
  }

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

    if (this.hasPasswordConfirmationInputTarget) {
      this.validatePasswordConfirmation({ target: this.passwordConfirmationInputTarget })
    }
    this.updateSubmitButtonState()
  }

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

  submitLoginForm(event) {
    console.log("🔐 Submitting login form")
    this.setLoadingState()
  }

  submitSignupForm(event) {
    console.log("📝 Submitting signup form")
    this.setLoadingState()
  }

  setValidState(input) {
    input.classList.remove("field-invalid")
    input.classList.add("field-valid")
  }

  setInvalidState(input) {
    input.classList.remove("field-valid")
    input.classList.add("field-invalid")
  }

  clearValidationState(input) {
    input.classList.remove("field-valid", "field-invalid")
  }

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

  isFormValid() {
    if (this.hasEmailInputTarget && !this.emailInputTarget.value.trim()) {
      return false
    }

    if (this.hasPasswordInputTarget && !this.passwordInputTarget.value.trim()) {
      return false
    }

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

  setLoadingState() {
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.disabled = true
      this.submitButtonTarget.innerHTML = "Chargement..."
    }
  }

  initializeValidation() {
    const inputs = [
      this.emailInputTarget,
      this.passwordInputTarget,
      this.passwordConfirmationInputTarget,
      this.firstNameInputTarget
    ].filter(input => input)

    inputs.forEach(input => {
      input.classList.add("auth-input")
    })
  }
}
