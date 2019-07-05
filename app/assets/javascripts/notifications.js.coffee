class Notifications
  constructor: ->
    @notifications = document.getElementById("notifications")
    @setup()

  setup: ->
    console.log(@notifications)

document.addEventListener("DOMContentLoaded", new Notifications)

