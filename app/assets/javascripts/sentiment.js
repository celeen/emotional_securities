//   var chart, volume, prices, tweetSentiment, articleSentiment, stockData, chartData, boxData;

//   Array.max = function(array) {
//       return Math.max.apply(Math, array);
//   };

//   Array.min = function(array) {
//       return Math.min.apply(Math, array);
//   };

//   function stockChart(data) {
//       console.log(data);
//       chart = c3.generate({
//           size: {
//               height: 550,
//           },
//           point: {
//               show: false
//           },
//           data: {
//               x: 'dates',
//               json: {
//                   dates: data.dates,
//                   tweetSentiment: data.tweetSentiments,
//                   prices: data.prices,
//                   volume: data.volume,
//               },
//               axes: {
//                   tweetSentiment: 'y',
//                   prices: 'y2',
//                   volume: 'y2'
//               },
//               types: {
//                   prices: 'spline',
//                   tweetSentiment: 'spline',
//                   volume: 'bar'
//               },
//               colors: {
//                   prices: '#C8A010',
//                   tweetSentiment: '#116751',
//                   volume: '#328973',
//               },
//               size: {
//                   width: 500
//               }
//           },
//           subchart: {
//               show: true
//           },
//           axis: {
//               x: {
//                   type: 'timeseries',
//                   tick: {
//                       count: 4,
//                       format: '%m/%d/%y'
//                   },
//               },
//               y: {
//                   label: "Sentiment",
//                   min: -1,
//                   max: 1,
//               },
//               y2: {
//                   label: "Share Price",
//                   show: true,
//                   padding: {
//                       top: Array.max(data.prices) * 0.01,
//                       bottom: Array.min(data.prices) * 0.01
//                   },
//               },
//               y3: {
//                   show: true
//               }
//           },
//           tooltip: {
//               format: {
//                   title: function(d) {
//                       return 'Data ' + d;
//                   },
//                   value: function(value, ratio, id) {
//                       var format = id === 'prices' ? d3.format('$') : d3.format('.');
//                       return format(value);
//                   }
//               }
//           }
//       });
//       chart.hide('volume');
//   }

$(document).ready(function() {
    var chart, volume, prices, tweetSentiment, articleSentiment, stockData;

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

      function getBoxData() {
          $.post('/box_data', function(response) {
              boxData = response;
              populateBoxes(boxData);
          }, 'json');

      };
  });
