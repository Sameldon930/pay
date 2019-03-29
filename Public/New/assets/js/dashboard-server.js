/*
Template Name: Admin Mintone
Author: SRGIT
File: js
*/

$(function () {
    "use strict";
	
Morris.Area({
        element: 'extra-area-chart',
        data: [{
                    time: '5 Sec',
                    percent: 0
                }, {
                    time: '10 Sec',
                    percent: 50
                }, {
                    time: '15 Sec',
                    percent: 20
                }, {
                    time: '20 Sec',
                    percent: 60
                }, {
                    time: '25 Sec',
                    percent: 30
                }, {
                    time: '30 Sec',
                    percent: 25
                }, {
                    time: '35 Sec',
                    percent: 10
                }


                ],
                lineColors: ['#84adff'],
                xkey: 'time',
                ykeys: ['percent'],
                labels: [''],
                pointSize: 0,
                lineWidth: 0,
                resize:true,
                fillOpacity: 0.8,
                behaveLikeLine: true,
                gridLineColor: '#e0e0e0',
                hideHover: 'auto'
        
    });
	
	Morris.Area({
        element: 'morris-area-chart',
        data: [{
            period: '2010',
            CPU: 50,
            Memory: 80,
            DISC: 20
        }, {
            period: '2011',
            CPU: 130,
            Memory: 100,
            DISC: 80
        }, {
            period: '2012',
            CPU: 80,
            Memory: 60,
            DISC: 70
        }, {
            period: '2013',
            CPU: 70,
            Memory: 200,
            DISC: 140
        }, {
            period: '2014',
            CPU: 180,
            Memory: 150,
            DISC: 140
        }, {
            period: '2015',
            CPU: 105,
            Memory: 100,
            DISC: 80
        },
         {
            period: '2016',
            CPU: 250,
            Memory: 150,
            DISC: 200
        }],
        xkey: 'period',
        ykeys: ['CPU', 'Memory', 'DISC'],
        labels: ['CPU', 'Memory', 'DISC'],
        pointSize: 2,
        fillOpacity: 0,
		 
        pointStrokeColors:['#f95476', '#ffb74e', '#4886ff'],
        behaveLikeLine: true,
        gridLineColor: '#e0e0e0',
        lineWidth: 2,
        hideHover: 'auto',
        lineColors: ['#f95476', '#ffb74e', '#4886ff'],
        resize: true
        
    });
	
	
    // ============================================================== 
    // Our Income
    // ==============================================================
    var chart = c3.generate({
        bindto: '#memory_usage',
        data: {
            columns: [
                   ['Growth Income', 0, 0, 0],
				['Income', 0, 0, 0],
                ['Net Income', 0, 0, 0]
            ],
            type: 'bar'
        },
         bar: {
            space: 0.1,
            // or
            width: 20 // this makes bar width 100px
        },
        axis: {
            y: {
            tick: {
                count : 4,
                outer: false
                }
            }
        },
        legend: {
          hide: true
          //or hide: 'data1'
          //or hide: ['data1', 'data2']
        },
        grid: {
        x: {
            show: false
        },
        y: {
            show: true
        }
    },
        size: {
            height: 300
        },
        color: {
              pattern: [ '#ffb74e', '#fe365f', '4782fa']
        }
    });
	
	
	setTimeout(function () {
    chart.load({
        columns: [
              ['Growth Income', 512, 200, 100],
				['Income', 315, 150, 50],
                ['Net Income', 197, 110, 30]
        ]
    });
}, 1500);
	

	// ============================================================== 
    // This is for the popup message while page load
    // ============================================================== 
        $.toast({
            heading: 'Welcome to Admin Mintone',
            text: 'Most powerfull and elegant design with tons of elements.',
            position: 'bottom-right',
            loaderBg: '#0a2d73',
            icon: 'info',
            hideAfter: 6000,
            stack: 6
        })
		
     $('[data-plugin="knob"]').knob();
	
});

$(document).ready(function() {
   var sparklineLogin = function() { 
    $("#sparkline12").sparkline([45,43,42,35,30,45,40, 50, 45,40,35,45,35,40,50, 45,40,35,30,35,42,35,30,45,60,50, 45,40,35,45,40,35,30,35,42 ], {
        type: 'bar',
		 width: '100%',
        height: '100',
        barWidth: 6,
        barSpacing: 2,
        barColor: '#ffb74e'
        });

	$("#sparkline14").sparkline([10, 15, 0, 20, 10, 45, 20, 30, 10, 15, 0, 20, 0, 25], {
            type: 'line',
            width: '100%',
            height: '45',
            lineColor: '#f95476',
            fillColor: 'transparent',
            spotColor: '#f95476',
            minSpotColor: undefined,
            maxSpotColor: undefined,
            highlightSpotColor: undefined,
            highlightLineColor: undefined
        }); 
     }

	var sparkResize;
	    $(window).resize(function(e) {
            clearTimeout(sparkResize);
            sparkResize = setTimeout(sparklineLogin, 500);
        });
        sparklineLogin();
});

