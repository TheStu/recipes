# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.day-select-area').hide()
  $('.name-input-area').hide()
  days = $('#day_id').html()
  $('#meal_plan_id').change ->
    meal_plan = $('#meal_plan_id :selected').text()
    escaped_meal_plan = meal_plan.replace(/([ #;&,.+*~\':"!^$[\]()=>||/@])/g, '\\$1')
    options = $(days).filter("optgroup[label='#{escaped_meal_plan}']").html()
    if options
      $('#day_id').html(options)
      $('.day-select-area').show()
      $('.name-input-area').show()
    else
      $('#day_id').empty()
      $('.day-select-area').hide()
      $('.name-input-area').hide()
