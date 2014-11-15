# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("body").on "change", "select.tag", (event) ->
    $select = undefined
    $select = $(this)
    $.get $select.data("source"),
      tag: $select.val()
    , (data) ->
      $select.parent(".filter").find(".value").html data


