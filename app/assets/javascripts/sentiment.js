//   var chart, volume, prices, tweetSentiment, articleSentiment, stockData, chartData, boxData;

//   Array.max = function(array) {
//       return Math.max.apply(Math, array);
//   };


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

      $('body').on("click", '.stocks > li',
          function(event) {
              event.preventDefault();
              console.log(event);
              console.log(event.currentTarget.className);
              var symbol = event.currentTarget.className;
              getChartData(symbol);
          });

      function getChartData(symbol) {
          console.log('getting chart data!')
          $.post('/chart_data', {
                  'company': symbol
              },
              stockChart,
              'json');
      };

  });

