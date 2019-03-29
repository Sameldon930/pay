/*
Template Name: Admin Mintone
Author: SRGIT
File: js
*/


// ============================================================== 
// This is for the chart
// ============================================================== 
$(function () {
    "use strict";
	
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
        element: 'extra-area-chart-2',
        data: [{
                    period: '2012',
                    iphone: 20,
                    ipad: 30,
                    itouch: 50
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