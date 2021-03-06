﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cource_OnlineChose.aspx.cs" Inherits="SSSWeb.CourseManage.Cource_OnlineChose" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>在线选课</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/Common.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <style type="text/css">
        .team_more a {
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        function CourceMore() {
            window.location.href = "Cource_More_Student.aspx";
        }
        $(function () {
            BindData();
        })

        function BindData() {
            $("#Edu").html("<div class=\"educate_team fl educate_teambg\">\<h1>教育学部</h1>\<div class=\"team_more\">\<a  href=\"javascript:;\"  onclick=\"CourceMore\">学前教育</a>\<a href=\"courseindex_more.html\">综合高中</a>\<a href=\"courseindex_more.html\">高考升学</a><a href=\"courseindex_more.html\">国际高中</a></div></div>");
            $("#Art").html("<div class=\"educate_team fl art_teambg\">\<h1>艺术学部</h1>\<div class=\"team_more\">\<a href=\"courseindex_more.html\">影视影像</a>\<a href=\"courseindex_more.html\">酒店餐饮</a>\<a href=\"courseindex_more.html\">动漫游戏</a><a href=\"courseindex_more.html\">时装设计</a></div></div>");
            $("#server").html("<div class=\"educate_team fl server_teambg\">\<h1>服务学部</h1>\<div class=\"team_more\">\<a href=\"courseindex_more.html\">金融财会</a>\<a href=\"courseindex_more.html\">综合高中</a>\<a href=\"courseindex_more.html\">旅游体验</a><a href=\"courseindex_more.html\">园林园艺</a></div></div>");
            $("#skill").html("<div class=\"educate_team fl skill_teambg\">\<h1>技术学部</h1>\<div class=\"team_more\">\<a href=\"courseindex_more.html\">网络物联</a>\<a href=\"courseindex_more.html\">口腔修复</a>\<a href=\"courseindex_more.html\">钟表维修</a><a href=\"courseindex_more.html\">电子商务</a></div></div>");


            var Stu = $("#HUserIdCard").val();
            var ClassID = $("#HClassID").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetCourseByType", Stu: Stu, CourceType: 2, ClassID: ClassID, "Num": 3 },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var TypeName = "选修课";
                            if (this.CourceType == "1") {
                                TypeName = "必修课";
                            }
                            var a = "<a class=\"course_enroll\" href='#' onclick='SinUp(" + this.ID + "," + this.RigistType + ")'>立即报名</a>"
                            if (this.stuNo.toString().length > 0) {
                                a = "<a class=\"course_enroll\" href='#'>已报名</a>";
                            }
                            var div = "<div class=\"team_list fl\"><div class=\"allcourse_img\" style=\"cursor:pointer;\"  onclick=\"CourseDetail(" + this.ID + ",'" + this.EndTime + "')\"><img src='" + this.ImageUrl
                                + "' alt='' /></div><div class=\"course_type course_bixiu\">" + TypeName + "</div><div class=\"couese_title\">" + this.Name +
                            "</div><p class=\"course_name\"><span>" + this.LecturerName + "</span>" + a + "</p></div>";
                            if (this.CourseType == "教育学部") {
                                $("#Edu").append(div);
                            }
                            if (this.CourseType == "艺术学部") {
                                $("#Art").append(div);
                            }
                            if (this.CourseType == "服务学部") {
                                $("#server").append(div);
                            }
                            if (this.CourseType == "技术学部") {
                                $("#skill").append(div);
                            }
                        });
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                    hoverEnlarge($('.team_list .allcourse_img img'));
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function CourseDetail(ID, EndTime) {
            var now = new Date();

            var date1 = new Date(now);
            var date2 = new Date(EndTime);
            if (date2 > date1) {
                window.location.href = "/OnlineLearning/StuLessonDetail.aspx?itemid=" + ID + "&flag=2";
            }
            else {
                layer.msg("该课程已经结束");
            }
        }
        //学生报名
        function SinUp(ID, RigistType) {
            if (RigistType == 0) {
                registSing(ID, '');
            }
            else {
                OpenIFrameWindow('课程注册', '/CourseManage/CourseCommand.aspx?ID=' + ID, '300px', '180px');
            }
        }
        function registSing(ID, Command) {
            var Stu = $("#HUserIdCard").val();
            $.ajax({
                type: "Post",
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                data: { "PageName": "CourseManage/CourceManage.ashx", Func: "SingUp", CourseID: ID, StuNo: Stu, Command: Command },
                dataType: "json",
                success: function (json) {
                    if (json.result.errNum == "0") {
                        layer.msg("报名成功");
                        sendMsg(ID);
                        BindData();
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

        function sendMsg(courseId) {
            if ($.cookie('LoginCookie_Cube') == null || $.cookie('LoginCookie_Cube') == "null" || $.cookie('LoginCookie_Cube') == "") { return; }
            var info = $.parseJSON($.cookie('LoginCookie_Cube'));
            $.ajax({
                type: "Post",
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/MessageHandler.ashx",
                    "Func": "SendMessageForCourse",
                    "courseID": courseId,
                    "Type": 8,
                    "Receiver": info.IDCard,
                    "ReceiverName": info.Name,
                    "Timing": 0
                },
                dataType: "json",
                success: function (json) {

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HClassID" runat="server" />
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/PersonalSpace/Learning_center_portal.aspx">
                    <img src="/images/logo.png" /></a>
                <%--<div class="wenzi_tips fl">
                    <img src="/images/coursesystem.png" /></div>--%>
                <nav class="navbar menu_mid fl">
                    <ul>
                        <%--<li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>--%>
                        <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                        <li currentclass="active"><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                        <%--<li currentclass="active"><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
                        <li currentclass="active"><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                        <li  currentclass="active"><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                        <li currentclass="active"><a href="/analysisa/student_studyprocess(4).aspx">个人学习进度</a></li>--%>
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
        <div class="onlinetest_item width pt90 clearfix pb20">
            <div class="team_wrap educate_bg fl clearfix" id="Edu">
                <div class="educate_team fl educate_teambg">
                    <h1>教育学部</h1>
                    <div class="team_more">
                        <a onclick="CourceMore()">学前教育</a>
                        <a onclick="CourceMore()">综合高中</a>
                        <a onclick="CourceMore()">高考升学</a>
                        <a onclick="CourceMore()">国际高中</a>
                    </div>
                </div>
            </div>
            <div class="team_wrap fl" id="Art">
                <div class="educate_team fl art_teambg">
                    <h1>艺术学部</h1>
                    <div class="team_more">
                        <a onclick="CourceMore()">影视影像</a>
                        <a onclick="CourceMore()">美容美发</a>
                        <a onclick="CourceMore()">动漫游戏</a>
                        <a onclick="CourceMore()">时装设计</a>
                    </div>
                </div>
            </div>
            <div class="team_wrap fl" id="server">
                <div class="educate_team fl server_teambg">
                    <h1>服务学部</h1>
                    <div class="team_more">
                        <a onclick="CourceMore()">金融财会</a>
                        <a onclick="CourceMore()">酒店餐饮</a>
                        <a onclick="CourceMore()">旅游体验</a>
                        <a onclick="CourceMore()">园林园艺</a>
                    </div>
                </div>
            </div>
            <div class="team_wrap skill_bg fl" id="skill">
                <div class="educate_team fl skill_teambg">
                    <h1>技术学部</h1>
                    <div class="team_more">
                        <a onclick="CourceMore()">网络物联</a>
                        <a onclick="CourceMore()">口腔修复</a>
                        <a onclick="CourceMore()">钟表维修</a>
                        <a onclick="CourceMore()">电子商务</a>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <div class="footer width clearfix">
                <div class="logo fl">
                    <img src="/PortalImages/logoBefore.png" alt="" style="margin-top: 10px;" />
                </div>
                <div class="footer_right fr">
                    <p>成长热线：400-661-6666 </p>
                    <p>Copyright © 2016 北京四中网校 京公网备案110102001311-1 </p>
                </div>
            </div>
        </footer>
        <script src="/js/common.js"></script>
    </form>
</body>
</html>
