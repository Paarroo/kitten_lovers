import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log(" Hello controller connected successfully!")
    console.log(" Stimulus is working!")
  }
}

// Register it manually for testing
if (window.Stimulus) {
  window.Stimulus.register("hello", class extends Controller {
    connect() {
      console.log(" Hello controller connected via window.Stimulus!")
    }
  })
}
