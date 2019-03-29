/*
Template Name: Admin Mintone
Author: SRGIT
File: js
*/
$(function () {
    "use strict";
Morris.Area({});
	
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
	

	
	
	 
    // ============================================================== 
    // Our Income
    // ==============================================================
  
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
    $("#sparkline11").sparkline([ ], {
        
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
});