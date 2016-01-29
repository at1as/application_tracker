
 $(document).on "focus", "[data-behaviour~='datepicker']", (e) ->
  $(this).datepicker
    format: "yyyy-mm-dd"
    weekStart: 1
    todayHighlight: true
    autoclose: true
