<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Status_ExamScore.aspx.cs" Inherits="SSSWeb.StatisticalAnalysis.Status_ExamScore" %>

<!DOCTYPE html>


<html>
<head>
    <meta charset="utf-8" />
    <title>成绩概述</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />

    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/echarts.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>


    <script type="text/javascript" src="../js/menu_top.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }

        td {
            background: #ffffff;
            border: solid 1px #266cb8;
            height: 50px;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->

</head>
<body>

    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo %>" />
        <input id="ExamID" type="hidden" value="" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../AppManage/Index.aspx">
                    <img src="../images/logo.png" /></a>
                <%--<div class="wenzi_tips fl">
                    <img src="../images/testsystem.png" />
                </div>--%>
                <nav class="navbar menu_mid fl">
                    <ul>
                        <li><a href="StudyProcgress.aspx">学习进度查看</a></li>
                        <li class="active"><a href="#">考试成绩统计</a></li>
                    </ul>
                </nav>
                <div class="search_account fr clearfix">
                    <ul class="account_area fl">

                        <li>
                            <a href="javascript:;" class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=UserInfo.AbsHeadPic%>" />
                                </div>
                                <h2><%=UserInfo.Name%></h2>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr ">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on">成绩分析</a>
                        <a href="QuestionAnswerDetail.aspx">错题分析</a>
                    </div>
                </div>
                <div class="newcourse_select clearfix" id="CourseSel">
                    <div class="clearfix fl course_select">
                        <select name="" class="select" id="ExamPaper" onchange="ExamChange()">
                        </select>
                        <select id="Grade" class="select" onchange="GradSelChange()">
                            <option value="0">==请选择年级==</option>
                        </select>
                        <select name="" class="select" id="Class">
                            <option value="0">==请选择班级==</option>
                        </select>
                    </div>
                </div>
                <div class="wrap">

                    <table id="Course" style="padding: 5px; margin: 5px;">
                        <tr>
                            <td colspan="6">成绩概述</td>
                        </tr>
                        <tr>
                            <td style="background-color: #5098df;"></td>
                            <td colspan="3" style="background-color: #f67679;"></td>
                            <td colspan="2" style="background-color: #82a56c;"></td>
                        </tr>
                        <tbody id="AvgScore">
                        </tbody>

                    </table>
                    <table style="width: 48%; float: left; padding: 5px; margin: 5px;">
                        <tr>
                            <td colspan="5">前五名</td>
                        </tr>
                        <tr id="Top5"></tr>

                    </table>
                    <table style="width: 48%; float: right; padding: 5px; margin: 5px;">
                        <tr>
                            <td colspan="5">后五名</td>
                        </tr>
                        <tr id="Last5"></tr>


                    </table>
                    <div class="clear"></div>
                    <table style="width: 48%; height: 300px; float: left; padding: 5px; margin: 5px;">
                        <tr>
                            <td id="main"></td>
                        </tr>
                    </table>
                    <table style="width: 48%; float: right; padding: 5px; margin: 5px;">
                        <tr>
                            <td colspan="4">成绩分布</td>
                        </tr>
                        <tr>
                            <td>分档</td>
                            <td>区间</td>
                            <%--<td>人员</td>--%>
                            <td>占比</td>
                        </tr>
                        <tr>
                            <td>优秀（A）</td>
                            <td>[90,100]</td>
                            <%--<td>0</td>--%>
                            <td id="youxiu"></td>
                        </tr>
                        <tr>
                            <td>良好（B）</td>
                            <td>[70,90]</td>
                            <%--<td>1</td>--%>
                            <td id="lianghao"></td>
                        </tr>
                        <tr>
                            <td>合格（C）</td>
                            <td>[60,70]</td>
                            <%--<td>7</td>--%>
                            <td id="hege"></td>
                        </tr>
                        <tr>
                            <td>不合格（D）</td>
                            <td>[0,60]</td>
                            <%--<td>1</td>--%>
                            <td id="buhege"></td>
                        </tr>
                    </table>
                    <div class="clear"></div>

                </div>
            </div>
        </div>
        <!--分页-->
        <%--<div class="page">
            <span id="pageBar"></span>
        </div>--%>
    </form>
</body>
<script type="text/javascript" src="../js/common.js"></script>
<script>
    var UrlDate = new GetUrlDate();

    $(function () {
        GetExam();
        GetGrade();
    });
    function ExamChange() {
        GetAvgScore();
        GetTop5Stu('');
        GetTop5Stu('desc');
    }
    function GetAvgScore() {
        $("#AvgScore").html("");
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            async: "false",
            data: {
                PageName: "/ExamManage/AnaliseHander.ashx",
                "action": "GetAvgScore",
                ExamID: $("#ExamPaper").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    var tr = '<tr><td style="height: 80px;">13<br />总人数</td><td>131<br />最高分</td><td>50<br />最低分</td><td>91.9<br />平均分</td><td>7.7%<br />优秀率</td><td>46.2%<br />及格率</td></tr>';
                    $(json.result.retData).each(function () {
                        tr = '<tr><td style="height: 80px;">' + this.AllNum
                            + '<br />总人数</td><td>' + this.maxScore + '<br />最高分</td><td>' +
                            this.minScore + '<br />最低分</td><td>' +
                            this.avgScore + '<br />平均分</td><td>' + this.youxiu + '<br />优秀率</td><td>' + this.jige + '<br />及格率</td></tr>';
                        $("#youxiu").html(this.youxiu);
                        $("#lianghao").html(this.lianghao);
                        $("#hege").html(this.hege);
                        $("#buhege").html(this.buhege);

                        $("#AvgScore").append(tr);
                        getExamPaper();
                    })
                }
                else {
                    layer.msg(json.result.errMsg);
                }

            },
        });
    }
    function getExamPaper() {
        var val = "[";
        val += $("#youxiu").html() + ",";
        val += $("#lianghao").html() + ",";
        val += $("#hege").html() + ",";
        val += $("#buhege").html();

        val += "]";

        var myChart = echarts.init(document.getElementById('main'));
        option2 = {
            title: {
                text: '成绩分布',
                // subtext: '纯属虚构',
                x: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} "
            },
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    data: ["A", "B", "C", "D"]
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    name: '分数',
                    axisLabel: {
                        formatter: '{value}'
                    }
                },

            ],
            series: [
                {
                    name: '考试分数',
                    type: 'bar',
                    data: eval(val)
                },
              //{
              //    name: '考试分数',
              //    type: 'line',
              //    data: eval(val)
              //}

            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option2);
        // }

        //});

    }
    function GetTop5Stu(order) {
        $("#Last5").html("");
        $("#Top5").html("");
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            async: "false",
            data: {
                PageName: "/ExamManage/AnaliseHander.ashx",
                "action": "GetTop5Stu",
                ExamID: $("#ExamPaper").val(),
                Order: order
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    var tr = '<tr><td style="height: 80px;">13<br />总人数</td><td>131<br />最高分</td><td>50<br />最低分</td><td>91.9<br />平均分</td><td>7.7%<br />优秀率</td><td>46.2%<br />及格率</td></tr>';
                    $(json.result.retData).each(function () {
                        tr = '<td>' + this.Score + '<br />' + this.CreateName + '</td>';
                        if (order == "") {
                            $("#Last5").append(tr);
                        }
                        else {
                            $("#Top5").append(tr);
                        }
                    })
                }
                else {
                    layer.msg(json.result.errMsg);
                }

            },
        });
    }
    function GetExam() { //初始化序号 
        $("#ExamPaper").html('');//<option value="0">==请选择年级==</option>');
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            async: "false",
            data: {
                PageName: "/ExamManage/PaperHandler.ashx",
                "action": "GetExamPaperDataPage",
                IsPage: "false",
                //"Status": 2
            },
            success: function (json) {
                var i = 0;
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        if (i == 0) {
                            $("#ExamPaper").append("<option value='" + this.Id + "' selected='selected'>" + this.Title + "</option>");
                            GetAvgScore();
                            GetTop5Stu('');
                            GetTop5Stu('desc');
                            i++;
                        }
                        else {
                            $("#ExamPaper").append("<option value='" + this.Id + "'>" + this.Title + "</option>");
                            i++;
                        }
                    })
                }
                else {
                    layer.msg(json.result.errMsg);
                }

            },
        });
    }
    var jsonClass = [];
    //年级
    function GetGrade() {
        var option = '<option value="0">==请选择年级==</option>';
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            async: "false",
            data: { Func: "GetGradeClass" },
            success: function (json) {

                if (json.result.errNum.toString() == "0") {
                    var resultData = eval(json.result.retData);
                    jsonClass = resultData;
                    $(resultData).each(function () {
                        option += "<option value='" + this.id + "'>" + this.name + "</option>";

                    })
                    $("#Grade").html(option);
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
    function GradSelChange() {
        BindClass();
    }

    function BindClass() {
        $("#Class").html('<option value="0">==请选择班级==</option>');
        var GradeID = $("#Grade").val();//.children('span').attr("value").trim()
        var k = 0;
        $(jsonClass).each(function () {
            if (this.id == GradeID) {
                $.each(this.children, function () {
                    $("#Class").append("<option value='" + this.id + "'>" + this.name + "</option>");

                })
            }
        });

    }
</script>
</html>
