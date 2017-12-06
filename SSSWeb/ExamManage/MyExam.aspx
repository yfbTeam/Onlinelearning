<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyExam.aspx.cs" Inherits="SSSWeb.ExamManage.MyExam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>考试管理</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>

    <style>
</style>
</head>
<body>
    <div>
        <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo %>" />

        <input type="hidden" id="hName" runat="server" />
        <input type="hidden" id="hSF" runat="server" />
        <input id="HStatus" type="hidden" value="1" />
        <input id="nohIDCard" type="hidden" value="0" />
        <input id="hIDCard" type="hidden" runat="server" />
        <input id="hClassID" type="hidden" runat="server" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../AppManage/Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/testsystem.png" />
                </div>
                <nav id="teacher" class="navbar menu_mid fl">
                    <ul id="Menu">
                        <li><a href="../StatisticalAnalysis/Status_ClassStu.aspx">班级人员</a></li>
                        <li><a href="../StatisticalAnalysis/Status_ClassCourse.aspx">班级课程</a></li>

                        <li currentclass="active"><a href="ExamQManager.aspx">题库管理</a></li>
                        <li currentclass="active"><a href="ExamManager.aspx">试卷管理</a></li>
                        <li class="active"><a href="MyExam.aspx">我的试卷</a></li>
                        <li currentclass="active"><a href="ExamAnalisy.aspx">统计分析</a></li>
                    </ul>
                </nav>

                <div class="search_account fr clearfix">
                    <ul class="account_area fl">

                        <li>
                            <a href="javascript:;" class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=UserInfo.AbsHeadPic %>" />
                                </div>
                                <h2><%=UserInfo.Name %></h2>
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
            <div class="myexam bordshadrad">
                <div class="stytem_select clearfix">

                    <div id="teacher1" class="stytem_select_left fl">
                        <a href="javascript:;" class="on" onclick="on(1)">未阅试卷</a>
                        <a href="javascript:;" onclick="on(2)">已阅试卷</a>
                    </div>
                    <div class="stytem_select_right fr">
                        <div class="search_exam fl pr">
                            <input type="text" name="" id="chaxun" onblur="getData(1, 10)" value="" placeholder="试卷名称" />
                            <i class="icon  icon-search"></i>
                        </div>
                        <span class="enable">
                            <span value="" id="sel_Type">请选择</span><i class="icon icon-angle-down"></i>
                            <div class="enable_wrap none">
                                <span value="" class="active" onclick="ChangePaperType(null)">全部</span>
                                <span value="1" onclick="ChangePaperType(1)">考试</span>
                                <span value="2" onclick="ChangePaperType(2)">测试</span>
                                <span value="3" onclick="ChangePaperType(3)">作业</span>
                                <span value="4" onclick="ChangePaperType(4)">问卷调查</span>
                            </div>
                        </span>

                    </div>
                </div>
                <div class="test_norelase">
                    <ul class="test_lists exam_lists" id="NoExam">
                    </ul>
                    <ul class="test_lists exam_lists none" id="YesExam">
                    </ul>
                </div>
                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                    <span id="neverpageBar"></span>
                </div>
                <div id="main1"></div>
                <!---->
            </div>
        </div>
        <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
        <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>

<script type="text/javascript">

    var classid = $("#hClassID").val();

    var userid = $("#hIDCard").val();
    var classid = "";
    var subjectid = "";
    $(function () {
        GetSameLiveMenu(location.href, '<%=UserInfo.UniqueNo%>', '');
       
        getData(1, 10);
    })

    function ChangePaperType(type) {
        $("#sel_Type").attr("value", type);
        getData(1, 10);
    }
    function on(relvalue) {
        $("#HStatus").val(relvalue);
        getData(1, 10);
    }
    var relvalueid = 0;
    function onquery(relvalue) {
        relvalueid = relvalue;
        $("#nohIDCard").val(relvalue);
        getData(1, 10);
    }

    function getData(startIndex, pageSize) {

        var Status = $("#HStatus").val();
        var Title = $('#chaxun').val();
        var TypeId = $("#sel_Type").attr("value");

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: {
                PageName: "/ExamManage/ExamNationHander.ashx",
                "action": "GetExamNPageList",
                PageIndex: startIndex,
                pageSize: pageSize,
                "Status": Status,
                "Type": TypeId,
                "Title": Title,
                "CreateUID": $("#hIDCard").val(),
            },
            success: function (json) {
                var str = $('#hSF').val();
                var myDate = new Date();
                var states = $("#HStatus").val();
                if (json.result.errNum.toString() == "0") {
                    var html = "";
                    $.each(json.result.retData.PagedData, function () {
                        jsonsubjecket = json.result.retData.PagedData;
                        html += "<li class=\"clearfix\">"
                                    + "<div class=\"exam_img fl\">"
                                        + "<img src=\"../images/exam_img.png\" />"
                                    + "</div>"
                                    + "<div class=\"test_description exam_description fl\" style=\"width:200px\">";

                        if (this.Statushow == "未阅" && this.typeid != 4) {
                            html += "<h2 style=\"width:200px\"><a href='#' onclick=\"AnsweredExam(" + this.ID + ",this,1)\" id='" + this.CreateUID + "'>" + this.Title + "</a></h2>";
                        } else if (this.Statushow == "已阅" && this.typeid != 4) {
                            html += "<h2 style=\"width:200px\"><a href='#' onclick=\"AnsweredExam(" + this.ID + ",this,0)\" id='" + this.CreateUID + "'>" + this.Title + "</a></h2>";
                        } else if (relvalueid == 1 && ((Date.parse(this.WorkBeginTime) < Date.parse(myDate)) && (Date.parse(myDate) < Date.parse(this.WorkEndTime)))) {
                            if (this.typeid == 4) { html += "<h2 style=\"width:200px\"><a href='window.open(/Exam/'QuestionnaireSurvey .aspx?id=" + this.ID + "');''>" + this.Title + "</a></h2>"; }
                        } else {
                            html += "<h2 style=\"width:200px\"><a href='javacript:void(0);' style=\"color:gray;\" onclick=\"return confirm('不再规定时间内，无法评价')\">" + this.Title + "</a></h2>";
                        }

                        html += "<p style=\"width:400px\"><span class=\"test_easy\">" + this.Difficultyshow + "</span><span class=\"test_easy\">" + this.typeid + "</span>";
                        if (relvalueid != 1) {
                            if (this.typeid != 4) { html += "<span class=\"test_easy\">" + this.Statushow + "</span></p>"; }
                        }
                        html += "</div><div class=\"test_lists_right fr clearfix\" style=\"width:300px\"><div class=\"public_name fl\">作答人：" + this.CreateName;

                        html += "</div><div class=\"dates_a dates_b fr pr\" style=\"width:200px\"><div class=\"data\" style=\"width:200px\">作答时间：" + this.CreateTime_Format
                            + "</div></div></div></li>";
                    });
                    if (states == 1) {
                        $("#YesExam").html(html);
                        $("#NoExam").hide();
                        $("#YesExam").show();
                        $("#neverpageBar").hide();
                        $("#pageBar").show();
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
                    } else {
                        $("#NoExam").html(html);
                        $("#NoExam").show();
                        $("#YesExam").hide();
                        $("#pageBar").hide();
                        $("#neverpageBar").show();
                        makePageBar(getData, document.getElementById("neverpageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
                    }
                } else {
                    var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
                    if (states == 0) {
                        $("#YesExam").hide();
                        $("#NoExam").show();
                        $("#neverpageBar").hide();
                        $("#pageBar").hide();
                        $("#NoExam").html(html);
                    } else {
                        $("#NoExam").hide();
                        $("#YesExam").show();
                        $("#neverpageBar").hide();
                        $("#pageBar").hide();
                        $("#YesExam").html(html);
                    }
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    var jsonsubjecket = "";
    var createname = "";

    function AnsweredExam(idd, em, IsShow) {
        window.open('/ExamManage/AnsweredExam.aspx?id=' + idd + '&name=' + em.id + '&IsShow=' + IsShow);
    }

</script>
