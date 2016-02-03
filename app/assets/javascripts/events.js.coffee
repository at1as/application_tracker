
# Initialize Date Picker for Date field
 $(document).on "focus", "[data-behaviour~='datepicker']", (e) ->
  $(this).datepicker
    format: "yyyy-mm-dd"
    weekStart: 1
    todayHighlight: true
    autoclose: true


 $(document).on 'ready page:load', () ->

  # On page load Populate start and end time field with 15 minute increments
  $('#event_start_time').timepicker noneOption: 'N/A', step: 15, forceRoundTime: true
  $('#event_end_time').timepicker noneOption: 'N/A', step: 15, forceRoundTime: true

  # On page load, if start time is empty, make end time read only
  if $('#event_start_time').val() == ''
    $("#event_end_time").val ''
    $("#event_end_time").prop "readonly", true
  
  # If a value is selected for start time, make end time writeable
  $('#event_start_time').on 'changeTime', () ->
    if $('#event_start_time').val() != ''
      $('#event_end_time').prop 'readonly', false
      $('#event_end_time').val ''
      $('#event_end_time').timepicker 'option', 'showDuration', true
      $('#event_end_time').timepicker 'option', 'minTime', $('#event_start_time').val()
      $('#event_end_time').timepicker 'option', 'scrollDefault', $('#event_start_time').val()
    else
      $('#event_end_time').val ''
      $('#event_end_time').prop 'readonly', true

