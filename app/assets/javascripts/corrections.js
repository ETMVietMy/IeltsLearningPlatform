//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery.noConflict();
(function($) {
  $(document).on('turbolinks:load', function(){
    $('.editor').froalaEditor({height: 300});
  });
})(jQuery)
