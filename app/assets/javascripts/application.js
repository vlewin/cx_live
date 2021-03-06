// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

//= require_tree .

$(document).ready(function() {
  console.log( "ready!" );


  $("#menu-toggle").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
  });


  $(document).on('click', '.show-spinner', function () {
    if($($(this).parents('form'))[0].checkValidity() === true) {
      $('.fa-spinner').toggleClass('hidden');
    }
  });

  $(document).popover({
    html: true,
    trigger:'hover',
    placement: 'auto',
    selector: '.img-square',
    content: function () {
      return '<img src="'+$(this).data('img') + '" />';
    }
  });


  $(document).on('ajax:complete', '*[data-remote="true"]', function (data, xhr, status) {
    $('.fa-spinner').removeClass('hidden');

    var target = $(this).data('target');
    var handler = $(this).data('handler');

    if(target === undefined) {
      console.warn('Please set data-target attribute on "' + $(this).text() + '" link');
    } else {
      if(handler === undefined) {
        $(target).html(xhr.responseText);
      } else {
        $(target)[handler](xhr.responseText);
      }
    }

    $('.fa-spinner').addClass('hidden')
  });

});
