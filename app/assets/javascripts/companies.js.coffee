# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Application ||= {}

# Start listener for keypress in company_filters on page load
$(document).on 'ready page:load', () ->
  $(document).on 'keyup', '#company_filters', (event) ->
    filter_form(event)


# Clear all Filters
$(document).on 'click', '#clear_filters', () ->

  # Block filtering while fields are being cleared
  $(document).off 'keyup', '#company_filters'
  $('#company_filters').find("input[type=search], input[type=number], textarea").val('')

  # Send query without payload to clear filters
  $.ajax
    type: "GET"
    url: $('#company_filters').attr("action")
    success: (data) ->
      $("#company_index_listing").html(data)
  
  # Re-enable filtering and repopulate document
  $(document).on 'keyup', '#company_filters', (event) ->
    filter_form(event)
  

# Toggle Filter Visibility
$(document).on 'click', '#filter_toggle_link', () ->
  if $("#company_filters").is(":visible")
    $("#company_filters").hide()
    $("#filter_toggle_link").text("Show Company Filters")
  else
    $("#company_filters").show()
    $("#filter_toggle_link").text("Hide Company Filters")


# Filter results shown
filter_form = (event) ->

  # Ignore Tab, Shift, Ctrl, Arrow (left, up, right, down)
  if event.keyCode in [9, 16, 17, 37, 38, 39, 40]
    return

  # Block all other keyup events while filtering
  $(document).off 'keyup', '#company_filters'
  
  # Form submission event listener 
  $('form#company_filters').submit (event) ->
    dataSet = $(this).serialize()
  
    $.ajax
      type: "GET"
      url: $(this).attr("action")
      data: dataSet
      success: (data) ->
        $("#company_index_listing").html(data)

  # Force submit form and then deactive listener
  $('form#company_filters').submit()
  $('form#company_filters').off 'submit'
  
  # Reactive Event listener for keypress in company_filter form
  $(document).on 'keyup', '#company_filters', (event) ->
    filter_form(event)
 
