# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("body").on "click", ".filter select", (event) ->
    $select = $(this)
    $.get $select.data("source"), tag: $select.val(), (data) ->
      $select.parent('.filter').find('.value').html data
      return
    return
  return
