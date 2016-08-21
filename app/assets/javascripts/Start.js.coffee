# Using Javascipts for the application
window.Scheduler = do ->

  closeError: (divToClose) ->
    $(divToClose).parent().html('')

  # Starts the required javascripts
  init: ->
    if $('#bookingFromDate').length > 0
      calendar = new dhtmlXCalendarObject(['bookingFromDate', 'bookingToDate'])
      calendar.setSkin('dhx_skyblue')
      calendar.setDateFormat('%Y-%m-%d %h:%i%A')
      calendar.setDate(new Date())
    Scheduler.Home.init()

$(Scheduler.init)