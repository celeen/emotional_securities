function highChart(data) {
  console.log(data);
    $('#container').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: 'Market Feelz And your moneys'
        },
        subtitle: {
            text: 'watch the emo secs'
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                hour: '%H:%M',
                ///day: '%a',
                //month: '%e1 %b',
                //year: '%b'
            },
            title: {
                text: 'Date'
            },
            max: Date.now(),
            min: Date.now() - 86400000,
        },
        yAxis: [{
            title: {
                text: 'Tweet Sentiment',

            },
            min: -1,
            max: 1,
            opposite: true,
        },{
        title: {
            text: 'Price',
            }
        },
        // {
        // title: {
        //     text: 'Volume',
        //     }
        // }
        ],
        tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x:%e. %b}: {point.y:.2f} m',
            shared: true
        },
        series: [{
            name: 'Tweet Sentiment',
            data: data.tweets,
            id: 'primary',
            type: 'scatter',
            // yAxis: 1
        }, {
            connectNulls:true,
            name: 'Exponential Moving Average',
            linkedTo: 'primary',
            showInLegend: true,
            type: 'trendline',
            algorithm: 'EMA',
            periods: 50
        },
         {
            name: 'Price',
            data: data.prices,
            yAxis: 1
        }],
        plotOptions: {
            scatter: {
                marker: {
                    radius: 1,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: 'rgb(100,100,100, .5)'
                        }
                    }
                }
            }
        }
        // {
        //     name: 'Volume',
        //     data: data.volume,
        //     type: 'column'
        // }]
    });
}

$(document).ready(function() {
    var chart, volume, prices, tweetSentiment, articleSentiment, stockData;


    $.post('/chart_data', function(response) {
        stockData = response;
        highChart(stockData);
        console.log(stockData.tweets)
    }, 'json');

    // $.post('/chart_data', function(response) {
    //     stockData = response;
    //     stockChart(stockData);
    // }, 'json');


    // $.post('/box_data', function(response) {
    //     boxData = response;
    //     populateBoxes(boxData);
    // }, 'json');

});
