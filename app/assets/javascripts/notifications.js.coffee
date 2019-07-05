class Notifications
  constructor: ->
    @notifications = document.querySelector("[data-behavior='notifications']")
    # @setup() if @notifications.length > 0
    # @setup()

  setup: ->
    console.log(@notifications)

notifications = ->
  document.querySelector("[data-behavior='notifications']")

document.addEventListener("DOMContentLoaded", notifications)

