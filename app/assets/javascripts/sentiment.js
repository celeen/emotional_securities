	Array.max = function(array) {
		return Math.max.apply( Math, array);
	}

	function stockChart(data) { 
		console.log(data)
		chart = c3.generate({
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
	            tweetSentiment: 'line',
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
	    		}
	    	},
	    	y: {
	    		label: "Sentiment",
	    		min: -1,
	    		max: 1,
	    	},
	    	y2: {
	    		label: "Share Price",
	    		show: true,
	    		padding: {top: Array.max(data.prices)}
	    	},
	    	y3: {
	    		show: true
	    	}
	    },
	    tooltip: {
        format: {
            title: function (d) { return 'Data ' + d; },
            value: function (value, ratio, id) {
                var format = id === 'prices' ? d3.format('$') : d3.format('.');
                return format(value);
            }
        }
    }
		});
		chart.hide('volume')
	}

$(document).ready(function(){
	var chart, volume, prices, tweetSentiment, articleSentiment, stockData;


	$.post('/chart_data', function(response){
		stockData = response;
		stockChart(stockData)
	}, 'json')


})