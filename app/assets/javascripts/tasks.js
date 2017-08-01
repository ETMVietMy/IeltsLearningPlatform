jQuery.noConflict();

(function($) {
  $(document).on('turbolinks:load', function(){
    $('#js-new-suggestion').click(function(e) {
      e.preventDefault();
      var url = '/dashboard/tasks/suggest.js'
      $.getScript(url)
    });
  })
})(jQuery)