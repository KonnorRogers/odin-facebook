class Notifications
  constructor: ->
    @notifications = document.querySelector("[data-behavior='notifications']")
    @setup()

  setup: ->
    console.log(@notifications)

document.addEventListener "turbolinks:load", ->
  new Notifications

