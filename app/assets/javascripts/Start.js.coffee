# Using Javascipts for the application
window.Scheduler = do ->

  # Starts the required javascripts
  init: ->
    Scheduler.Home.init()

$(Scheduler.init)