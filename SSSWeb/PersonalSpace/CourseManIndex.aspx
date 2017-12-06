<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseManIndex.aspx.cs" Inherits="SSSWeb.PersonalSpace.CourseManIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>课程首页</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
	<![endif]-->
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=4.0"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <style>
        .sort_left {
            margin-right: 240px;
        }
    </style>
</head>
<body>
    <input type="hidden" id="HClassID" value="<%=UserInfo.RegisterOrg %>" />

    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="CourseManIndex.aspx">
                <img src="../images/logo.png" /></a>
            <div class="wenzi_tips fl">
                <img src="../images/zaixianxuexi.png" />
            </div>
            <nav class="navbar menu_mid fl" id="navlists">
                <ul id="Menu">
                    <li class="active"><a href="CourseManIndex.aspx">课程首页</a></li>
                    <li id="Study"><a href="PersonalSpace_Student.aspx#course-2">在学课程</a></li>
                    <li id="My"><a href="PersonalSpace_Student.aspx#course-3">我负责的课程</a></li>
                    <li><a href="ApplyCerty.aspx">证书申请</a></li>
                    <li><a href="../ExamManage/Exam_Stu.aspx">在线考试</a></li>
                </ul>
            </nav>
            <div class="search_account fr clearfix">
                <ul class="account_area fl">
                    <li>
                        <a class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=UserInfo.AbsHeadPic%>" />
                            </div>
                            <h2><%=UserInfo.Name%></h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr">
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
    <div id="courseManindex">
        <div class="pt90 width clearfix">
            <div class="recom_course fl">
                <i>
                    <img src="../images/tuijian.png" /></i>
                <h2>推荐课程</h2>
                <a href="../PersonalSpace/PersonalSpace_Student.aspx#course-1">查看更多</a>
            </div>
            <ul class="course_lists fl" id="RecCource">

                <%-- <li>
                    <div class="img">
                        <img src="../images/1.png" alt="Alternate Text" />
                    </div>
                    <div class="clearfix">
                        <div class="fl zi">
                            <h2 class="course_name">英语发音词汇班</h2>
                            <p class="course_author">作者作</p>
                        </div>
                        <a href="javascript:;">立即报名</a>
                    </div>
                </li>
                --%>
            </ul>
        </div>
        <div style="background: #fff">
            <div class="width clearfix pr">
                <div class="sort_left">
                    <%--<div>
                        <h1 class="sort_title">入职培训 <a href="../PersonalSpace/PersonalSpace_Student.aspx#course-1?Type=1">更多<i>></i></a></h1>
                        <ul class="course_lists  clearfix" id="Catogary1">
                        </ul>
                    </div>
                    <div style="background: #f8f8f8;">
                        <h1 class="sort_title">学习提升 <a href="../PersonalSpace/PersonalSpace_Student.aspx#course-1?Type=2">更多<i>></i></a></h1>
                        <ul class="course_lists clearfix" id="Catogary2">
                        </ul>
                    </div>
                    <div>
                        <h1 class="sort_title">专业技能 <a href="../PersonalSpace/PersonalSpace_Student.aspx#course-1?Type=3">更多<i>></i></a></h1>
                        <ul class="course_lists  clearfix" id="Catogary3">
                        </ul>
                    </div>--%>
                </div>
                <div class="courseindex_right bordshadrad" style="height: auto;">
                    <p class="learned_title">热门课程排行榜</p>
                    <ul class="topcourse_list topcourse_lista">
                        <%--<li>
                            <a href="">
                                <p class="topcourse_list_name"><span>1</span>语言是一门艺术</p>
                                <div class="sort_detail clearfix">
                                    <div class="sort_detail_img fl">
                                        <img src="" alt="Alternate Text" />
                                    </div>
                                    <div class="ml10 detailks fl">
                                        <h2>201人</h2>
                                        <p>作者</p>
                                    </div>

                                </div>
                            </a>
                        </li>--%>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <footer id="footer"></footer>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.SuperSlide.2.1.1.js"></script>

    <script>

        function GetData() {
            $(".sort_left").html("");
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "/CourseManage/CourceManage.ashx", Func: "GetPageList", IsPage: "false", StuNo: '<%=UserInfo.UniqueNo%>', "Status": "1" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (json.result.retData != null && json.result.retData.length > 0) {
                            $(json.result.retData).each(function () {

                                var DefaultImage = "../images/course_default.jpg";
                                var a = "<a class=\"course_enroll\" href='#' onclick='SinUp(" + this.ID + ")'>立即报名</a>"
                                if (this.stuNo.toString().length > 0) {
                                    a = "<a class=\"course_enroll\" href='#'>已报名</a>";
                                }
                                var li = "<li><div style='cursor:pointer;' class=\"img\" onclick=\"javascript:window.location.href = '../OnlineLearning/StuLessonDetail.aspx?itemid=" +
                                    this.ID + "&flag=1';\"><img src=\"" + this.ImageUrl + "\" alt=\"\" onerror=\"javascript:this.src='" + DefaultImage +
                                    "'\"></div> <div class=\"clearfix\"><div class=\"fl zi\"><h2 class=\"course_name\">" + this.Name
                                    + "</h2><p class=\"course_author\">" + this.BatchUserName + "</p></div>" + a + "</div></li>";
                                var TypeID = "Catogary" + this.CourceType;

                                if ($("#" + TypeID).html() != undefined) {
                                    if ($("#" + TypeID).children().length < 4) {
                                        $("#" + TypeID).append(li);
                                    }
                                }
                                else {
                                    $(".sort_left").append('<div><h1 class="sort_title">' + this.CatogaryName + ' <a href="../PersonalSpace/PersonalSpace_Student.aspx#course-1?Type=' + this.CourceType
                                        + '">更多<i>></i></a></h1><ul class="course_lists  clearfix" id="' + TypeID + '"></ul></div>');
                                    $("#" + TypeID).append(li);
                                }

                            })
                        }
                        else {
                        }

                    }
                    else {

                    }
                },
                error: function () {

                }
            });
        }
        function SinUp(ID) {
            $.ajax({
                type: "Post",
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                data: { "PageName": "CourseManage/CourceManage.ashx", Func: "SingUp", CourseID: ID, StuNo: '<%=UserInfo.UniqueNo%>', ClssID: $("#HClassID").val() },
                dataType: "json",
                success: function (json) {
                    if (json.result.errNum == "0") {
                        layer.msg("报名成功");
                        HotCourse();
                        GetData();
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
        function HotCourse() {
            $(".topcourse_list").html("");
            $("#RecCource").html("");

            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/CourseManage/CourceManage.ashx",
                    Func: "HotCourse", "StuNo": '<%=UserInfo.UniqueNo %>'
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (json.result.retData != null && json.result.retData.length > 0) {
                            var i = 1;
                            var j = 0;
                            $(json.result.retData).each(function () {
                                var DefaultImage = "../images/course_default.jpg";
                                var a = "<a  href='#' onclick='SinUp(" + this.ID + ")'>立即报名</a>"

                                var li = '<li><a style="cursor:pointer;" href="/OnlineLearning/StuLessonDetail.aspx?itemid=' + this.ID + '&flag=1"><p class=\"topcourse_list_name\"><span>' +
                                    i + '.</span>' +
                                    this.Name + '(' + this.CourseSels + ')</p><div class="sort_detail"></div></a></li>';
                                $(".topcourse_list").append(li);

                                if (j < 4 && this.StuNo == '') {
                                    var recLi = '<li><div class="img" style="cursor:pointer;" onclick="Detail(' + this.ID +
                                        ')"><img src="' + this.ImageUrl + '" alt="" onerror="javascript:this.src=\'' + DefaultImage +
                              '\'"></div><div class="clearfix"><div class="fl zi"><h2 class="course_name">' + this.Name
                                  + '</h2><p class="course_author">' + this.CreateName + '</p> </div>' + a + '</div></li>'
                                    $("#RecCource").append(recLi);
                                    j++;
                                    $('.topcourse_list li').hover(function () {
                                        $('.topcourse_list li').find('div').hide();
                                        $(this).find('div').show();
                                    })
                                }
                                i++;
                            })
                        }
                    }
                },
                error: function () {

                }
            });
        }
        function Detail(ID) {
            window.location = "../OnlineLearning/StuLessonDetail.aspx?itemid=" + ID + "&flag=1";
        }

        $(function () {
            GetSameLiveMenu(location.href, '<%=UserInfo.UniqueNo%>', '');

            if ('<%=UserInfo.IsFirstLogin %>' == '0') {
                OpenIFrameWindow('修改密码', '../AppManage/EditPwd.aspx', '500px', '330px');
                $(".layui-layer-shade").css("opacity", 0.8);
                $(".layui-layer-setwin").hide();
            }

            $('#footer').load('../footer.html');

            GetData();
            HotCourse();
            onscroll($('.courseindex_right'))
        })
    </script>
</body>
</html>
