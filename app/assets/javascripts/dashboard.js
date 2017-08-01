jQuery.noConflict();
(function($) {
  $(document).on('turbolinks:load', function(){
    if ($('#student_chart').length > 0){
      var myChart = Highcharts.chart('student_chart', {
        chart: {
          type: 'line'
        },
        title: {
          text: 'Your writings in the last week'
        },
        xAxis: {
          categories: writings.map(function(item){ return item.date })
        },
        yAxis: {
          title: {
            text: 'Writings'
          }
        },
        series: [{
          name: "Writings",
          data: writings.map(function(item){ return item.value })
        }]
      });
    }
  })
})(jQuery)