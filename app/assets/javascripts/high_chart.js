var chart, volume, prices, tweetSentiment, articleSentiment, stockData;

$(function() {
    Highcharts.setOptions({
        global: {
            useUTC: false
        }
    });
});

function highChart(data) {
    $('#container').highcharts({
        chart: {
            backgroundColor: '#EEEFDF',
            type: 'line',
            style: {
                font: '12pt News Cycle, serif',
                color: '#0f1c13'
            },
            zoomType: 'x',
            resetZoomButton: {

                theme: {
                    // height: 12,
                    fill: '#2E563C',

                    style: {
                        color: "#EEEFDF",
                        font: '10pt News Cycle, serif',
                        // height: '10px',
                        // lineHeight: '2px',

                    },
                    states: {
                        hover: {
                            fill: '#2E563C',
                            style: {
                                color: '#BD872D'
                            }
                        }
                    }
                }
            }
        },
        title: {
            text: 'Market Feelz and your Moneys',
            style: {
                font: '20pt News Cycle, serif',
                color: '#0F1C13'
            },
        },
        subtitle: {
            text: '',
            style: {
                font: '14pt News Cycle, serif',
            }
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                hour: '%l:%M %p',
                ///day: '%a',
                //month: '%e1 %b',
                //year: '%b'
            },
            title: {
                text: 'The Last 24 Hours'
            },
            max: Date.now(),
            min: Date.now() - 86400000,
        },
        yAxis: [{ //sentiment axis
            labels: {
                style: {
                    color: '#7F8FC3'
                }
            },
            title: {
                text: 'Tweet Sentiment',
                style: {
                    color: '#3C528B',
                }
            },
            min: -1,
            max: 1,
            opposite: true,
        }, { //Price Axis
            labels: {
                style: {
                    color: '#BD872D'
                }
            },
            title: {
                text: 'Price',
                style: {
                    color: '#BD872D'
                }
            }
        }],

        series: [{
            name: 'Tweet Sentiment',
            data: data.tweets,
            id: 'primary',
            type: 'scatter',
            color: '#7F8FC3',
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x:%l:%M %p}: {point.y:.4f}',
            },
        }, {
            name: 'Price',
            data: data.prices,
            shadow: true,
            yAxis: 1,
            color: '#BD872D',
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x:%l:%M %p}: ${point.y:.2f}',
            },

        }, {
            connectNulls: true,
            shadow: true,
            name: 'Average Tweet Sentiment',
            linkedTo: 'primary',
            showInLegend: true,
            type: 'trendline',
            algorithm: 'EMA',
            periods: 50,
            color: '#3C528B',
            tooltip: {
                headerFormat: '<b>Average Sentiment</b><br>',
                pointFormat: '{point.y:.4f}',
            },
        }],
        plotOptions: {
            scatter: {
                marker: {
                    radius: 1,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: '#3C528B'
                        }
                    }
                }
            }
        },
        legend: {
            itemStyle: {
                font: '12pt News Cycle, serif',
                color: '#0F1C13',
            }
        },
        navigation: {
            buttonOptions: {
                enabled: false
            }
        }
    });
}

function populateVolumeBox(volume, box, label) {
    $(box).append("<p>" + label + ": " + volume + "</p>")
}

function populateSentimentBoxes(sentiment, r, box, label) {
    $(box).append("<p>" + label + " </p><p> Sentiment: " + sentiment + "</p><p> Correlation: " + r + "</p><p> Determinism: " + Math.round(r * r * 100) / 100 + "</p>")
}

function getChartData(symbol) {
    console.log('getting chart data!')
    $.post('/chart_data', {
            'company': symbol
        },
        highChart,
        'json');
};


function getExpertData(symbol) {
    $.post('/expert_data', {
        company: symbol
    }, function(response) {
        var expert_data = response;
        var expert_label = "Experts";
        populateSentimentBoxes(expert_data.avg_daily_expert_sentiment, expert_data.correlation, '.feature.expert h3', expert_label);
    }, 'json');
};

function getHerdData(symbol) {
    $.post('/herd_data', {
        company: symbol
    }, function(response) {
        var herd_data = response;
        var herd_label = "Herd";
        populateSentimentBoxes(herd_data.avg_daily_herd_sentiment, herd_data.correlation, '.feature.herd h3', herd_label);
    }, 'json');
};

function getVolumeData(symbol) {
    $.post('/volume_data', {
        company: symbol
    }, function(response) {
        var volume_data = response;
        console.log(volume_data.daily_volume_delta);
        var volume_label = "Volume Delta";
        populateVolumeBox(volume_data.daily_volume_delta, '.feature.volume h3', volume_label);
    }, 'json');
};

function removeCompanyMetrics() {
    $('.24-hour-metrics').empty();
}

function addCompanyName(symbol) {
    $('#metrics h1').empty();
    $('#metrics h1').text("$" + String(symbol));
}

$(document).ready(function() {
    var chart, volume, prices, tweetSentiment, articleSentiment, stockData;
    getVolumeData('AAPL');
    getHerdData('AAPL');
    getExpertData('AAPL');
    getChartData('AAPL');



    $('body').on("click", '.stocks > li',
        function(event) {
            event.preventDefault();
            console.log(event);
            console.log(event.currentTarget.className);
            var symbol = event.currentTarget.className;
            removeCompanyMetrics();
            addCompanyName(symbol);
            getVolumeData(symbol);
            getHerdData(symbol);
            getExpertData(symbol);
            getChartData(symbol);
        });

});