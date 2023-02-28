// Fetch GET request that checks response is JSON


// var ChartsData = document.getElementById("charts-data");



      function InsightsChart(ticker){
      var myarr



      const element = document.getElementById('charts-area');
      fetch('https://backend-hw8-ss.uw.r.appspot.com/getInsightsRecommendation?ticker='+ticker)
          .then(async response => {
              const isJson = response.headers.get('content-type')?.includes('application/json');
              const data = isJson ? await response.json() : null;
    
              if (!response.ok) {
                  const error = (data && data.message) || response.status;
                  return Promise.reject(error);
              }
              
              myarr = data?.data

            
              var xAxisName = []
              var strongBuy = []
              var buy = []
              var hold = []
              var sell = []
              var strongSell = []
              for(var i=0; i<myarr.length;i++){
                xAxisName.push( [ myarr[i]["period"].substring(0, myarr[i]['period'].lastIndexOf('-'))])
                strongBuy.push([ myarr[i]['strongBuy']])
                buy.push([ myarr[i]['buy']])
                hold.push(myarr[i]['hold'])
                sell.push(myarr[i]['sell'])
                strongSell.push(myarr[i]['strongSell'])

              }
    

    
      Highcharts.chart('container',{

        responsive: {
          rules: [{
              condition: {
                  maxWidth: 600
              },
              chartOptions: {
                  legend: {
                    verticalAlign: 'bottom',
                      align: 'center',
                      layout: 'horizontal'
                  }
              }
          }]
      },
      
        chart: {
          type: 'column',
        },
        plotOptions: {
          column: {
            
            dataLabels: {
              enabled: true
            },
            stacking: 'normal'
          }
        },
        series: [
      
          {data: strongBuy, type: 'column', name: 'Strong Buy', color:'#186E37'},
          {data: buy, type: 'column', name: 'Buy', color:'#1BB954'},
          {data: hold, type: 'column', name: 'Hold', color:'#B98B1D'},
          {data: sell, type: 'column', name: 'Sell', color:'#F45A5A'},
          {data: strongSell, type: 'column', name: 'Strong Sell', color:'#803131'}
        ],
       
        xAxis: {
          categories: xAxisName,
          labels: {
             format: '{value}'}
        },
        yAxis: {
          title: {
            text: '#Analysis',
            align:'high'
          },
          
        },
        title: {
          text: 'Recommendation Trends'
        },  
      }
      )
    
          })
        }


