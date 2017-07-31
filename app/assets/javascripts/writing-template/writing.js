jQuery.noConflict();
(function($) {
  var zp = function(n,c) { 
    var s = String(n); 
    if (s.length< c) { return zp("0" + n,c) } 
    else { return s } 
  };

  $(document).on('turbolinks:load', function(){
    var data = {
      second: 0,
      percentage: 0
    }
    Vue.component('timer', {
      props: ['taskNum'],
      template: '#writing_timer_template',
      data: function(){
        let max = this.taskNum == 1 ? (20 * 60) : (40 * 60);
        return Object.assign({}, data, {
          max: max
        })
      },
      mounted: function(){
        console.log('component created');
        this.scheduleTimer();
      },
      methods: {
        scheduleTimer: function(){
          setInterval(this.increaseTime, 1000);
        },
        increaseTime: function(){
          this.second += 1;
          this.percentage = this.second / this.max * 100
          this.percentage = this.percentage > 100 ? 100 : this.percentage;
          // console.log('####');
          // console.log(this.max);
          // console.log(this.second);
        },
        calcTime: function(){
          let m = parseInt(this.second / 60);
          let s = this.second % 60;

          return zp(m, 2)+ ':' + zp(s, 2);
        }
      }
    })

    new Vue({
      el: '#writing_form'
    })
  })
})(jQuery);