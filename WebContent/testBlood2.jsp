<!DOCTYPE html>
<head>
    <meta charset="utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>ECharts</title>
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
	<style>
		#menuuu{
			position:absolute;
			border: 1px outset #F6F6F6 !important; 
			border-color:#FFFFFF;
			z-index:10000; 
			left:300px; 
			top:200px; 
			display:none; 
			width:100px; 
			height:65px; 
			background: #CCCCCC; 
			filter:alpha(opacity:80);
			opacity:0.8;
			overflow: hidden;
			
		}
		#menuuu ul{
			padding-top: 5px;
			padding-left: 2px;
			margin:0px;
			list-style-type:none;
			vertical-align:middle;
		}
		#menuuu ul li {
			padding:0px;
			margin-top:1px;
			border-top: 1px solid #F6F6F6 !important;	
			border-bottom: 1px outset #F6F6F6 !important;
			border-color:#FFFFFF;
			font-family:"微软雅黑";
			width:96px;
			font-size:13px;
			vertical-align: middle;
			text-align:center;
		}
		#menuuu font {
			padding-left: 4px;
			vertical-align:top ;
		}
	</style>
	<script language="javascript">
		
		
		document.oncontextmenu=function()  
            {  
               return false;  
            } 

		
	</script>
</head>
<body >
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width:800px;height:400px;overflow:auto;">
    </div>

    <!-- ECharts单文件引入 -->
    
    <script src="./echarts-test/echarts-2.2.7/build/dist/echarts.js"></script>
    <script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: './echarts-test/echarts-2.2.7/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/force', // 使用柱状图就加载bar模块，按需加载
				'echarts/chart/chord', // 使用和弦图就加载bar模块，按需加载
                'echarts/theme/macarons'
            ],
           
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main'),'macarons'); 
                
                  
							  var nodes = [];
							  var links = [];
							  var constMaxDepth = 4;
							  var constMaxChildren = 3;
							  var constMinChildren = 2;
							  var constMaxRadius = 10;
							  var constMinRadius = 2;
							  var mainDom = document.getElementById('main');
							  
							  
							  option = {
							    title : {
							        text: '血缘分析：宽带建设日报',
							        subtext: '数据来至EDW建设五期',
							        x:'right',
							        y:'bottom'
							    },								
							    tooltip : {
							        trigger: 'item',
							        formatter: '{a} : {b}'
							    },
							    toolbox: {
							        show : true,
							        feature : {
							            restore : {show: true},
							            magicType: {show: true, type: ['force', 'chord']},
							            saveAsImage : {show: true}
							        }
							    },
							    legend: {
							        x: 'left',
							        data:['报表','指标','表']
							    },
								
							    series : [
							        {
							            type:'force',
							            name : "血缘关系",
							            linkSymbol: 'arrow',
							            symbol:'rectangle',
							            ribbonType: false,
							            categories : [
							                {
							                    name: '报表',
												symbol:'rectangle'
							                },
							                {
							                    name: '指标',
												symbol:'diamond'
							                },
							                {
							                    name:'表'
							                }
							            ],
							            itemStyle: {
							                normal: {
							                    label: {
							                        show: true,
							                        textStyle: {
							                            color: '#333'
							                        }
							                    },
							                    nodeStyle : {
							                        brushType : 'both',
							                        borderColor : 'rgba(255,215,0,0.4)',
							                        borderWidth : 2
							                        
							                    },
							                    linkStyle: {
							                        type: 'line'//'curve'
							                    }
							                },
							                emphasis: {
							                    label: {
							                        show: false
							                        // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
							                    },
							                    nodeStyle : {
							                        //r: 30
							                    },
							                    linkStyle : {}
							                }
							            },
							            useWorker: false,
							            minRadius : 15,
							            maxRadius : 25,
							            gravity: 1,
							            scaling: 1,
							            roam: 'scale',
							            nodes:
							            [
							                {category:0, name: 'root', value : 10, label: '宽带建设日报',initial : [50, 150],fixX : true,fixY :true,
												itemStyle: {normal: {label: {show: true,textStyle: {color: 'red',fontWeight: 'bold',fontSize:14}}}}
											},
							                {category:1, name: 'a1',value : 2,label: '当月已完工项目数',initial : [200,75],fixX : true,fixY : true},
							                {category:1, name: 'a2',value : 2,label: '本年累计待装库工单',initial : [200, 150],fixX : true,fixY : true},
							                {category:1, name: 'a3',value : 2,label: '用户需求满足率',initial : [200, 225],fixX : true,fixY : true},
											{category:1, name: 'a4',value : 2,label: '更多...',initial : [200, 300],fixX : true,fixY : true,ignore:true},
							                {category:2, name: 'b1',value : 4,label: 'wid_cc_accept_day',initial : [350, 150],fixX : true,fixY : true},
							                {category:2, name: 'c1',value : 4,label: 'wid_cc_accept_day1',initial : [450, 75],fixX : true,fixY : true},
											{category:2, name: 'c2',value : 4,label: 'wid_cc_accept_day2',initial : [450, 225],fixX : true,fixY : true},
							                {category:2, name: 'd1',value : 4,label: 'wid_cc_accept_day3',initial : [550, 50],fixX : true,fixY : true},
											{category:2, name: 'd2',value : 4,label: 'wid_cc_accept_day4',initial : [550, 100],fixX : true,fixY : true},
											{category:2, name: 'd3',value : 4,label: 'wid_cc_accept_day5',initial : [550, 175],fixX : true,fixY : true},
											{category:2, name: 'd4',value : 4,label: 'wid_cc_accept_day6',initial : [550, 250],fixX : true,fixY : true}
							             
							            ],
							            links :[
							                {source : 'a1', target : 'root', name: '宽表应用指标'},
							                {source : 'a2', target : 'root',  name: '宽表应用指标'},
							                {source : 'a3', target : 'root',  name: '宽表应用指标'},
											{source : 'a4', target : 'root',  name: '宽表应用指标'},
							                {source : 'b1', target : 'a1', name: '结果表提取指标'},
											{source : 'b1', target : 'a2', name: '结果表提取指标'},
											{source : 'b1', target : 'a3', name: '结果表提取指标'},
											{source : 'c1', target : 'b1', name: '指标依赖'},
											{source : 'c2', target : 'b1', name: '指标依赖'},
											{source : 'd1', target : 'c1', name: '指标依赖'},
											{source : 'd2', target : 'c1', name: '指标依赖'},
											{source : 'd3', target : 'c2', name: '指标依赖'},
											{source : 'd4', target : 'c2', name: '指标依赖'}
							            ]
							        }
							    ]
							};
							var ecConfig = require('echarts/config');
							function focus(param) {
							    var data = param.data;
							    var links = option.series[0].links;
							    var nodes = option.series[0].nodes;
								var event = param.event;
								var pageX = event.pageX;
								var pageY = event.pageY;
								var menu = document.getElementById("menuuu");
							    if (
							        data.source !== undefined
							        && data.target !== undefined
							    ) { //点击的是边
							        var sourceNode = nodes.filter(function (n) {return n.name == data.source})[0];
							        var targetNode = nodes.filter(function (n) {return n.name == data.target})[0];
							        alert("选中了边: " + sourceNode.name + ' -> ' + targetNode.name );
							    } else { // 点击的是点
							        //alert("选中了:" + data.label + '(' + data.category + ')');
									
									menu.style.left = pageX + 'px';
									menu.style.top = pageY + 'px';
									menu.style.display = "block";
							    }
							}
							


							//myChart.on(ecConfig.EVENT.CONTEXTMENU, rightBt);
							
							/*
							myChart.on(ecConfig.EVENT.FORCE_LAYOUT_END, function () {
							    //alert(myChart.chart.force.getPosition());
							});*/
							
							
							                    
							
							myChart.setOption(option);   
							//myChart.setTheme(ec);
						}                    
        );
		/*
		function rightBt (evt){
			var menu = document.getElementById("menuuu");
			var evt= window.event || arguments[0]; 
 
			var pageY = parseInt(evt.clientY);  
            var pageX = parseInt(evt.clientX);

			menu.style.left = pageX + 'px';
			menu.style.top = pageY + 'px';
			menu.style.display = "block";
		}
		
		oncontextmenu = rightBt; */
    </script>
</body>