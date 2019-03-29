/*
Template Name: Admin Mintone
Author: SRGIT
File: js
*/

// ============================================================== 
// r the chart
// ============================================================== 

$(function () {
"use strict";
	Morris.Area.prototype.fillForSeries = function(i) {
      var color;
	  return "0-#e2ecff:10-#6D9EFF:80";
};

var profileBar = Morris.Area({
    element: 'extra-area-chart-last-week',
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
	 
	 var homeBar = Morris.Area({
       element: 'extra-area-chart-last-month',
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
                lineColors: ['#000'],
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
	
	 var morBar = Morris.Area({
       element: 'extra-area-chart-2',
        data: [ {
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
                lineColors: ['#ff7c00', '#ff3c64', '#2f69f8'],
                xkey: 'period',
                ykeys: ['iphone', 'ipad', 'itouch'],
                labels: ['Sale', 'Orders', 'New Visitors'],
                pointSize: 0,
                lineWidth: 0,
                resize:true,
                fillOpacity: 1,
                behaveLikeLine: true,
                gridLineColor: '#e0e0e0',
                hideHover: 'auto'
    });
		
$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
  var target = $(e.target).attr("href") // activated tab
  switch (target) {
    case "#last-year":
      homeBar.redraw();
      $(window).trigger('resize');
      break;
    case "#last-month":
      profileBar.redraw();
      $(window).trigger('resize');
      break;
	    case "#last-week":
      profileBar.redraw();
      $(window).trigger('resize');
      break;
  }
});
	
// ============================================================== 
// r the popup message while page load
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


// ============================================================== 
// r scrollbar
// ============================================================== 
$('#slimtest2, #slimtest4').perfectScrollbar();