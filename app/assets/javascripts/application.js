//= require jquery
//= require jquery3
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
// ------------------------------------------ alert ------------------------------------------ //

document.addEventListener('DOMContentLoaded', function() {
  var deleteAlert = document.getElementById('account-delete');
  if (!deleteAlert){ return false;}
  deleteAlert.addEventListener('click', function() {
      var result = window.confirm('アカウントを削除しますか？');
      if( result ) {
        window.confirm('本当に削除しますか？')
      } else {
        window.confirm("キャンセルしました。")
      }
    });
});


