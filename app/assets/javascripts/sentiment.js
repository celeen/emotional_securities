$(document).ready(function(){
	var volume, prices, tweetSentiment, articleSentiment;

	function stockChart(data) { 
		c3.generate({
    data: {
    	dates: 'x',
    	json: {

        // Row of date/times formatted in x axis Y-M-D H-M-S
        // Row that is volume, chart- bar
        // Row that is stock price - spline
        // Row that is sentiment - spline
        		x: [2014-01-03,2014-01-04,2014-01-05,2014-01-03,2014-01-03,2014-01-03,],
            volume: [200, 130, 90, 240, 130, 220],
            prices: [300, 200, 160, 400, 250, 250],
            tweetSentiment: [200, 130, 90, 240, 130, 220],
            articleSentiment: [90, 70, 20, 50, 60, 120],
    	},
        type: 'bar',
        types: {
            prices: 'spline',
            tweetSentiment: 'spline',
            articleSentiment: 'spline',
        },
        // groups: [
        //     ['data1','data2']
        // ]
    },
    axis: {
    	x: {
    		type: 'timeseries',
    		tick: {
    			format: '%Y-%m-%d'
    		}
    	}
    }
	});
	}

	// Data call
	$.post('/chart_data', function(response){
		stockData = response;
		console.log(stockData);
		// Call chart here
	})


})