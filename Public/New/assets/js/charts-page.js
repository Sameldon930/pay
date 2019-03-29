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
        element: 'extra-area-chart-2',
        data: [{
                    period: '2012',
                    iphone: 0,
                    ipad: 0,
                    itouch: 0
                }, {
                    period: '2013',
                    iphone: 50,
                    ipad: 30,
                    itouch: 1
                }, {
                    period: '2014',
                    iphone: 20,
                    ipad: 50,
                    itouch: 95
                }, {
                    period: '2015',
                    iphone: 160,
                    ipad: 70,
                    itouch: 7
                }, {
                    period: '2016',
                    iphone: 30,
                    ipad: 20,
                    itouch: 150
                }, {
                    period: '2017',
                    iphone: 25,
                    ipad: 80,
                    itouch: 40
                }, {
                    period: '2018',
                    iphone: 10,
                    ipad: 10,
                    itouch: 10
                }
                ],
                lineColors: ['#ff3c64', '#ff7c00', '#2f69f8'],
                xkey: 'period',
                ykeys: ['iphone', 'ipad', 'itouch'],
                labels: ['Sessions', 'New Visitors', 'Avg. Session Duration'],
                pointSize: 0,
                lineWidth: 0,
                resize:true,
                fillOpacity: 1,
                behaveLikeLine: true,
                gridLineColor: '#e0e0e0',
                hideHover: 'auto'
        
    });
	
Morris.Area({
        element: 'morris-area-chart2',
        data: [{
            period: '2010',
            iphone: 50,
            ipad: 80,
            itouch: 20
        }, {
            period: '2011',
            iphone: 130,
            ipad: 100,
            itouch: 80
        }, {
            period: '2012',
            iphone: 80,
            ipad: 60,
            itouch: 70
        }, {
            period: '2013',
            iphone: 70,
            ipad: 200,
            itouch: 140
        }, {
            period: '2014',
            iphone: 180,
            ipad: 150,
            itouch: 140
        }, {
            period: '2015',
            iphone: 105,
            ipad: 100,
            itouch: 80
        },
         {
            period: '2016',
            iphone: 250,
            ipad: 150,
            itouch: 200
        }],
        xkey: 'period',
        ykeys: ['iphone', 'ipad', 'itouch'],
        labels: ['iPhone', 'iPad', 'iPod Touch'],
        pointSize: 2,
        fillOpacity: 0,
        pointStrokeColors:['#4886ff', '#7ad835', '#ffb74e'],
        behaveLikeLine: true,
        gridLineColor: '#e0e0e0',
        lineWidth: 1,
        hideHover: 'auto',
        lineColors: ['#4886ff', '#7ad835', '#ffb74e'],
        resize: true
       
    });
	
	
	Morris.Area({
        element: 'morris-area-chart3',
        data: [{
            period: '2010',
            SiteA: 0,
            
        }, {
            period: '2011',
            SiteA: 130,
            
        }, {
            period: '2012',
            SiteA: 80,
            
        }, {
            period: '2013',
            SiteA: 70,
            
        }, {
            period: '2014',
            SiteA: 180,
            
        }, {
            period: '2015',
            SiteA: 105,
            
        },
         {
            period: '2016',
            SiteA: 250,
           
        }],
        xkey: 'period',
        ykeys: ['SiteA'],
        labels: ['Site A'],
        pointSize: 2,
        fillOpacity: 1,
        pointStrokeColors:['#f95476'],
        behaveLikeLine: true,
        gridLineColor: '#e0e0e0',
        lineWidth: 1,
        smooth: false,
        hideHover: 'auto',
        lineColors: ['#fb5a14'],
        resize: true
        
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
		
				$('#sparkline16').sparkline([15, 23, 55, 35, 54, 45, 66, 47, 30], {
            type: 'line',
            width: '100%',
            height: '200',
            chartRangeMax: 50,
            resize: true,
            lineColor: '#009efb',
            fillColor: 'rgba(19, 218, 254, 0.3)',
            highlightLineColor: 'rgba(0,0,0,.1)',
            highlightSpotColor: 'rgba(0,0,0,.2)',
        });
	$("#sparkline14").sparkline([10, 15, 0, 20, 10, 45, 20, 30, 10, 15, 0, 20, 0, 25], {
            type: 'line',
            width: '70%',
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
		
		    var ctx3 = document.getElementById("chart3").getContext("2d");
    var data3 = [
        {
            value: 110,
            color:"#f95476",
            highlight: "#f95476",
            label: "Shoes"
        },
        {
            value: 70,
            color: "#48daff",
            highlight: "#48daff",
            label: "Lingerie"
        },
		 {
            value: 60,
            color: "#ffb74e",
            highlight: "#ffb74e",
            label: "Denim"
        },
		 {
            value: 90,
            color: "#b554f9",
            highlight: "#b554f9",
            label: "Suits"
        }
    ];
    
    var myPieChart = new Chart(ctx3).Pie(data3,{
        segmentShowStroke : true,
        segmentStrokeColor : "#fff",
        segmentStrokeWidth : 0,
        animationSteps : 100,
		tooltipCornerRadius: 0,
        animationEasing : "easeOutBounce",
        animateRotate : true,
        animateScale : false,
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
        responsive: true
    });
    
    var ctx4 = document.getElementById("chart4").getContext("2d");
    var data4 = [
        {
            value: 100,
            color:"#f95476",
            highlight: "#f95476",
            label: "Suits"
        },
        {
            value: 50,
            color: "#4d89ff",
            highlight: "#4d89ff",
            label: "Denim"
        },
		
		 {
            value: 50,
            color: "#B554F9",
            highlight: "#B554F9",
            label: "Denim"
        },
		
        {
            value: 100,
            color: "#48daff",
            highlight: "#48daff",
            label: "Lingerie"
        }
    ];
    
    var myDoughnutChart = new Chart(ctx4).Doughnut(data4,{
        segmentShowStroke : true,
        segmentStrokeColor : "#fff",
        segmentStrokeWidth : 0,
        animationSteps : 100,
		tooltipCornerRadius: 0,
        animationEasing : "easeOutBounce",
        animateRotate : true,
        animateScale : false,
        legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
        responsive: true
    });
    
		
		});

/* ---------------------------------------------
animated
--------------------------------------------- */
"use strict";
var wow = new WOW({
    boxClass: 'wow', // animated element css class (default is wow)
    animateClass: 'animated', // animation css class (default is animated)
    offset: 120, // distance to the element when triggering the animation (default is 0)
    mobile: false, // trigger animations on mobile devices (default is true)
    live: true // act on asynchronously loaded content (default is true)
});
wow.init();
/* ---------------------------------------------
animated
--------------------------------------------- */