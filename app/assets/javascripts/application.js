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

  $('.img-square').popover({
    html: true,
    trigger: 'hover',
    content: function () {
      return '<img src="'+$(this).data('img') + '" />';
    }
  });

  // $(document).on('ajax:before', 'a[data-remote="true"]', function () {
  //   $('#spinner').toggleClass('hidden')
  // })

  $(document).on('ajax:complete', '*[data-remote="true"]', function (data, xhr, status) {
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
  //   // $('#spinner').toggleClass('hidden')
  //   return false
  })

});
