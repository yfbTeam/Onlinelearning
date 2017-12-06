<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Exam_Stu.aspx.cs" Inherits="SSSWeb.ExamManage.Exam_Stu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>试卷管理</title>
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
    <script src="/CourseMenu.js"></script>

    <style>
</style>
</head>
<body>
    <div>
        <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo %>" />

        <input id="HStatus" type="hidden" value="1" />
        <input id="nohIDCard" type="hidden" value="1" />
        <input id="hIDCard" type="hidden" value="<%=UserInfo.UniqueNo %>" />
        <input id="hClassID" type="hidden" value="<%= UserInfo.RegisterOrg %>" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/PersonalSpace/CourseManIndex.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/zaixianxuexi.png" />
                </div>
                <nav id="teacher" class="navbar menu_mid fl">
                    <ul id="Menu">
                        <li id="All"><a href="../PersonalSpace/CourseManIndex.aspx">课程首页</a></li>
                        <li id="Study"><a href="../PersonalSpace/PersonalSpace_Student.aspx#course-2">在学课程</a></li>
                        <li id="My"><a href="../PersonalSpace/PersonalSpace_Student.aspx#course-3">我负责的课程</a></li>
                        <li><a href="../PersonalSpace/ApplyCerty.aspx">证书申请</a></li>
                        <li class="active"><a href="../ExamManage/Exam_Stu.aspx">在线考试</a></li>
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

                    <div id="student1" class="stytem_select_left fl">
                        <a href="javascript:;" class="on" onclick="onquery(1)">未答试卷</a>
                        <a href="javascript:;" onclick="onquery(0)">已答试卷</a>
                    </div>

                    <div class="stytem_select_right fr">
                        <div class="search_exam fl pr">
                            <input type="text" name="" id="chaxun" onblur="getData(1, 10)" value="" placeholder="试卷名称" />
                            <i class="icon  icon-search"></i>
                        </div>
                        <select class="select" style="margin-top: 0; margin-left: 15px;">
                            <option value="0" onchange="ChangePaperType(null)">全部</option>
                            <option value="1" onchange="ChangePaperType(1)">考试</option>
                            <option value="2" onchange="ChangePaperType(2)">测试</option>
                            <option value="3" onchange="ChangePaperType(3)">作业</option>
                            <option value="4" onchange="ChangePaperType(4)">问卷调查</option>
                        </select>
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
        <footer id="footer"></footer>
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
        $('#footer').load('../footer.html');

         GetSameLiveMenu(location.href, '<%=UserInfo.UniqueNo%>', '');
       
        getData(1, 10);
    })

    function ChangePaperType(type) {
        $("#sel_Type").attr("value", type);
        getData(1, 10);
    }

    var relvalueid = 1;
    function onquery(relvalue) {
        relvalueid = relvalue;
        $("#nohIDCard").val(relvalue);
        getData(1, 10);
    }
    function getData(startIndex, pageSize) {
        var Exam_PaperID = "";
        var hsubjectid = "";
        var hClassID = "";

        hClassID =  $("#hClassID").val() ;
        var noCreateUID = "";
        var CreateUID = "";
        if ($("#nohIDCard").val() == "1") {
            noCreateUID = $("#hIDCard").val();
        }
        else {
            CreateUID = $("#hIDCard").val();
        }

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
                "Type": TypeId,
                "Title": Title,
                "ClassID": hClassID,
                "noCreateUID": noCreateUID,
                "Book": hsubjectid,
                AnswerUser: CreateUID
            },
            success: function (json) {
                var str = $('#hSF').val();
                var myDate = new Date();
                var states = $("#HStatus").val();
                if (json.result.errNum.toString() == "0") {
                    var html = "";
                    $.each(json.result.retData.PagedData, function () {
                        if (Exam_PaperID.indexOf(this.ID) < 0) {
                            Exam_PaperID += this.ID + ",";

                            jsonsubjecket = json.result.retData.PagedData;
                            html += "<li class=\"clearfix\">"
                                        + "<div class=\"exam_img fl\">"
                                            + "<img src=\"../images/exam_img.png\" />"
                                        + "</div>"
                                        + "<div class=\"test_description exam_description fl\" style=\"width:200px\">";

                            if (relvalueid == 1 && ((Date.parse(this.WorkBeginTime) < Date.parse(myDate)) && (Date.parse(myDate) < Date.parse(this.WorkEndTime)))) {
                                if (this.typeid == 4) {
                                    html += "<h2 style=\"width:200px\"><a style=\"cursor:pointer;\" onclick='window.open(\"../ExamManage/QuestionnaireSurvey .aspx?id=" + this.ID + "\");'>" + this.Title + "(可答)</a></h2>";
                                }
                                html += "<h2 style=\"width:200px\"><a style=\"cursor:pointer;\" onclick=\"window.open('../ExamManage/onlineanswer.aspx?id=" + this.ID + "');\">" + this.epname + "(可答)</a></h2>";
                            }
                            else {
                                html += "<h2 style=\"width:200px\"><a  style=\"color:gray; cursor:pointer;\" onclick=\"return confirm('不再规定时间内，无法答题')\">" + this.epname + "(不可答)</a></h2>";
                            }

                            html += "<p style=\"width:400px\"><span class=\"test_easy\">" + this.Difficultyshow + "</span><span class=\"test_easy\">" + this.typeid + "</span>";
                            if (relvalueid != 1) {
                                if (this.typeid != 4) { html += "<span class=\"test_easy\">" + this.Statushow + "</span></p>"; }
                            }
                            html += "</div>"
                                        + "<div class=\"test_lists_right fr clearfix\" style=\"width:300px\">"
                                            + "<div class=\"public_name fl\">";

                            html += "创建人：" + this.TwoUserName;
                            createname = this.TwoUserName;

                            html += "</div>"
                            + "<div class=\"dates_a dates_b fr pr\" style=\"width:200px\">"
                                + "<div class=\"data\" style=\"width:200px\">"
                                    + "创建时间：" + this.CreateTime_Format
                                + "</div></div></div></li>";
                        }
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
                    //HoverPaper();
                    //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                }
                else {
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

    function AnsweredExam(idd, em) {
        window.open('/ExamManage/AnsweredExam.aspx?id=' + idd + '&name=' + em.id);
    }

</script>
