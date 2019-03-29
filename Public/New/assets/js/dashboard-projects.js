/*
Template Name: Admin Mintone
Author: SRGIT
File: js
*/

$(function () {
    "use strict";
	
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
        pointSize: 3,
        fillOpacity: 0,
		 
        pointStrokeColors:['#7ad835', '#4886ff', '#ffb74e'],
        behaveLikeLine: true,
        gridLineColor: '#e0e0e0',
        lineWidth: 1,
        hideHover: 'auto',
        lineColors: ['#7ad835', '#4886ff', '#ffb74e'],
        resize: true
        
    });


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



