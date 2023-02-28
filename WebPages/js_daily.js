
function DailyCharts(ticker, change, timestamp) {
  var myarr
  var temp = []
    var mycolor = ""
    console.log("heloo")
    var curr = Math.floor(Date.now()/1000)

    var final_ts = 0
      if ((curr-timestamp)<3600)
      {
        final_ts = curr
      }
      else{
        final_ts = timestamp
      }

      if (change==0.00){
        mycolor = "gray"
      }
      else if(change>0.00){
        mycolor = "green"
      }
      else{
        mycolor = "red"
      }

  const element = document.getElementById('charts-area');
  fetch('https://backend-hw8-ss.uw.r.appspot.com/getDailyChartsData?ticker='+ticker+'&timeInterval=5&toTime='+final_ts)
      .then(async response => {
          const isJson = response.headers.get('content-type')?.includes('application/json');
          const data = isJson ? await response.json() : null;


          if (!response.ok) {

              const error = (data && data.message) || response.status;
              return Promise.reject(error);
          }

          myarr = data?.data


          for(var i=0; i<myarr["t"].length;i++){
              temp.push([myarr["t"][i]*1000, myarr["c"][i]])

          }


  Highcharts.stockChart('container',{




      title: {
        text: ticker+" Hourly Price Variation"
      },
      time: {
        timezoneOffset: new Date().getTimezoneOffset()
      },
      plotOptions:{},
      yAxis: {
        opposite: true

      },
      xAxis: {
        type: 'datetime',
        crosshair: true
      },

      legend:{
        enabled: false
      },
      navigator: {
        enabled: false
      },
      rangeSelector: {
        enabled: false
      },
      tooltip:{
        split:true
      },
      series: [{
        data: temp,
        type: 'line',
        name: ticker,
        marker: {
          enabled: false
        },
         color: mycolor

      }],

  })
      })
      .catch(error => {
          console.error('There was an error!');
      });

      }








