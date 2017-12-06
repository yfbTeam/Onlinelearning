<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyCourse.aspx.cs" Inherits="SSSWeb.PersonalSpace.MyCourse" %>

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
                <div class="process_innera" style="width: ${CalculatePercent(CoStatistics)};"></div>
            </div>
        </li>
    </script>
    

</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo%>" />

    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/PersonalSpace/CourseManIndex.aspx">
                <img src="../images/logo.png" /></a>
            <div class="wenzi_tips fl">
                <img src="../images/zaixianxuexi.png" />
            </div>
            <nav class="navbar menu_mid fl" id="navlists">
                <ul>
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

            <div class="course_sort" id="course-2">
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

        $(function () {
            //SetPageButton('<%=UserInfo.UniqueNo%>')

            MyStudyCourses(1, 10);
        })
      
        function MyStudyCourses(startIndex, pageSize) {
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
