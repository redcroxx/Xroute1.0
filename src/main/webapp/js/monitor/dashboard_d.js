	//Center Setting Start
	if(document.location.href.toLowerCase().indexOf("locc") > -1) {
		var centerOwner = 2002;
	} else {
		var centerOwner = 2001;
	}

	var center = '용인';
	var centerEng = 'Yongin';
	var centerNum = $('#centerNum').val();


	if(document.location.href.indexOf("Sub") > -1){
		center = '안성';
		centerEng = 'Ansung';
		var centerNum = 1002;
	}
	//Center Setting End

	var spdoData = new Array();
	var ondoData = new Array();
	var fireData = new Array();

	var tempData = new Array();
	var humiData = new Array();
	var dustData = new Array();
	var earthquakeData = new Array();

	var hotTempAvg = 0;
	var humidityAvg = 0;
	
	getClgoGoalStatData(centerNum, centerEng);
	getClgoCompareStatData(centerNum, centerEng);
	getIpgoGoalStatData(centerNum, centerEng);
	getIpgoCompareStatData(centerNum, centerEng);
	getWeekSensorData(center, centerEng);
	getSummationFireData(centerEng);
	getSummationTemperatureData(centerEng);
	getRealTimeEarthquake(center, centerEng);
	getItemIpgoDataByDesktop(centerNum, centerEng);
	getItemClgoDataByDesktop(centerNum, centerEng);


// 출고 - 목표대비 달성률 START
function getClgoGoalStatData(centerNum) {
	$.ajax(
	{
		type : 'post',
		url : '/monitor/m100/m100101/getClgoGoalStatData.do',
		data : (
				{
					centerNum : centerNum
				}),
		dataType : 'json',
		success : function(data)
		{
			$.each(data, function(key, value)
			{
				 var colors = Highcharts.getOptions().colors,
			        browserData = [],
			        versionsData1 = [],
			        versionsData2 = [],
			        versionsData3 = [],
			        versionsData4 = [],
			        clgoGoalData = [],
			        i,
			        j,
			        valueLen = value.length,
			        brightness;
				if(isEmpty(value)) {
					versionsData1.push({
		                name: 0,
		                y: 0,
		                color: "#3F87D3"
		            });
					versionsData2.push({
		                name: 0,
		                y: 0,
		                color: "#3F87D3"
		            });
					versionsData3.push({
		                name: 0,
		                y: 0,
		                color: "#3F87D3"
		            });
					versionsData4.push({
		                name: 0,
		                y: 0,
		                color: "#3F87D3"
		            });
					
					for (var i = 0; i < 4; i++) {
						clgoGoalData.push(0);
					}
				}
				else{
					versionsData1.push({
		                name: "달성율",
		                y: value[3].PS,
		                color: "#3F87D3"
		            });
					versionsData2.push({
		                name: "달성율",
		                y: value[2].PS,
		                color: "#3F87D3"
		            });
					versionsData3.push({
		                name: "달성율",
		                y: value[1].PS,
		                color: "#3F87D3"
		            });
					versionsData4.push({
		                name: "달성율",
		                y: value[0].PS,
		                color: "#3F87D3"
		            });
					
					versionsData1.push({
		                name: "미달성율",
		                y: (100 - value[3].PS),
		                color: "#39485A"
		            });
					versionsData2.push({
		                name: "미달성율",
		                y: (100 - value[2].PS),
		                color: "#39485A"
		            });
					versionsData3.push({
		                name: "미달성율",
		                y: (100 - value[1].PS),
		                color: "#39485A"
		            });
					versionsData4.push({
		                name: "미달성율",
		                y: (100 - value[0].PS),
		                color: "#39485A"
		            });
					
					clgoGoalData.push({
		                name: "3주전",
		                y: value[3].CLGO_COMPLETE,
		                color: "#3F87D3"
		            });
					clgoGoalData.push({
		                name: "2주전",
		                y: value[2].CLGO_COMPLETE,
		                color: "#3F87D3"
		            });
					clgoGoalData.push({
		                name: "1주전",
		                y: value[1].CLGO_COMPLETE,
		                color: "#3F87D3"
		            });

					clgoGoalData.push({
		                name: "현재",
		                y: value[0].CLGO_COMPLETE,
		                color: "#3F87D3"
		            });
					
					
					
				  	$('#clgoGoalText-1-'+centerEng).empty();
				  	$('#clgoGoalText-1-'+centerEng).append('<div><span>' + value[3].PS + '%</span></div>')

				  	$('#clgoGoalText-2-'+centerEng).empty();
				  	$('#clgoGoalText-2-'+centerEng).append('<div><span>' + value[2].PS + '%</span></div>')

				  	$('#clgoGoalText-3-'+centerEng).empty();
				  	$('#clgoGoalText-3-'+centerEng).append('<div><span>' + value[1].PS + '%</span></div>')

				  	$('#clgoGoalText-4-'+centerEng).empty();
				  	$('#clgoGoalText-4-'+centerEng).append('<div><span>' + value[0].PS + '%</span></div>')
				  	
				}
				$('#clgoGoalChart-1-'+centerEng).highcharts({
					chart: {
			            type: 'pie',
			            backgroundColor:'transparent'
			        },
			        exporting: { enabled: false },
			        title: {
			            text: ''
			        },
			        yAxis: {
			            title: {
			                text: 'Total percent market share'
			            }
			        },
			        plotOptions: {
			        	pie: {
		                    allowPointSelect: true,
		                    cursor: 'pointer',
		                    dataLabels: {
		                        enabled: false
		                    },
		                    showInLegend: true,
		                    borderWidth: 0
		                }
			        },
			        legend: {
		                enabled : false
		              },
			        tooltip: {
			            pointFormat: '<b>{point.percentage:.1f}%</b>'
			        },
			        series: [{
			            name: 'Browsers',
			            data: browserData,
			            size: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 5 ? this.point.name : null;
			                },
			                color: '#ffffff',
			                distance: -30
			            }
			        }, {
			            name: 'Versions',
			            data: versionsData1,
			            size: '70%',
			            innerSize: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 1 ? this.y + '%' : null;
			                }
			            }
			        }]
				});
				
				$('#clgoGoalChart-2-'+centerEng).highcharts({
					chart: {
			            type: 'pie',
			            backgroundColor:'transparent'
			        },
			        exporting: { enabled: false },
			        title: {
			            text: ''
			        },
			        yAxis: {
			            title: {
			                text: 'Total percent market share'
			            }
			        },
			        plotOptions: {
			        	pie: {
		                    allowPointSelect: true,
		                    cursor: 'pointer',
		                    dataLabels: {
		                        enabled: false
		                    },
		                    showInLegend: true,
		                    borderWidth: 0
		                }
			        },
			        legend: {
		                enabled : false
		              },
			        tooltip: {
			            pointFormat: '<b>{point.percentage:.1f}%</b>'
			        },
			        series: [{
			            name: 'Browsers',
			            data: browserData,
			            size: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 5 ? this.point.name : null;
			                },
			                color: '#ffffff',
			                distance: -30
			            }
			        }, {
			            name: 'Versions',
			            data: versionsData2,
			            size: '70%',
			            innerSize: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 1 ? this.y + '%' : null;
			                }
			            }
			        }]
				});
				$('#clgoGoalChart-3-'+centerEng).highcharts({
					chart: {
			            type: 'pie',
			            backgroundColor:'transparent'
			        },
			        exporting: { enabled: false },
			        title: {
			            text: ''
			        },
			        yAxis: {
			            title: {
			                text: 'Total percent market share'
			            }
			        },
			        plotOptions: {
			        	pie: {
		                    allowPointSelect: true,
		                    cursor: 'pointer',
		                    dataLabels: {
		                        enabled: false
		                    },
		                    showInLegend: true,
		                    borderWidth: 0
		                }
			        },
			        legend: {
		                enabled : false
		              },
			        tooltip: {
			            pointFormat: '<b>{point.percentage:.1f}%</b>'
			        },
			        series: [{
			            name: 'Browsers',
			            data: browserData,
			            size: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 5 ? this.point.name : null;
			                },
			                color: '#ffffff',
			                distance: -30
			            }
			        }, {
			            name: 'Versions',
			            data: versionsData3,
			            size: '70%',
			            innerSize: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 1 ? this.y + '%' : null;
			                }
			            }
			        }]
				});
				$('#clgoGoalChart-4-'+centerEng).highcharts({
					chart: {
			            type: 'pie',
			            backgroundColor:'transparent'
			        },
			        exporting: { enabled: false },
			        title: {
			            text: ''
			        },
			        yAxis: {
			            title: {
			                text: 'Total percent market share'
			            }
			        },
			        plotOptions: {
			        	pie: {
		                    allowPointSelect: true,
		                    cursor: 'pointer',
		                    dataLabels: {
		                        enabled: false
		                    },
		                    showInLegend: true,
		                    borderWidth: 0
		                }
			        },
			        legend: {
		                enabled : false
		              },
			        tooltip: {
			            pointFormat: '<b>{point.percentage:.1f}%</b>'
			        },
			        series: [{
			            name: 'Browsers',
			            data: browserData,
			            size: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 5 ? this.point.name : null;
			                },
			                color: '#ffffff',
			                distance: -30
			            }
			        }, {
			            name: 'Versions',
			            data: versionsData4,
			            size: '70%',
			            innerSize: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 1 ? this.y + '%' : null;
			                }
			            }
			        }]
				});
				
				$('#clgoWorkGraph'+centerEng).highcharts(
				{
					chart: {
						type: 'column',
			            backgroundColor:'transparent',
			            plotBackgroundColor: "rgba(255,200,200,0)",
			            backgroundColor: "rgba(255,255,255,0)",
			            borderColor: "rgba(255,255,255,0)"
			        },
			        exporting: { enabled: false },
			        colors: [
			            "#6b1c9d",
			            "#3d3d9c",
			            "#4b6fe2",
			            "#3396fe",
			            "#25c2fe",
			            "#4b74a1",
			            "#317631",
			            "#ffbe35",
			            "#fe7046",
			            "#b34646"
			        ],
			        credits: {},
			        title: "",
			        xAxis: {
			        	categories: ['3주전', '2주전', '1주전', '현재'],
			            lineColor: "#2A4573",
			            alternateGridColor: "rgba(255,255,255,0)",
			            tickLength: 0,
			            labels: {
			              style: {
			                color: "#3F67AC",
			                fontFamily: "맑은 고딕",
			                fontSize: "12px",
			                fontWeight: "normal"
			              }
			            }
			        },
			        yAxis: [
			            {
			              opposite: false,
			              lineColor: "#2A4573",
			              gridLineColor: "#2A4573",
			              alternateGridColor: "rgba(255,255,255,0)",
			              title: "",
			              labels: {
			                style: {
			                  color: "#3F67AC",
			                  fontFamily: "맑은 고딕",
			                  fontSize: "12px",
			                  fontWeight: "normal"
			                }
			              }
			            }
			        ],
			        tooltip: {
			            backgroundColor: "rgba(255,255,255,0.85)",
			            borderColor: "rgba(255,255,255,1)",
			            style: {
			              color: "#3E576F",
			              fontFamily: "Verdana",
			              fontSize: "12px",
			              fontWeight: "normal"
			            }
			        },
			        plotOptions: {
			            series: {
			              shadow: false,
			              lineWidth: 2,
			              allowPointSelect: false,
			              borderColor: "#FFFFFF",
			              borderWidth: 0,
			              borderRadius: 2,
			              barType: "none",
			              animation: {
			                duration: 1000
			              },
			              marker: {},
			              dataLabels: {
			                style: {
			                  color: "#CCECFF",
			                  fontFamily: "Verdana",
			                  fontSize: "12px",
			                  fontWeight: "normal"
			                }
			              },
			              point: {
			                events: {}
			              }
			            }
			        },
			        legend: {
			            enabled: false,
			            backgroundColor: "rgba(255,255,255,0)",
			            borderColor: "rgba(144,144,144,1)",
			            itemStyle: {
			              color: "#274B6D",
			              fontFamily: "Verdana",
			              fontSize: "12px",
			              fontWeight: "normal"
			            }
			        },
			        series: [{
	                     name: "출고량",
	                     color: "#3F87D3",
	                     type: "column",
	                     showInLegend: true,
	                     stacking: "",
	                     stack: "g1",
	                     yAxis: 0,
	                     marker: {
	                       enabled: true,
	                       symbol: "circle"
	                     },
	                     dataLabels: {
	                       enabled: true,
	                       formatter: function () {
		                        return (this.y / 100000).toPrecision(2);
		                    }
	                     },
	                     data: clgoGoalData
	                   }
	                ]
			    });
			});
		},
	beforeSend:function(){
	},complete:function(){
	},
		error : function(request, status, error)
		{
		}
	});
}
//출고 - 목표대비 달성률 END

//출고 - 전주동기대비 START
function getClgoCompareStatData(centerNum, centerEng) {
	$.ajax(
	{
		type : 'POST',
		url : '/monitor/m100/m100101/getClgoCompareStatData.do',
		data : (
				{
					centerNum : centerNum
				}),
		dataType : 'json',
		success : function(data)
		{
			$.each(data, function(key, value)
			{
			    
			    if (isEmpty(value))
				{
			    	$('#signalloadImage1_'+centerEng).attr("src","/images/monitor/b.png");
			    	$('#signalloadText1_'+centerEng).attr("style","left: 26px; top: 72px; width: 199px; height: 71px; position: absolute; font-family: &quot;맑은 고딕&quot;; font-size: 50px; font-weight: normal; text-align: right; color: rgb(0, 162, 255);");
			    	
			      	$('#signalloadText1_'+centerEng).empty();
			      	$('#signalloadText1_'+centerEng).append('<div><span>0%</span></div>')
				}
			    else{
			    	if(0 < value[0].PS) {
				    	$('#signalloadImage1_'+centerEng).attr("src","/images/monitor/r.png");
				    	$('#signalloadText1_'+centerEng).attr("style","left: 26px; top: 72px; width: 199px; height: 71px; position: absolute; font-family: &quot;맑은 고딕&quot;; font-size: 50px; font-weight: normal; text-align: right; color: rgb(255, 0, 0);");
		
				      	$('#signalloadText1_'+centerEng).empty();
				      	$('#signalloadText1_'+centerEng).append('<div><span>' + value[0].PS + '%</span></div>')
			    	} else {

				    	$('#signalloadImage1_'+centerEng).attr("src","/images/monitor/b.png");
				    	$('#signalloadText1_'+centerEng).attr("style","left: 26px; top: 72px; width: 199px; height: 71px; position: absolute; font-family: &quot;맑은 고딕&quot;; font-size: 50px; font-weight: normal; text-align: right; color: rgb(0, 162, 255);");
				    	
				      	$('#signalloadText1_'+centerEng).empty();
				      	$('#signalloadText1_'+centerEng).append('<div><span>' + value[0].PS + '%</span></div>')
			    	}
			    }
			    
			    
			});
		},
	  beforeSend:function(){
	  	$('#outputItemChart'+centerEng).empty();
	  	$('#outputItemChart'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
	  	 
	  },complete:function(){
	  	$('#outputItemChart'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
	  },
		error : function(request, status, error)
		{
		}
	});
}

//출고 - 전주동기대비 END

//ipgo////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//입고 - 목표대비 달성률 START
function getIpgoGoalStatData(centerNum, centerEng) {
	$.ajax(
	{
		type : 'POST',
		url : '/monitor/m100/m100101/getIpgoGoalStatData.do',
		data : (
				{
					centerNum : centerNum
				}),
				dataType : 'json',
				success : function(data)
				{
					$.each(data, function(key, value)
						{
						ipgoGoalData = [];
						
						if(isEmpty(value)) {
							for (var i = 0; i < 4; i++) {
								ipgoGoalData.push(0);
							}
						}
						
						if(value.length < 4) {
							ipgoGoalData.push({
								name: "3주전",
								y: value[2].IPGO_SUM,
								color: "#3F87D3"
							});
							ipgoGoalData.push({
								name: "2주전",
								y: value[1].IPGO_SUM,
								color: "#3F87D3"
							});
							ipgoGoalData.push({
								name: "1주전",
								y: value[0].IPGO_SUM,
								color: "#3F87D3"
							});
							ipgoGoalData.push({
								name: "현재",
								y: 0,
								color: "#3F87D3"
							});
						}
						else{
							ipgoGoalData.push({
								name: "3주전",
								y: value[3].IPGO_SUM,
								color: "#3F87D3"
							});
							ipgoGoalData.push({
								name: "2주전",
								y: value[2].IPGO_SUM,
								color: "#3F87D3"
							});
							ipgoGoalData.push({
								name: "1주전",
								y: value[1].IPGO_SUM,
								color: "#3F87D3"
							});
							ipgoGoalData.push({
								name: "현재",
								y: value[0].IPGO_SUM,
								color: "#3F87D3"
							});
						}
						
						$('#ipgoWorkGraph'+centerEng).highcharts(
							{
								chart: {
									type: 'column',
									backgroundColor:'transparent',
									plotBackgroundColor: "rgba(255,200,200,0)",
									backgroundColor: "rgba(255,255,255,0)",
									borderColor: "rgba(255,255,255,0)"
								},
								exporting: { enabled: false },
								colors: [
									"#6b1c9d",
									"#3d3d9c",
									"#4b6fe2",
									"#3396fe",
									"#25c2fe",
									"#4b74a1",
									"#317631",
									"#ffbe35",
									"#fe7046",
									"#b34646"
									],
									credits: {},
									title: "",
									xAxis: {
										categories: ['3주전', '2주전', '1주전', '현재'],
										lineColor: "#2A4573",
										alternateGridColor: "rgba(255,255,255,0)",
										tickLength: 0,
										labels: {
											style: {
												color: "#3F67AC",
												fontFamily: "맑은 고딕",
												fontSize: "12px",
												fontWeight: "normal"
											}
										}
									},
									yAxis: [
										{
											opposite: false,
											lineColor: "#2A4573",
											gridLineColor: "#2A4573",
											alternateGridColor: "rgba(255,255,255,0)",
											title: "",
											labels: {
												style: {
													color: "#3F67AC",
													fontFamily: "맑은 고딕",
													fontSize: "12px",
													fontWeight: "normal"
												}
											}
										}
										],
										tooltip: {
											backgroundColor: "rgba(255,255,255,0.85)",
											borderColor: "rgba(255,255,255,1)",
											style: {
												color: "#3E576F",
												fontFamily: "Verdana",
												fontSize: "12px",
												fontWeight: "normal"
											}
										},
										plotOptions: {
											series: {
												shadow: false,
												lineWidth: 2,
												allowPointSelect: false,
												borderColor: "#FFFFFF",
												borderWidth: 0,
												borderRadius: 2,
												barType: "none",
												animation: {
													duration: 1000
												},
												marker: {},
												dataLabels: {
													style: {
														color: "#CCECFF",
														fontFamily: "Verdana",
														fontSize: "12px",
														fontWeight: "normal"
													}
												},
												point: {
													events: {}
												}
											}
										},
										legend: {
											enabled: false,
											backgroundColor: "rgba(255,255,255,0)",
											borderColor: "rgba(144,144,144,1)",
											itemStyle: {
												color: "#274B6D",
												fontFamily: "Verdana",
												fontSize: "12px",
												fontWeight: "normal"
											}
										},
										series: [{
											name: "입고량",
											color: "#3F87D3",
											type: "column",
											showInLegend: true,
											stacking: "",
											stack: "g1",
											yAxis: 0,
											marker: {
												enabled: true,
												symbol: "circle"
											},
											dataLabels: {
												enabled: true,
												formatter: function () {
													return (this.y / 100000).toPrecision(2);
												}
											},
											data: ipgoGoalData
										}
										]
							});
						});
				},
			beforeSend:function(){
			},complete:function(){
			},
			error : function(request, status, error)
			{
			}
	});
}
//입고 - 목표대비 달성률 END

//입고 - 전주동기대비 START
function getIpgoCompareStatData(centerNum, centerEng) {
	$.ajax(
	{
		type : 'POST',
		url : '/monitor/m100/m100101/getIpgoCompareStatData.do',
		data : (
				{
					centerNum : centerNum
				}),
		dataType : 'json',
		success : function(data)
		{
			$.each(data, function(key, value)
			{
			    
			    if (isEmpty(value))
				{
			    	$('#signalloadImage2_'+centerEng).attr("src","/images/monitor/b.png");
			    	$('#signalloadText2_'+centerEng).attr("style","left: 26px; top: 72px; width: 199px; height: 71px; position: absolute; font-family: &quot;맑은 고딕&quot;; font-size: 50px; font-weight: normal; text-align: right; color: rgb(0, 162, 255);");
			    	
			      	$('#signalloadText2_'+centerEng).empty();
			      	$('#signalloadText2_'+centerEng).append('<div><span>0%</span></div>')
				}
			    else{
			    	if(0 < value[0].PS) {
				    	$('#signalloadImage2_'+centerEng).attr("src","/images/monitor/r.png");
				    	$('#signalloadText2_'+centerEng).attr("style","left: 26px; top: 72px; width: 199px; height: 71px; position: absolute; font-family: &quot;맑은 고딕&quot;; font-size: 50px; font-weight: normal; text-align: right; color: rgb(255, 0, 0);");
		
				      	$('#signalloadText2_'+centerEng).empty();
				      	$('#signalloadText2_'+centerEng).append('<div><span>' + value[0].PS + '%</span></div>')
			    	} else {
				    	$('#signalloadImage2_'+centerEng).attr("src","/images/monitor/b.png");
				    	$('#signalloadText2_'+centerEng).attr("style","left: 26px; top: 72px; width: 199px; height: 71px; position: absolute; font-family: &quot;맑은 고딕&quot;; font-size: 50px; font-weight: normal; text-align: right; color: rgb(0, 162, 255);");
				    	
				      	$('#signalloadText2_'+centerEng).empty();
				      	$('#signalloadText2_'+centerEng).append('<div><span>' + value[0].PS + '%</span></div>')
			    	}
			    }
			});
		},
	beforeSend:function(){
		$('#outputItemChart'+centerEng).empty();
		$('#outputItemChart'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
		 
	},complete:function(){
		$('#outputItemChart'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
	},
		error : function(request, status, error)
		{
		}
	});
}
//입고 - 전주동기대비 END

//온도 현황, 습도 현황 START
function getWeekSensorData(center, centerEng) {
	$.ajax(
		{
			type : 'POST',
			url : '/monitor/m100/m100101/getWeekSensorData.do',
			data : (
					{
						center : center
					}),
			dataType : 'json',
			success : function(data)
			{
				$.each(data, function(key, value)
				{
					var tempWeekData = new Array();
					var humiWeekData = new Array();

					if (isEmpty(value))
					{
						for (var i = 0; i < 4; i++) {
							tempWeekData.push(0);
							humiWeekData.push(0);
						}
					}
					else{
						tempWeekData.push({
			                name: "3주전",
			                y: value[0].SENSOR_VALUE2,
			                color: "#3F87D3"
			            });
						tempWeekData.push({
			                name: "2주전",
			                y: value[1].SENSOR_VALUE2,
			                color: "#3F87D3"
			            });
						tempWeekData.push({
			                name: "1주전",
			                y: value[2].SENSOR_VALUE2,
			                color: "#3F87D3"
			            });
						tempWeekData.push({
			                name: "현재",
			                y: value[3].SENSOR_VALUE2,
			                color: "#3F87D3"
			            });
						
						humiWeekData.push({
			                name: "3주전",
			                y: value[0].SENSOR_VALUE1,
			                color: "#3F87D3"
			            });
						humiWeekData.push({
			                name: "2주전",
			                y: value[1].SENSOR_VALUE1,
			                color: "#3F87D3"
			            });
						humiWeekData.push({
			                name: "1주전",
			                y: value[2].SENSOR_VALUE1,
			                color: "#3F87D3"
			            });
						humiWeekData.push({
			                name: "현재",
			                y: value[3].SENSOR_VALUE1,
			                color: "#3F87D3"
			            });
					}

					$('#tempWeekGraph'+centerEng).highcharts(
					{
						chart: {
							type: 'column',
				            backgroundColor:'transparent',
				            plotBackgroundColor: "rgba(255,200,200,0)",
				            backgroundColor: "rgba(255,255,255,0)",
				            borderColor: "rgba(255,255,255,0)"
				        },
				        exporting: { enabled: false },
				        colors: [
				            "#6b1c9d",
				            "#3d3d9c",
				            "#4b6fe2",
				            "#3396fe",
				            "#25c2fe",
				            "#4b74a1",
				            "#317631",
				            "#ffbe35",
				            "#fe7046",
				            "#b34646"
				        ],
				        credits: {},
				        title: "",
				        xAxis: {
				        	categories: ['3주전', '2주전', '1주전', '현재'],
				            lineColor: "#2A4573",
				            alternateGridColor: "rgba(255,255,255,0)",
				            tickLength: 0,
				            labels: {
				              style: {
				                color: "#3F67AC",
				                fontFamily: "맑은 고딕",
				                fontSize: "12px",
				                fontWeight: "normal"
				              }
				            }
				        },
				        yAxis: [
				            {
				              opposite: false,
				              lineColor: "#2A4573",
				              gridLineColor: "#2A4573",
				              alternateGridColor: "rgba(255,255,255,0)",
				              title: "",
				              labels: {
				                style: {
				                  color: "#3F67AC",
				                  fontFamily: "맑은 고딕",
				                  fontSize: "12px",
				                  fontWeight: "normal"
				                }
				              }
				            }
				        ],
				        tooltip: {
				            backgroundColor: "rgba(255,255,255,0.85)",
				            borderColor: "rgba(255,255,255,1)",
				            style: {
				              color: "#3E576F",
				              fontFamily: "Verdana",
				              fontSize: "12px",
				              fontWeight: "normal"
				            }
				        },
				        plotOptions: {
				            series: {
				              shadow: false,
				              lineWidth: 2,
				              allowPointSelect: false,
				              borderColor: "#FFFFFF",
				              borderWidth: 0,
				              borderRadius: 2,
				              barType: "none",
				              animation: {
				                duration: 1000
				              },
				              marker: {},
				              dataLabels: {
				                style: {
				                  color: "#CCECFF",
				                  fontFamily: "Verdana",
				                  fontSize: "12px",
				                  fontWeight: "normal"
				                }
				              },
				              point: {
				                events: {}
				              }
				            }
				        },
				        legend: {
				            enabled: false,
				            backgroundColor: "rgba(255,255,255,0)",
				            borderColor: "rgba(144,144,144,1)",
				            itemStyle: {
				              color: "#274B6D",
				              fontFamily: "Verdana",
				              fontSize: "12px",
				              fontWeight: "normal"
				            }
				        },
				        series: [{
		                     name: "평균온도",
		                     color: "#3F87D3",
		                     type: "column",
		                     showInLegend: true,
		                     stacking: "",
		                     stack: "g1",
		                     yAxis: 0,
		                     marker: {
		                       enabled: true,
		                       symbol: "circle"
		                     },
		                     dataLabels: {
		                       enabled: true,
		                       formatter: function () {
			                        return this.y;
			                    }
		                     },
		                     data: tempWeekData
		                   }
		                ]
				    });
					
					$('#humiWeekGraph'+centerEng).highcharts(
					{
						chart: {
							type: 'column',
				            backgroundColor:'transparent',
				            plotBackgroundColor: "rgba(255,200,200,0)",
				            backgroundColor: "rgba(255,255,255,0)",
				            borderColor: "rgba(255,255,255,0)"
				        },
				        exporting: { enabled: false },
				        colors: [
				            "#6b1c9d",
				            "#3d3d9c",
				            "#4b6fe2",
				            "#3396fe",
				            "#25c2fe",
				            "#4b74a1",
				            "#317631",
				            "#ffbe35",
				            "#fe7046",
				            "#b34646"
				        ],
				        credits: {},
				        title: "",
				        xAxis: {
				        	categories: ['3주전', '2주전', '1주전', '현재'],
				            lineColor: "#2A4573",
				            alternateGridColor: "rgba(255,255,255,0)",
				            tickLength: 0,
				            labels: {
				              style: {
				                color: "#3F67AC",
				                fontFamily: "맑은 고딕",
				                fontSize: "12px",
				                fontWeight: "normal"
				              }
				            }
				        },
				        yAxis: [
				            {
				              opposite: false,
				              lineColor: "#2A4573",
				              gridLineColor: "#2A4573",
				              alternateGridColor: "rgba(255,255,255,0)",
				              title: "",
				              labels: {
				                style: {
				                  color: "#3F67AC",
				                  fontFamily: "맑은 고딕",
				                  fontSize: "12px",
				                  fontWeight: "normal"
				                }
				              }
				            }
				        ],
				        tooltip: {
				            backgroundColor: "rgba(255,255,255,0.85)",
				            borderColor: "rgba(255,255,255,1)",
				            style: {
				              color: "#3E576F",
				              fontFamily: "Verdana",
				              fontSize: "12px",
				              fontWeight: "normal"
				            }
				        },
				        plotOptions: {
				            series: {
				              shadow: false,
				              lineWidth: 2,
				              allowPointSelect: false,
				              borderColor: "#FFFFFF",
				              borderWidth: 0,
				              borderRadius: 2,
				              barType: "none",
				              animation: {
				                duration: 1000
				              },
				              marker: {},
				              dataLabels: {
				                style: {
				                  color: "#CCECFF",
				                  fontFamily: "Verdana",
				                  fontSize: "12px",
				                  fontWeight: "normal"
				                }
				              },
				              point: {
				                events: {}
				              }
				            }
				        },
				        legend: {
				            enabled: false,
				            backgroundColor: "rgba(255,255,255,0)",
				            borderColor: "rgba(144,144,144,1)",
				            itemStyle: {
				              color: "#274B6D",
				              fontFamily: "Verdana",
				              fontSize: "12px",
				              fontWeight: "normal"
				            }
				        },
				        series: [{
		                     name: "평균습도",
		                     color: "#3F87D3",
		                     type: "column",
		                     showInLegend: true,
		                     stacking: "",
		                     stack: "g1",
		                     yAxis: 0,
		                     marker: {
		                       enabled: true,
		                       symbol: "circle"
		                     },
		                     dataLabels: {
		                       enabled: true,
		                       formatter: function () {
		                    	   return this.y;
			                    }
		                     },
		                     data: humiWeekData
		                   }
		                ]
				    });
					
				})
		  },
		  beforeSend:function(){
		  	$('#earthquakeGraph'+centerEng).empty();
		  	$('#earthquakeGraph'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
		  	 
		  },complete:function(){
		  	$('#earthquakeGraph'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
		  },
			error : function(request, status, error)
			{
			}
		});	
}
//온도 현황, 습도 현황 END

//화재 요약정보 START
function getSummationFireData(centerEng) {
	$.ajax(
	{
		type : 'POST',
		url : '/monitor/m100/m100101/getSummationFireData.do',
		dataType : 'json',
		success : function(data)
		{
			$.each(data, function(key, value)
			{
				if(isEmpty(value)) {
					var summationFireData = 0;
				}
				else{
					var summationFireData = value[0].COUNT;
				}
				
				//////////요약정보 - Start//////////
		        $('#fireImg').empty();
		        $('#fireStat').empty();
				
				//화재감시
				if(value[0].COUNT > 0){
		        	$('#fireImg').append('<i class="fa fa-check-circle fa-2x" style="color: red"></i>');
		        	$('#fireStat').append('<p style="color: #DC143C"><b>화재감지</b></p>');
		        } else {
		        	$('#fireImg').append('<i class="fa fa-check-circle fa-2x" style="color: green"></i>');
		        	$('#fireStat').append('<p style="color:#1E90FF"><b>이상없음</b></p>');
		        }
				//////////센서정보 - End//////////
			});
		},
	    beforeSend:function(){
	    	$('#earthquake'+centerEng).empty();
	    	$('#earthquake'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
	    	$('#temperature'+centerEng).empty();
	    	$('#temperature'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
	    	 
	    },complete:function(){
	    	$('#earthquake'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
	    	$('#temperature'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
	    },
		error : function(request, status, error)
		{
		}
	});
}
//화재 요약 정보 END

//온도, 습도 요약정보, 센서정보 START
function getSummationTemperatureData(centerEng) {
	$.ajax(
	{
		type : 'POST',
		url : '/monitor/m100/m100101/getSummationTemperatureData.do',
		dataType : 'json',
		success : function(data)
		{
			$.each(data, function(key, value)
			{
				var spdoAvg = 0;
				var spdoSum = 0;
				var ondoAvg = 0;
				var ondoSum = 0;
				
				if(isEmpty(value)) {
					for (var i = 0; i < 10; i++) {
						fireData.push(0);
					}
				}
				else{
					
					for (var i = 0; i < value.length; i++) {
						spdoSum += value[i].SENSOR_VALUE;
						ondoSum += value[i].SENSOR_VALUE2;
					}
					fireData.push(value[0].RESULT);
					fireData.push(value[0].RESULT);
					fireData.push(value[1].RESULT);
					fireData.push(value[1].RESULT);
					fireData.push(value[2].RESULT);
					fireData.push(value[2].RESULT);
					fireData.push(value[3].RESULT);
					fireData.push(value[3].RESULT);
					fireData.push(value[0].RESULT);
					fireData.push(value[0].RESULT);
					
					spdoAvg =  spdoSum / value.length;
					ondoAvg =  ondoSum / value.length;

					//////////요약정보 - Start//////////
					$('#tempImg').empty();
					$('#humidityImg').empty();

			        $('#tempStat').empty();
			        $('#humidityStat').empty();
					
					//온도상태
					if(ondoAvg > 0){
						$('#tempImg').append('<i class="fa fa-check-circle fa-2x" style="color: green"></i>');
			        	$('#tempStat').append("평균온도 : <b>" + ondoAvg.toFixed(1) + "℃</b>");
			        } else {
			        	$('#tempImg').append('<i class="fa fa-check-circle fa-2x" style="color: red"></i>');
			        	$('#tempStat').append('<p style="color: #DC143C"><b>센서 이상 감지</b></p>');
			        }
					
					//습도상태
					if(spdoAvg > 0){
						$('#humidityImg').append('<i class="fa fa-check-circle fa-2x" style="color: green"></i>');
			        	$('#humidityStat').append("평균습도 : <b>" + spdoAvg.toFixed(2) + "%</b>");
			        } else {
			        	$('#humidityImg').append('<i class="fa fa-check-circle fa-2x" style="color: red"></i>');
			        	$('#humidityStat').append('<p style="color: #DC143C"><b>센서 이상 감지</b></p>');
			        }
					
					$('#refImg').empty();
			        $('#refStat').empty();
			        
			        $('#refImg').append('<i class="fa fa-check-circle fa-2x" style="color: green"></i>');
		        	$('#refStat').append('<p style="color: #1E90FF"><b>이상없음</b></p>');
				}
				
			});
		},
	    beforeSend:function(){
	    	$('#tempImg'+centerEng).empty();
	    	$('#tempStat'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
	    	$('#humidityImg'+centerEng).empty();
	    	$('#humidityStat'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
	    	 
	    },complete:function(){
	    	$('#tempStat'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
	    	$('#humidityStat'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
	    },
		error : function(request, status, error)
		{
		}
	});
}
//온도, 습도 요약정보, 센서정보 END

//지진 현황 START
function getRealTimeEarthquake(center, centerEng) {
	$.ajax(
	{
		type : 'POST',
		url : '/monitor/m100/m100101/getRealTimeEarthquake.do',
		data : (
				{
					center : center
				}),
		dataType : 'json',
		success : function(data)
		{
			$.each(data, function(key, value)
			{
				if (isEmpty(value))
				{
					var earthquakeData = 0;
				}
				else{
					var earthquakeData = value[0].SENSOR_VALUE;
				}
				Highcharts.setOptions({
		            global: {
		                useUTC: false
		            }
		        });
				
				$('#earthquakeGraph'+centerEng).highcharts({
					chart: {
		                type: 'spline',
		                animation: Highcharts.svg,
		                backgroundColor:'transparent',
		                events: {
		                    load: function () {
		                        var series = this.series[0];
		                        setInterval(function () {
		                            var x = (new Date()).getTime(), // current time
		                                y = earthquakeData + (Math.random() / 10);
		                            series.addPoint([x, y], true, true);
		                        }, 1000);
		                    }
		                }
		            },
		            title: {
		                text: ' '
		            },
		            xAxis: {
		                type: 'datetime',
		                tickPixelInterval: 100
		            },
		            yAxis: {
		                title: {
		                    text: ' '
		                },
		                plotLines: [{
		                    value: 0,
		                    width: 1,
		                    color: '#808080'
		                }],
		                max: 3
		            },
		            tooltip: {
		                formatter: function () {
		                    return '<b>' + Highcharts.numberFormat(this.y, 2) + '</b>';
		                }
		            },
		            legend: {
		                enabled: false
		            },
		            exporting: {
		                enabled: false
		            },
		            series: [{
		            	color: 'red',
		                data: (function () {
		                    var data = [],
		                        time = (new Date()).getTime(),
		                        i;

		                    for (i = -5; i <= 0; i += 1) {
		                        data.push({
		                            x: time + i * 1000,
		                            y: earthquakeData + (Math.random() / 10)
		                        });
		                    }
		                    return data;
		                }())
		            }]
		        });
			})
	    },
	    beforeSend:function(){
	    	$('#earthquakeGraph'+centerEng).empty();
	    	$('#earthquakeGraph'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
	    	 
	    },complete:function(){
	    	$('#earthquakeGraph'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
	    },
		error : function(request, status, error)
		{
		}
	});
}
//지진 현황 END

//아이템 별 입고현황 START
function getItemIpgoDataByDesktop(centerNum, centerEng) {
	$.ajax(
	{
		type : 'POST',
		url : '/monitor/m100/m100101/getItemIpgoDataByDesktop.do',
		data : (
				{
					centerNum : centerNum
				}),
		dataType : 'json',
		success : function(data)
		{
			$.each(data, function(key, value)
			{
			    var colors = Highcharts.getOptions().colors,
		        browserData = [],
		        versionsData = [],
		        i,
		        j,
		        valueLen = value.length,
		        brightness;
			    
			    if (isEmpty(value))
				{
			    	versionsData.push({
		                name: "입고예정",
		                y: 11,
		                color: "#3F87D3"
		            });
				}
				else{
					 for (i = 0; i < valueLen; i += 1) {
					    	brightness = 0.2 - (i / valueLen) / 5;
				            versionsData.push({
				                name: value[i].IPGO_ITEM,
				                y: value[i].IPGO_SUM,
				                color: Highcharts.Color(colors[i]).brighten(brightness).get()
				            });
					    }
				}
			    
			    

			    $('#inputItemChart'+centerEng).highcharts({
			    	chart: {
			            type: 'pie',
			            backgroundColor:'transparent'
			        },
			        exporting: { enabled: false },
			        title: {
			            text: ''
			        },
			        yAxis: {
			            title: {
			                text: 'Total percent market share'
			            }
			        },
			        plotOptions: {
			        	pie: {
		                    allowPointSelect: true,
		                    cursor: 'pointer',
		                    dataLabels: {
		                        enabled: false
		                    },
		                    showInLegend: true
		                }
			        },
			        legend: {
		                backgroundColor: "rgba(255,255,255,0)",
		                borderColor: "rgba(144,144,144,1)",
		                itemStyle: {
		                  color: "rgb(206, 213, 220)",
		                  fontFamily: "Verdana",
		                  fontSize: "10px",
		                  fontWeight: "normal"
		                },
		                itemHoverStyle: {
		                  "color": "rgba(12,204,204,1)",
		                  "fontSize": "10px"
		                },
		                itemHiddenStyle: {
		                  color: "rgba(0,0,0,1)",
		                  fontSize: "10px"
		                }
		              },
			        tooltip: {
			            pointFormat: '<b>{point.percentage:.1f}%</b>'
			        },
			        series: [{
			            name: 'Browsers',
			            data: browserData,
			            size: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 5 ? this.point.name : null;
			                },
			                color: '#ffffff',
			                distance: -30
			            }
			        }, {
			            name: 'Versions',
			            data: versionsData,
			            size: '80%',
			            innerSize: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 1 ? this.y + '%' : null;
			                }
			            }
			        }]
				});
			});
			   
		},
	    beforeSend:function(){
	    	$('#inputItemChart'+centerEng).empty();
	    	$('#inputItemChart'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
	    	 
	    },complete:function(){
	    	$('#inputItemChart'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
	    },
		error : function(request, status, error)
		{
		}
	});
}
//아이템 별 입고현황 END


//아이템 별 출고현황 START
function getItemClgoDataByDesktop(centerNum, centerEng) {
	$.ajax(
	{
		type : 'POST',
		url : 'getItemClgoDataByDesktop.do',
		data : (
				{
					centerNum : centerNum
				}),
		dataType : 'json',
		success : function(data)
		{
			$.each(data, function(key, value)
			{
			    var colors = Highcharts.getOptions().colors,
		        browserData = [],
		        versionsData = [],
		        i,
		        j,
		        valueLen = value.length,
		        brightness;
			    
			    if (isEmpty(value))
				{
			    	versionsData.push({
		                name: "출고예정",
		                y: 21,
		                color: "#3F87D3"
		            });
				}
			    else{
				    for (i = 0; i < valueLen; i += 1) {
				    	brightness = 0.2 - (i / valueLen) / 5;
			            versionsData.push({
			                name: value[i].CLGO_ITEM,
			                y: value[i].CLGO_SUM,
			                color: Highcharts.Color(colors[i]).brighten(brightness).get()
			            });
				    }
			    }
			    
			    $('#outputItemChart'+centerEng).highcharts({
			        chart: {
			            type: 'pie',
			            backgroundColor:'transparent'
			        },
			        exporting: { enabled: false },
			        title: {
			            text: ''
			        },
			        yAxis: {
			            title: {
			                text: 'Total percent market share'
			            }
			        },
			        plotOptions: {
			        	pie: {
		                    allowPointSelect: true,
		                    cursor: 'pointer',
		                    dataLabels: {
		                        enabled: false
		                    },
		                    showInLegend: true
		                }
			        },
			        legend: {
		                backgroundColor: "rgba(255,255,255,0)",
		                borderColor: "rgba(144,144,144,1)",
		                itemStyle: {
		                  color: "rgb(206, 213, 220)",
		                  fontFamily: "Verdana",
		                  fontSize: "10px",
		                  fontWeight: "normal"
		                },
		                itemHoverStyle: {
		                  "color": "rgba(12,204,204,1)",
		                  "fontSize": "10px"
		                },
		                itemHiddenStyle: {
		                  color: "rgba(0,0,0,1)",
		                  fontSize: "10px"
		                }
		              },
			        tooltip: {
			            pointFormat: '<b>{point.percentage:.1f}%</b>'
			        },
			        series: [{
			            name: 'Browsers',
			            data: browserData,
			            size: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 5 ? this.point.name : null;
			                },
			                color: '#ffffff',
			                distance: -30
			            }
			        }, {
			            name: 'Versions',
			            data: versionsData,
			            size: '80%',
			            innerSize: '60%',
			            dataLabels: {
			                formatter: function () {
			                    return this.y > 1 ? this.y + '%' : null;
			                }
			            }
			        }]
				});
			});
		},
	    beforeSend:function(){
	    	$('#outputItemChart'+centerEng).empty();
	    	$('#outputItemChart'+centerEng).append('<img id="loadingImage" src="/images/monitor/loading_desktop.gif" style="padding-top: 80px;display: block; margin: auto auto;">')
	    	 
	    },complete:function(){
	    	$('#outputItemChart'+centerEng + ' img[src$="/images/monitor/loading_desktop.gif"]').remove();
	    },
		error : function(request, status, error)
		{
		}
	});
}
//아이템 별 출고현황 END


function isEmpty(value)
{
	if (value == ""
			|| value == null
			|| value == undefined
			|| (value != null && typeof value == "object" && !Object
					.keys(value).length))
	{
		return true
	} else
	{
		return false
	}
}

setInterval(
    function() {
        $('#card').flip({
                    direction: 'tb',
                    speed: 500
                });
    },
    1000);