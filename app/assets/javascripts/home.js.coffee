# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

Scheduler.Home = do ->
  _handleBookingSubmit = (event) ->
    user_id = $('#bookingUserId').val()
    vcon = $('#bookingVCONReq').is(':checked')
    near = $('#bookingNearReq').is(':checked')
    double_res = $('#bookingDoubleResourceReq').is(':checked')
    from_hrs = $('#bookingFromHrs').val()
    from_mins = $('#bookingFromMins').val()
    from_am_pm = $('#bookingFromAMPM').val()
    to_hrs = $('#bookingToHrs').val()
    to_mins = $('#bookingToMins').val()
    to_am_pm = $('#bookingToAMPM').val()
    date = $('#bookingDate').val()
    $.ajax(
        url: $(@).data('url'),
        type: 'POST',
        dataType: 'json',
        data: { usage: { user_id: user_id, vcon: vcon, near: near,\
                        near: near, double_res: double_res, from_hrs: from_hrs,\
                        from_mins: from_mins, from_am_pm: from_am_pm, to_hrs: to_hrs,\
                        to_mins: to_mins, to_am_pm: to_am_pm, date: date } }
        success: _handleBookingSuccess
      )

  _handleBookingSuccess = (data) ->
    if data.result
      alert data.content
      $('#bookingErrorSection').html('')
      _resetFormItems()
      location.reload()
    else
      $('#bookingErrorSection').html(data.content)

  _handleBookingCancel = (event) ->
    _resetFormItems

  _resetFormItems = ->
    $('#bookingUserId').val(1)
    $('#bookingVCONReq').attr('checked', false)
    $('#bookingNearReq').attr('checked', false)
    $('#bookingDoubleResourceReq').attr('checked', false)
    $('#bookingFromHrs').val(1)
    $('#bookingFromMins').val(0)
    $('#bookingFromAMPM').val(1)
    $('#bookingToHrs').val(1)
    $('#bookingToMins').val(0)
    $('#bookingToAMPM').val(1)

  init: ->
    _resetFormItems()
    $('#bookingSubmit').click(_handleBookingSubmit)
    $('#bookingCancel').click(_handleBookingCancel)
