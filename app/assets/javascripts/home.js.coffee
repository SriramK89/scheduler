# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

Scheduler.Home = do ->
  _handleBookingSubmit = (event) ->
    user_id = $('#bookingUserId').val()
    vcon = $('#bookingVCONReq').is(':checked')
    near = $('#bookingNearReq').is(':checked')
    double_res = $('#bookingDoubleResourceReq').is(':checked')
    from_date = $('#bookingFromDate').val()
    to_date = $('#bookingToDate').val()
    $.ajax(
        url: $(@).data('url'),
        type: 'POST',
        dataType: 'json',
        data: { usage: { user_id: user_id, vcon: vcon, near: near,\
                        near: near, double_res: double_res,\
                        from_date: from_date, to_date: to_date } }
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
    _resetFormItems()

  _resetFormItems = ->
    $('#bookingUserId').val(1)
    $('#bookingVCONReq').attr('checked', false)
    $('#bookingNearReq').attr('checked', false)
    $('#bookingDoubleResourceReq').attr('checked', false)
    date = Scheduler.Home.formatDateTime(new Date())
    $('#bookingFromDate').val(date)
    $('#bookingToDate').val(date)

  formatDateTime: (date) ->
    d = date.getDate()
    m = date.getMonth() + 1
    y = date.getFullYear()
    hr = date.getHours()
    min = date.getMinutes()
    if m <= 9
      m = '0' + m
    if d <= 9
      d = '0' + d
    if hr < 12
      ampm = 'AM'
    else
      hr = hr - 12
      ampm = 'PM'
    if hr <= 9
      hr = '0' + hr
    if min <= 9
      min = '0' + min
    return "#{y}-#{m}-#{d} #{hr}:#{min}#{ampm}"

  init: ->
    _resetFormItems()
    $('#bookingSubmit').click(_handleBookingSubmit)
    $('#bookingCancel').click(_handleBookingCancel)
