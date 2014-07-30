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

function populateVolumeBox(volume, box, label) {
    console.log(volume);
    $(box).append("<p>" + label + " </p>" + volume + "</p>")
}

function populateSentimentBoxes(sentiment, r, box, label) {
    console.log(sentiment);
    console.log(r);
    $(box).append("<p>" + label + " </p><p> Feelz: " + sentiment + "</p><p> R: " + r + "</p><p> R-Squared: " + Math.round(r * r * 100) / 100 + "</p>")
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
        var stockData = response;
        stockChart(stockData);
    }, 'json');

    var company = 'AAPL'
    var index = '^GSPC'

    $.post('/expert_data', { company: company }, function(response) {
        var expert_data = response;
        var expert_label = "Experts";
        populateSentimentBoxes(expert_data.avg_daily_expert_sentiment, expert_data.correlation, '.feature.expert h4', expert_label);
    }, 'json');

    $.post('/herd_data', { company: company }, function(response) {
        var herd_data = response;
        var herd_label = "Herd";
        populateSentimentBoxes(herd_data.avg_daily_herd_sentiment, herd_data.correlation, '.feature.herd h4', herd_label);
    }, 'json');

    $.post('/volume_data', { company: company }, function(response) {
        var volume_data = response;
        var volume_label = "Volume Delta";
        populateVolumeBox(volume_data.daily_volume_delta, '.feature.volume h4', volume_label
);
    }, 'json');


});
