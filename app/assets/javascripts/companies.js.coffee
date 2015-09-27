# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Application ||= {}

# Hide filters on load
#window.onload = () ->
#  $("#company_filters").hide()

# Toggle Filter Visibility
$(document).on 'click', '#filter_toggle_link', () ->
  if $("#company_filters").is(":visible")
    $("#company_filters").hide()
    $("#filter_toggle_link").text("Show Company Filters")
  else
    $("#company_filters").show()
    $("#filter_toggle_link").text("Hide Company Filters")

# Filter for every added character
$(document).on 'keyup', '.filter_results', () ->
  
  $('#company_table > tbody > tr').each (i, row) ->
    
    name_query = $('#filter_results_name').val().toLowerCase()
    name_field = $(this).find('td:eq(0)').text().trim().toLowerCase()
    
    status_query = $('#filter_results_status').val().toLowerCase()
    status_field = $(this).find('td:eq(1)').text().trim().toLowerCase()
    
    updated_year_query = $('#filter_updated_year').val()
    updated_month_query = $('#filter_updated_month').val()
    updated_day_query = $('#filter_updated_day').val()
    updated_query = updated_year_query
    if updated_month_query
      updated_query = updated_year_query + '-' + updated_month_query
    if updated_day_query
      updated_query = updated_query + '-' + updated_day_query
    updated_field = $(this).find('td:eq(2)').text().trim()
    
    location_query = $('#filter_results_location').val().toLowerCase()
    location_field = $(this).find('td:eq(3)').text().trim().toLowerCase()
    
    min_size_query = $('#filter_results_size_min').val()
    min_size_field = $(this).find('td:eq(4)').text().trim()
    max_size_query = $('#filter_results_size_max').val()
    max_size_field = $(this).find('td:eq(4)').text().trim()

    # Show all rows by default, and then hide upon fitler violation
    $(this).show()

    if name_field and not name_field.match(name_query)
      $(this).hide()
    else if status_query and not status_field.match(status_query)
      $(this).hide()
    else if updated_year_query and compare_date(updated_query, updated_field)
      $(this).hide()
    else if location_query and not location_field.match(location_query)
      $(this).hide()
    else if min_size_query and parseInt(min_size_field) < parseInt(min_size_query)
      $(this).hide()
    else if max_size_query and parseInt(max_size_field) > parseInt(max_size_query)
      $(this).hide()


compare_date = (date1, date2) ->
  return new Date(date1) > new Date(date2)
