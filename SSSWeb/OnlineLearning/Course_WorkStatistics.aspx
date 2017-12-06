<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_WorkStatistics.aspx.cs" Inherits="SSSWeb.OnlineLearning.Course_WorkStatistics" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>作业统计</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/echarts.js"></script>
</head>
<body style="background:white;">
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div>
            <div class="newcourse_dialog_detail" style="margin-top:35px;">
                <div class="clearfix">
                       <div id="div_work" style="margin:auto;width:45%; height: 500px;"></div>                       
                </div>
                <div id="div_stuContent" class="course_learned fr bordshadrad pr" style="display:none;width:500px;">                
                <p class="learned_title"></p>
                <div class="class_selectwrap">
                    <ul class="class_select" id="ul_stuContent"></ul>
                </div>
               </div>
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
            GetWorkStatisticsInfo();
        });
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('div_work'));
        // 指定图表的配置项和数据
        option = {
            title: {
                text: decodeURIComponent(UrlDate.workname) + '-作业统计',
                subtext: '',
                x: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['优', '良', '中', '差', '未批改作业', '未提交作业']
            },
            series: [
                {
                    name: decodeURIComponent(UrlDate.workname) + '-作业统计',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: [

                    ],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        //绑定数据
        function GetWorkStatisticsInfo() {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func: "GetWorkStatisticsInfo",
                    WorkId: UrlDate.workid,
                    CourseID: UrlDate.courseid,
                    CourseType: UrlDate.coursetype
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        myChart.setOption({ //加载数据图表
                            legend: { data: ['优', '良', '中', '差', '未批改作业', '未提交作业'] },
                            series: [{
                                data:json.result.retData
                            }]
                        });
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        myChart.on('click', function (params) {
            $('#ul_stuContent').html('');
            var status = GetScoreStatus(params.name);
            $('.learned_title').html(params.name + "的员工");
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func: "GetStuWorkCompleteInfo",
                    WorkId: UrlDate.workid,
                    ScoreStatus: status,
                    CourseID:UrlDate.courseid,
                    CourseType: UrlDate.coursetype
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {                        
                        $("#ul_stuContent").append("<li><ul style='display: block;' id='ul_workgrade'></ul></li>");
                        $("#ul_workgrade").append("<li><ul id='ul_workclass' class='learned_students_lists clearfix' style='display: block;'></ul></li>");
                        $(json.result.retData).each(function () {
                            $("#ul_workclass").append("<li><div class='learned_students_img'><img src=\"" + this.AbsHeadPic + "\" alt='' onerror=\"javascript:this.src='../images/discuss_img_01.jpg'\"/></div><p class='learned_students_name' title=\"" + this.Name + "\">" + (this.Name.length > 3 ? cutstr(this.Name, 4) : this.Name) + "</p></li>");
                        });                                       
                    }
                    else {
                        $('#ul_stuContent').html("<li><span>无" + params.name + "的员工</span></li>");
                    }
                    layer.open({
                        type: 1,
                        shade: false,
                        title: false, //不显示标题
                        content: $('#div_stuContent'), //捕获的元素
                        area: ['532px', 'auto'],
                        cancel: function (index) {
                            layer.close(index);
                        }
                    });
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        });
        function GetScoreStatus(name) {
            var status = 0;
            switch (name) {
                case "未提交作业":
                    status = 0;
                    break;
                case "优":
                    status = 1;
                    break;
                case "良":
                    status = 2;
                    break;
                case "中":
                    status = 3;
                    break;
                case "差":
                    status = 4;
                    break;
                case "未批改作业":
                    status = 5;
                    break;
            }
            return status;
        }
    </script>
</body>
</html>