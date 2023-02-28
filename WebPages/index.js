// Fetch GET request that checks response is JSON


// var ChartsData = document.getElementById("charts-data");

function newvalueGotFromIOS(ticker) {
    var myarr
    var temp = []
    const element = document.getElementById('charts-area');
    fetch('https://backend-hw8-ss.uw.r.appspot.com/getDailyChartsData?ticker='+ticker+'&timeInterval=5&toTime=1651176000')
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
            console.log(myarr)
            


            let dip = false
            // myarr['c'].map((value:var, idx:any)=>{
            //     dailyChartsData.push([+this.dailyChartsData['t'][idx]*1000, value]);
            //   })
            
            for(var i=0; i<myarr["t"].length;i++){
                temp.push([myarr["t"][i]*1000, myarr["c"][i]])
                // myarr["t"][i] = myarr["t"][i]*1000
                // console.log("data2",myarr["t"][i])
            }

            console.log("data",(temp))

    Highcharts.stockChart('container',{

        time: {
            timezoneOffset: new Date().getTimezoneOffset()
          },
          
       
        title: {
          text: ticker+" Hourly Price Variation"
        },
        plotOptions:{},
        xAxis: {
          type: 'datetime',
          crosshair: true
        },
        yAxis: {
          opposite: true
         
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
          name: "AAPL",
          marker: {
            enabled: false
          },
        //   color: !dip ? "var(--bs-success)" : "var(--bs-danger)",
          
        }],
        
    })








            
            // document.getElementById('charts-area').innerHTML = data?.data["c"];
        })
        .catch(error => {
            // element.parentElement.innerHTML = `Error: ${error}`;
            console.error('There was an error!');
        });

        }









