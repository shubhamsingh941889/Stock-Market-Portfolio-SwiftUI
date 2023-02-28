

      function HistoricalChart(ticker){
      var myarr
      
      const element = document.getElementById('charts-area');
      fetch('https://backend-hw8-ss.uw.r.appspot.com/getHistoricalCharts?ticker='+ticker)
          .then(async response => {
              const isJson = response.headers.get('content-type')?.includes('application/json');
              const data = isJson ? await response.json() : null;
    
              // check for error response
              if (!response.ok) {
                  // get error message from body or default to response status
                  const error = (data && data.message) || response.status;
                  return Promise.reject(error);
              }
              
              myarr = data?.data
            
              var ohlc = []
              var volume = []
              for(var i=0; i<myarr["t"].length;i++){

                ohlc.push([myarr["t"][i]*1000, myarr["o"][i], myarr["h"][i], myarr["l"][i], myarr["c"][i]])
                volume.push([myarr["t"][i]*1000, myarr["v"][i]])

              }
    

    
      Highcharts.stockChart('container',{
        chart:{
          reflow:true,
        },
        title: {
          text: ticker+ ' Historical',
        },

        rangeSelector: {
          selected: 2,
        },
    
        
        subtitle: {
          text: 'With SMA and Volume by Price technical indicators',
        },
        plotOptions: {
          series: {
            dataGrouping: {
              units: [
                ['day', [1]],
                ['week', [1]],
              ],
            },
          },
        },
        yAxis: [
          {
            startOnTick: false,
            endOnTick: false,
            labels: {
              align: 'right',
              x: -3,
            },
            title: {
              text: 'OHLC',
            },
            height: '60%',
            lineWidth: 2,
            resize: {
              enabled: true,
            },
          },
          {
            labels: {
              align: 'right',
              x: -3,
            },
            title: {
              text: 'Volume',
            },
            top: '65%',
            height: '35%',
            offset: 0,
            lineWidth: 2,
          },
        ],
    
        tooltip: {
          split: true,
        },
    
        
    
        series: [
          {
            type: 'candlestick',
            name: ticker,
            id: ticker,
            zIndex: 2,
            data: ohlc,
          },
          {
            type: 'column',
            name: 'Volume',
            id: 'volume',
            data: volume,
            yAxis: 1,
          },
          {
            type: 'vbp',
            linkedTo:ticker,
            params: {
              volumeSeriesID: 'volume',
            },
            dataLabels: {
              enabled: false,
            },
            zoneLines: {
              enabled: false,
            },
          },
          {
            type: 'sma',
            linkedTo:ticker,
            zIndex: 1,
            marker: {
              enabled: false,
            },
          },
        ]
      })
    
          })
        }

    




