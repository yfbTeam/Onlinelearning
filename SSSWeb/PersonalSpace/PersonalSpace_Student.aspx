<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonalSpace_Student.aspx.cs" Inherits="SSSWeb.PersonalSpace.PersonalSpace_Student" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>在线学习</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <!--证书-->
    <link rel="stylesheet" href="../css/certificate.css">
    <link rel="stylesheet" href="../css/certificateT.css">
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=4.0"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../js/jquery.jqprint.js"></script>
    <script src="../js/jquery-migrate-1.1.0.js"></script>
    <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>


    <script id="li_mylessons" type="text/x-jquery-tmpl">
        <li>
            <div class="allcourse_img">
                <img src="${ImageUrl}" alt="" onerror="javascript:this.src='../images/course_default.jpg'" />
            </div>
            <div class="couese_title">
                ${Name}
            </div>
            <p class="course_name">
                <span>${BatchUserName}</span>
                <a class="course_enroll" onclick="SinUp(${ID})" href="#">立即报名</a>
            </p>
        </li>
    </script>
    <script id="li_StudyLesson" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="before-line1 line"></div>
            <div class="before-line2 line"></div>
            <div class="before-line3 line"></div>
            <div class="after-line1 line"></div>
            <div class="after-line2 line"></div>
            <div class="after-line3 line"></div>
            <div class="mycourse_img fl" style="cursor: pointer;" onclick="javascript:window.location.href = '../OnlineLearning/StuLessonDetail.aspx?itemid=${ID}&flag=2';">
                <img src="${ImageUrl}" alt="" onerror="javascript:this.src='../images/course_default.jpg'" />
            </div>
            <div class="fl mycourse_mes">
                <h1 class="mycourse_name" style="cursor: pointer;" onclick="javascript:window.location.href = '../OnlineLearning/StuLessonDetail.aspx?itemid=${ID}&flag=2';">${Name}</h1>
                <h2 class="clearfix">
                    <div class="fl lecturer">
                        讲师：<span>${BatchUserName} </span>
                    </div>

                    <div class="fl class_venue">
                        上课场地：<span>${StudyPlace}</span>
                    </div>

                </h2>
                <div class="course_desc" style="line-height: 22px; max-height: 88px; display: -webkit-box; -webkit-line-clamp: 4; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${CourseIntro}</div>
                <div class="succ_detaillist">
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            选课人员
                        </div>
                        <div class="detaillist_desc">
                            <em class="icons">
                                <i class="icon icon_people"></i>
                            </em>
                            <span>${CourseSels}人</span>
                        </div>
                    </div>
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            新讨论
                        </div>
                        <div class="detaillist_desc" style="cursor: pointer;" onclick="javascript:window.location.href = '../OnlineLearning/StuLessonDetail.aspx?itemid=${ID}&flag=2&cab=2'">
                            <em class="icons">
                                <i class="icon icon_discuss"></i>
                                <b>${TopicCount}</b>
                            </em>
                            <span>讨论</span>
                        </div>
                    </div>

                </div>
            </div>
            <div class="process_outer">
                <%--<div class="process_innera" style="width: ${CalculatePercent(CoStatistics)};"></div>--%>
            </div>
        </li>
    </script>
    <script id="li_CurLesson" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="before-line1 line"></div>
            <div class="before-line2 line"></div>
            <div class="before-line3 line"></div>
            <div class="after-line1 line"></div>
            <div class="after-line2 line"></div>
            <div class="after-line3 line"></div>
            <div class="mycourse_img fl" style="cursor: pointer;" onclick="javascript:window.location.href = '../CourseManage/CourseDetail.aspx?itemid=${ID}&Type=2';">
                <img src="${ImageUrl}" alt="" onerror="javascript:this.src='../images/course_default.jpg'" />
            </div>
            <div class="fl mycourse_mes">
                <h1 class="mycourse_name" onclick="javascript:window.location.href = '../CourseManage/CourseDetail.aspx?itemid=${ID}&Type=2';" style="cursor: pointer;">${Name}</h1>
                <h2 class="clearfix">
                    <div class="fl lecturer">
                        讲师：<span>${BatchUserName} </span>
                    </div>

                    <div class="fl class_venue">
                        上课场地：<span>${StudyPlace}</span>
                    </div>

                </h2>
                <div class="course_desc" style="line-height: 22px; max-height: 88px; display: -webkit-box; -webkit-line-clamp: 4; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${CourseIntro}</div>
                <div class="succ_detaillist">
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            选课人员
                        </div>
                        <div class="detaillist_desc" title="人员调整" style="cursor: pointer;" onclick="AdjustSel(${ID},'${Name}')">
                            <em class="icons">
                                <i class="icon icon_people"></i>
                            </em>
                            <span>${CourseSels}人</span>
                        </div>
                    </div>
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            新讨论
                        </div>
                        <div class="detaillist_desc" title="加入讨论" style="cursor: pointer;" onclick="javascript:window.location.href = '../CourseManage/CourseDetail.aspx?itemid=${ID}&Type=2&cab=2'">
                            <em class="icons">
                                <i class="icon icon_discuss"></i>
                                <b>${TopicCount}</b>
                            </em>
                            <span>讨论</span>
                        </div>
                    </div>
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            证书申请
                        </div>
                        <div class="detaillist_desc" style="cursor: pointer;" onclick="CheckCertApply(${ID})" title="证书审核">
                            <em class="icons">
                                <i class="icon icon_discuss"></i>
                                <b>${ApplyCertNum}</b>
                            </em>
                            <span>申请人数</span>
                        </div>
                    </div>
                </div>
            </div>
            <%--<div class="process_outer">
                <div class="process_innera"></div>
            </div>--%>
        </li>
    </script>

</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo%>" />
    <input type="hidden" id="HClassID" value="<%=UserInfo.RegisterOrg %>" />
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/PersonalSpace/CourseManIndex.aspx">
                <img src="../images/logo.png" /></a>
            <div class="wenzi_tips fl">
                <img src="../images/zaixianxuexi.png" />
            </div>
            <nav class="navbar menu_mid fl" id="navlists">
                <ul id="Menu">
                    <li class="active" id="All"><a href="../PersonalSpace/CourseManIndex.aspx">课程首页</a></li>
                    <li id="Study"><a href="../PersonalSpace/PersonalSpace_Student.aspx#course-2" onclick="geCoursetData(1,10,'0')">在学课程</a></li>
                    <li id="My"><a href="../PersonalSpace/PersonalSpace_Student.aspx#course-3" onclick="geCoursetData(1,10,'2')">我负责的课程</a></li>
                    <li><a href="../PersonalSpace/ApplyCerty.aspx">证书申请</a></li>
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
    <div class="onlinetest_item width pt90">
        <div class="myexam bordshadrad">
            <div class="course_sort" id="course-1">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="#" class="on">课程首页</a>
                    </div>

                    <div class="stytem_select_right fr clearfix">
                        <div class="search_exam fl pr">
                            <div style="height: 4px; line-height: 30px;">
                                <select class="select" onchange="geCoursetData(1,10,'')" id="CourceType">
                                    <%-- <option value="">课程分类</option>
                                    <option value="1">入职培训</option>
                                    <option value="2">学习提升</option>
                                    <option value="3">专业技能</option>--%>
                                </select>
                            </div>

                            <input type="text" name="" id="CourseName_all" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="geCoursetData(1,10,'')"></i>
                        </div>
                    </div>

                </div>
                <!--面包屑-->
                <div class="crumbs">
                    <a href="../PersonalSpace/CourseManIndex.aspx" id="a_parentUrl">课程首页</a>
                    <span>></span>
                    <a href="#" id="a_lessonname">全部课程</a>
                </div>
                <ul class="allcourses clearfix" id="AllCourse">
                </ul>
            </div>
            <div class="course_sort none" id="course-2">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on">在学课程</a>
                        <a href="javascript:;" style="display: none;">学完课程</a>
                    </div>
                    <div class="stytem_select_right fr clearfix">
                        <div class="search_exam fl pr">
                            <input type="text" name="" id="CourseName_studying" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="geCoursetData(1,10,'0')"></i>
                        </div>
                    </div>
                </div>
                <ul class="mycourse_lists" style="min-height: 700px;" id="StuCourse">
                </ul>
            </div>
            <div class="course_sort none " id="course-3">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on">我负责的课程</a>
                        <%--<a href="../CourseManage/StuManage.aspx?Type=2&TeaID=<%=UserInfo.UniqueNo %>">学生数据</a>--%>
                    </div>
                    <div class="stytem_select_right fr clearfix">
                        <div class="search_exam fl pr">
                            <input type="text" name="" id="CourseName_my" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="geCoursetData(1,10,'2')"></i>
                        </div>
                    </div>
                </div>
                <ul class="mycourse_lists" style="min-height: 700px;" id="TeaCourse">
                </ul>
            </div>
        </div>
    </div>

    <footer id="footer">
        <div class="footer clearfix width">
            <div class="footer_right">
                <p>咨询电话: 010-83068508&nbsp;&nbsp;地址: 北京市丰台区南四环西路128号诺德中心3座7层 </p>
            </div>
        </div>
    </footer>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript">

        var UrlDate = new GetUrlDate();
        function AdjustSel(CourseID, CourceName) {
            OpenIFrameWindow('选课人员', '../CourseManage/SelectCourse.aspx?CourceID=' + CourseID + '&CourceName=' + encodeURI(CourceName), '700px', '540px');
        }
        function CheckCertApply(CourseID) {
            OpenIFrameWindow('证书申请', 'CheckCertApply.aspx?CourceID=' + CourseID, '700px', '500px');
        }
        function SinUp(ID) {
            var Stu = $("#HUserIdCard").val();
            $.ajax({
                type: "Post",
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                data: { "PageName": "CourseManage/CourceManage.ashx", Func: "SingUp", CourseID: ID, StuNo: Stu, ClssID: $("#HClassID").val() },
                dataType: "json",
                success: function (json) {
                    if (json.result.errNum == "0") {
                        layer.msg("报名成功");
                        geCoursetData(1, 10, "");
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
        $(function () {
            GetSameLiveMenu(location.href, '<%=UserInfo.UniqueNo%>', '');
           
            //SetPageButton('<%=UserInfo.UniqueNo%>')
            BindCourseCatagory();
            $('.stytem_select_left a').click(function () {
                $(this).addClass('on').siblings().removeClass('on');
                var n = $(this).index();
                if (n > 0) {
                    MyStudyCourses(1, 10, n);
                }
            })
            var CurUrl = window.location.href;
            if (CurUrl.indexOf("#course-1") > 0) {
                $("#course-1").removeClass("none").siblings().addClass("none");
                $("#All").addClass("active").siblings().removeClass("active");
                geCoursetData(1, 10, '');
            }
            if (CurUrl.indexOf("#course-2") > 0) {
                $("#course-2").removeClass("none").siblings().addClass("none");
                $("#Study").addClass("active").siblings().removeClass("active");
                geCoursetData(1, 10, '0');
            }
            if (CurUrl.indexOf("#course-3") > 0) {
                $("#course-3").removeClass("none").siblings().addClass("none");
                $("#My").addClass("active").siblings().removeClass("active");
                geCoursetData(1, 10, '2');
            }

            $('#navlists li').on('click', function () {
                $(this).addClass('active').siblings().removeClass('active');
                var n = $(this).index();
                if (n > 0) {
                    $('.myexam .course_sort').eq(n).show().siblings().hide();
                }
            })
            //geCoursetData(1, 10, '');
        })
        function BindCourseCatagory() {
            $("#CourceType").html("<option value=''>==课程分类==</option>");
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: { PageName: "/CourseManage/Course_Catagory.ashx", Func: "GetData", },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var option = "<option value='" + this.ID + "'>" + this.Name + "</option>";
                            $("#CourceType").append(option);
                        });
                    }
                    else {
                        //$("#Catagory").html("暂无证书模板！");
                    }
                },
                error: function (errMsg) {
                    // $("#Certificate").html(errMsg);
                }
            });
            $("#CourceType").val(UrlDate.Type);
        }
        //获取课程数据
        function geCoursetData(startIndex, pageSize, Type) {
            var name = "";
            var TeaID = "";
            var StuID = "";
            if (Type == "") {
                TeaID = ""; StuID = "";
                name = $("#CourseName_all").val();
            }
            else if (Type == "0") {
                StuID = $("#HUserIdCard").val();
                TeaID = "";
                var isfinish = $('#course-2 .stytem_select_left').find("a.on").index();
                MyStudyCourses(1, 10, isfinish);
                return;
            }
            else if (Type == "2") {
                StuID = "";
                TeaID = $("#HUserIdCard").val();
                name = $("#CourseName_my").val();
            }
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/CourseManage/CourceManage.ashx",
                    Func: "GetPageList",
                    IsPage: "false",
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    IdCard: TeaID,
                    StuID: StuID,
                    StuNo: $("#HUserIdCard").val(),
                    Name: $("#CourseName").val(),
                    CourseType: $("#CourceType").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (Type == "") {
                            $("#AllCourse").html('');
                            if (json.result.retData != null && json.result.retData.length > 0) {
                                $(json.result.retData).each(function () {
                                    var DefaultImage = "../images/course_default.jpg";
                                    var a = "<a class=\"course_enroll\" href='#' onclick='SinUp(" + this.ID + ")'>立即报名</a>"
                                    if (this.stuNo.toString().length > 0) {
                                        a = "<a class=\"course_enroll\" href='#'>已报名</a>";
                                    }
                                    var li = "<li><div class=\"allcourse_img\" onclick=\"javascript:window.location.href = '../OnlineLearning/StuLessonDetail.aspx?itemid=" + this.ID + "&flag=1';\"><img src=\"" + this.ImageUrl + "\" alt=\"\" onerror=\"javascript:this.src='" + DefaultImage + "'\"></div><div class=\"couese_title\">" + this.Name
                                        + "</div><p class=\"course_name\"><span>" + this.BatchUserName + "</span>" + a + "</p></li>";
                                    $("#AllCourse").append(li);
                                })
                            }
                            else {
                                $('#AllCourse').append('<div style="width:100%;height:758px;background:url(/images/nomessage.png) no-repeat center 35%"><p style="line-height:30px;text-align:center;padding-top:480px;font-size:18px;color:#989898;"> 您还没有选择课程呢，点击   <a href="" style="font-size:18px;color:#1783c4;">去选课</a>   按钮吧～</p></div>');
                            }
                        }
                        else {
                            $("#TeaCourse").html("");
                            if (json.result.retData != null && json.result.retData.length > 0) {
                                $("#li_CurLesson").tmpl(json.result.retData).appendTo("#TeaCourse");
                            }
                            else {
                                $('#TeaCourse').append('<div style="width:100%;height:800px;background:url(/images/nomessage.png) no-repeat center"><p style="line-height:30px;font-size:18px;color:#989898;">您还没有课程呢，静静等待管理员分配吧</p></div>');
                            }

                        }
                    }
                    else {
                        if (Type == "") {
                            $(".allcourses").html('');
                        }
                        else {
                            $(".mycourse_lists").html("");
                        }
                        // $(".allcourses").html("暂无课程！");
                    }
                    hoverEnlarge($('.allcourses .allcourse_img img'));
                    hoverEnlarge($('.mycourse_lists .mycourse_img img'));
                },
                error: function () {
                    if (Type == "") {
                        $(".allcourses").html('');
                    }
                    else {
                        $(".mycourse_lists").html("");
                    }
                    //$(".allcourses").html(errMsg);
                }
            });
        }
        function MyStudyCourses(startIndex, pageSize, isfinish) {
            isfinish = arguments[2] || 0;
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                    Func: "GetMyLessonsDataPage",
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    ispage: false,
                    Name: $("#CourseName_studying").val(),
                    StuNo: $("#HUserIdCard").val(),
                    IsPercent: 1,
                    ClassNo: $("#HClassID").val(),
                    CheckUser: "1"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#StuCourse").html("");
                        $("#li_StudyLesson").tmpl(json.result.retData).appendTo("#StuCourse");
                    }
                    else {
                        $("#StuCourse").html("");
                    }
                    hoverEnlarge($('.mycourse_lists .mycourse_img img'));

                },
                error: function (errMsg) {
                    $("#StuCourse").html("");
                }
            });
        }
        function GetMessge(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;

            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/PortalManage/MessageHandler.ashx",
                    Func: "GetPageList",
                    Ispage: true,
                    Receiver: $("#HUserIdCard").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize,
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#NewMessage").html('');
                        $.each(json.result.retData.PagedData, function () {
                            var Content = this.Contents.toString().replace(/<[^>]+>/g, "");//RegExp.Replace(this.Contents, "<[^>]*>", "");
                            $("#NewMessage").append("<li><a href=\"javascript:;\" title=\"" + Content + "\">" + cutstr(Content, 20) + "</a></li>");
                        })


                        //$("#li_Message").tmpl(json.result.retData.PagedData).appendTo("#NewMessage");
                    }
                    else {
                        $("#NewMessage").html("");
                    }
                },
                error: function () {
                    $("#NewMessage").html();
                }
            });
        }

        function CalculatePercent(perinfo) {
            var allwidth = 0;
            var oneArray = perinfo.split(',');
            for (var i = 0; i < oneArray.length; i++) {
                var twoArray = oneArray[i].split('|');
                if (twoArray[2].toString() != "0") {
                    allwidth += Math.round((twoArray[3] / twoArray[2]) * (twoArray[1] / 100) * 10000) / 100.00;
                }
            }
            return allwidth + "%";
        }
    </script>
</body>
</html>
