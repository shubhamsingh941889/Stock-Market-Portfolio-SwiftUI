
      function EPSChart(ticker){
      var myarr

      var temp = []

      const element = document.getElementById('charts-area');
      fetch('https://backend-hw8-ss.uw.r.appspot.com/getCompanyEPSChart?ticker='+ticker)
          .then(async response => {
              const isJson = response.headers.get('content-type')?.includes('application/json');
              const data = isJson ? await response.json() : null;
    
              if (!response.ok) {
                  const error = (data && data.message) || response.status;
                  return Promise.reject(error);
              }
              
              myarr = data?.data

              var estimate = []
              var actual = []
              var surprise = []
              var xAxisName = []
              
              for(var i=0; i<myarr.length;i++){
                xAxisName.push( [ myarr[i]["period"]+'<br/>Surprise: '+String( myarr[i]["surprise"] )])
                estimate.push([ i, myarr[i]['estimate']])
                actual.push([ i, myarr[i]['actual']])
                surprise.push(myarr[i]['surprise'])

              }
    
      Highcharts.chart('container',{

        responsive: {
          rules: [{
              condition: {
                  maxWidth: 590
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
          type: 'spline',
          
          
        },
        plotOptions: {
          spline: {
              marker: {
                  enabled: true
              }
          }
        },
        series: [
          {data:actual, type: 'spline', name:'Actual'},
           {data:estimate, type: 'spline', name:'Estimate'}
          ],
        title: {
          text: 'Historical EPS Surprises'
        },
        yAxis: {
          title: {
            text: 'Quantity EPS',
            align:'middle'
          },
         
          
        },
        xAxis: 
          {categories: xAxisName, 
          
          },
        
        tooltip: {
          shared:true
          
          
      }
      
        
      }
      )
    
          })
        }




