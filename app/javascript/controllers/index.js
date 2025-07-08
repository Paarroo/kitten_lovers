// Import and register all of your controllers from the importmap under controllers/*

import { application } from "./application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import SessionsController from "./sessions_controller"
import RegistrationsController from "./registrations_controller"
import PasswordsController from "./passwords_controller"
import HelloController from "./hello_controller"


// Register controllers manually
application.register("sessions", SessionsController)
application.register("registrations", RegistrationsController)
application.register("passwords", PasswordsController)
application.register("hello", HelloController)


import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
console.log("📦 Stimulus controllers registered:", {
  sessions: SessionsController,
  registrations: RegistrationsController,
  passwords: PasswordsController,
  hello: HelloController
})

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
