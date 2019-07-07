class Notifications
  constructor: ->
    @notifications()
    @setup()

  notifications: ->
    document.querySelector("[data-behavior='notifications']")
  setup: ->
    console.log(@notifications)

document.addEventListener("turbolinks:load", () =>
  new Notifications)


