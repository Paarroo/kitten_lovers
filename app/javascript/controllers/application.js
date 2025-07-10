import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application


// app/javascript/controllers/application.js

import { Application } from "@hotwired/stimulus"

// Import all controllers automatically
import SessionsController from "./sessions_controller"
import RegistrationsController from "./registrations_controller"
import PasswordsController from "./passwords_controller"

const application = Application.start()

// Register controllers manually to ensure they're loaded
application.register("sessions", SessionsController)
application.register("registrations", RegistrationsController)
application.register("passwords", PasswordsController)
export { application }
