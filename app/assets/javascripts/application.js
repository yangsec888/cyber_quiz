//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap-select
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require_tree .

var jumboHeight = $('.jumbotron').outerHeight();
function parallax(){
    var scrolled = $(window).scrollTop();
    $('.bg').css('height', (jumboHeight-scrolled) + 'px');
}

$(window).scroll(function(e){
    parallax();
});

// Flash alert Management
$(document).ready(function(){
  function fadeAlert(){
    $('.alert-temp').removeClass('in');
  }

  function removeAlert(){
    $('.alert-temp').remove();
  }

  window.setTimeout(fadeAlert,5000);
  window.setTimeout(removeAlert,5000);

  // Popover Management
  $(function () {
    $("[data-toggle='popover']").popover({html:true});
  });

});
