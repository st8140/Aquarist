//= require jquery
//= require popper
//= require bootstrap
//= require_tree .

'use strict';
// ------------------------------------------ navbar ------------------------------------------ //

$(document).on('turbolinks:load', function(){
  $('#user-nav-pc li a').each(function(){
      var $href = $(this).attr('href');
      if(location.href.match($href)) {
        $(this).addClass('active');
      } else {
        $(this).removeClass('active');
      }
  });

  $('#user-nav-sp li a').each(function(){
      var $href = $(this).attr('href');
      if(location.href.match($href)) {
        $(this).addClass('active');
      } else {
        $(this).removeClass('active');
      }
  });
});

