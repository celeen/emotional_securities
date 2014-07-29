Array.max = function(array) {
    return Math.max.apply(Math, array);
}

Array.min = function(array) {
    return Math.min.apply(Math, array);
}

function stockChart(data) {
    console.log(data)
    chart = c3.generate({
        size: {
            height: 550,
        },
        data: {
            x: 'dates',
            json: {
                dates: data.dates,
                tweetSentiment: data.tweetSentiments,
                prices: data.prices,
                volume: data.volume,
            },
            axes: {
                tweetSentiment: 'y',
                prices: 'y2',
                volume: 'y2'
            },
            types: {
                prices: 'spline',
                tweetSentiment: 'spline',
                volume: 'bar'
            },
        },
        subchart: {
            show: true
        },
        axis: {
            x: {
                type: 'timeseries',
                tick: {
                    count: 4,
                    format: '%m/%d/%y'
                },
            },
            y: {
                label: "Sentiment",
                min: -1,
                max: 1,
            },
            y2: {
                label: "Share Price",
                show: true,
                padding: {
                    top: Array.max(data.prices) * .01,
                    bottom: Array.min(data.prices) * .01
                },
            },
            y3: {
                show: true
            }
        },
        tooltip: {
            format: {
                title: function(d) {
                    return 'Data ' + d;
                },
                value: function(value, ratio, id) {
                    var format = id === 'prices' ? d3.format('$') : d3.format('.');
                    return format(value);
                }
            }
        }
    });
    chart.hide('volume');
}

function populateBoxes(boxData) {
    console.log(boxData);
    $(".1").append("<p> Daily Expert Sentiment </p>" + boxData.avg_daily_expert_sentiment + "</p>")
}


$(document).ready(function() {
    var chart, volume, prices, tweetSentiment, articleSentiment, stockData;

// setInterval(function(){
//     $.post('/chart_data', function(response) {
//         stockData = response;
//         stockChart(stockData);
//     }, 'json');
// }, 5000);

    $.post('/chart_data', function(response) {
        stockData = response;
        stockChart(stockData);
    }, 'json');

    var company = 'AAPL'

    $.post('/expert_data', { company: company }, function(response) {
        boxData = response;
        populateBoxes(boxData);
    }, 'json');

    $.post('/herd_data', { company: company }, function(response) {
        herd_data = response;
        populateBoxes(herd_data);
    }, 'json');

    $.post('/volume_data', { company: company }, function(response) {
        volume_data = response;
        populateBoxes(volume_data);
    }, 'json');

});
