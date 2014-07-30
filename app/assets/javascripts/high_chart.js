function highChart(data) {
  console.log(data);
    $('#container').highcharts({
        chart: {
            type: 'spline'
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
                text: 'Tweet Sentiment',

            },
            opposite: true,
        },{
        title: {
            text: 'Price',
            }
        },{
        title: {
            text: 'Volume',
            }
        }],
        tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x:%e. %b}: {point.y:.2f} m',
            shared: true
        },
        series: [{
            name: 'Tweet Sentiment',
            data: data.tweets,
            yAxis: 1
        }, {
            name: 'Price',
            data: data.prices,
            yAxis: 2
        }, {
            name: 'Volume',
            data: data.volume,
            type: 'column'
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
