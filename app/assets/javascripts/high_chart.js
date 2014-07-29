function highChart(data) {
  console.log(data);
    $('#container').highcharts({
        chart: {
            type: 'spline'
        },
        title: {
            text: 'Sentiment And your moneys'
        },
        subtitle: {
            text: 'watch the emo secs'
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                ///day: '%a',
                //month: '%e1 %b',
                //year: '%b'
            },
            title: {
                text: 'Date'
            }
        },
        yAxis: [{
            title: {
                text: 'Snow depth (m)'
            }
        },{
        title: {
            text: 'Price',
            }
        }
        ],
        tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x:%e. %b}: {point.y:.2f} m'
        },
        series: [{
            name: 'Tweet Sentiment',
            data: data.tweets,
            yAxis: 1
        }, {
            name: 'Price',
            data: data.prices
        }, {
            name: 'Volume'
            // data: [
            //     [Date.UTC(1970,  9,  9), 0   ],
            //     [Date.UTC(1970,  9, 14), 0.15],
            //     [Date.UTC(1970, 10, 28), 0.35],
            //     [Date.UTC(1970, 11, 12), 0.46],
            //     [Date.UTC(1971,  0,  1), 0.59],
            //     [Date.UTC(1971,  4, 21), 0   ]
            // ]
        }]
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
