<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Status_ClassCourse.aspx.cs" Inherits="SSSWeb.StatisticalAnalysis.Status_ClassCourse" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>班级课程</title>
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
                            班级作业
                        </div>
                        <div class="detaillist_desc" title="班级作业" style="cursor: pointer;" onclick="javascript:window.location.href = 'Status_ClassCourse_TaskList.aspx?itemid=${ID}'">
                            <em class="icons">
                                <i class="icon icon_discuss"></i>
                                <%--<b>${TopicCount}</b>--%>
                            </em>
                            <span>作业</span>
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
<%--    <input type="hidden" id="PhotoName" value="<%=UserInfo.AbsHeadPic%>" />
    <input type="hidden" id="LoginName" value="<%=UserInfo.LoginName %>" />
    <input type="hidden" id="HUserName" value="<%=UserInfo.Name %>" />
    <input type="hidden" id="IsFirstLogin" value="<%=UserInfo.IsFirstLogin%>" />--%>

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
                    <ul id="Menu">
                        <li><a href="Status_ClassStu.aspx">班级人员</a></li>
                        <li class="active"><a href="#">班级课程</a></li>
                        <li><a href="../ExamManage/ExamQManager.aspx">题库管理</a></li>
                        <li><a href="Status_ClassExam.aspx">试卷管理</a></li>
                        <li><a href="Status_ClassExam.aspx">考试管理</a></li>
                        <li><a href="Status_ClassExam.aspx">考试分析</a></li>
                    </ul>
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

            <div class="course_sort">
                <%--<div class="stytem_select clearfix">
                   
                    <!--面包屑-->
                    <div class="crumbs fl">
                        <a id="Mycource" style="cursor: pointer;" onclick="javascript:window.history.go(-1)">班级课程</a>
                      
                    </div>
                    <div class="stytem_select_right fr clearfix">
                        <div class="search_exam fl pr">
                            <input type="text" name="" id="CourseName_my" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="geCoursetData(1,10)"></i>
                        </div>
                    </div>
                </div>--%>
                <div class="newcourse_select clearfix" id="CourseSel">

                    <div class="stytem_select_right fl" style="margin-left: 10px;">

                        <div class="search_exam fl pr">
                            <%--<select name="" class="select" id="CourseType" onchange="getData(1, 10)" style="height: 30px; margin: 0px 5px">
                            </select>--%>
                            <input type="text" name="" id="CourseName_my" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="geCoursetData(1,10)"></i>
                        </div>
                    </div>
                    <div class="stytem_select_right fr">

                        <a href="javascript:;" class="newcourse none" btncls="icon-plus" onclick="javascript:OpenIFrameWindow('新建课程', '../CourseManage/CourceAdd_NJ.aspx', '700px', '600px');">新建课程
                        </a>

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
        //function CheckCertApply(CourseID) {
        //    OpenIFrameWindow('证书申请', '../PersonalSpace/CheckCertApply.aspx?CourceID=' + CourseID, '700px', '500px');
        //}

        $(function () {
            GetSameLiveMenu(location.href, '<%=UserInfo.UniqueNo%>', '');
           
            geCoursetData(1, 10);
            //GetMyStu();
        })
        var Stu = "";
        function GetMyStu() {
            $.ajax({
                url: "../SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    Func: "GetUserInfoData",
                    Ispage: "false",
                    IsStu: "true",
                    TeaNo: "<%=UserInfo.UniqueNo%>"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var i = 0;
                        $(json.result.retData).each(function () {
                            if (i == 0) {
                                Stu += "'" + this.UniqueNo + "'";
                            }
                            else {
                                Stu += ",'" + this.UniqueNo + "'";
                            }
                        })
                        if (Stu == "") {
                            GetMyUser();
                        }
                        else {
                            geCoursetData(1, 10);
                        }

                    }
                    else {
                        GetMyUser();
                        //var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        //$("#tb_Manage").html(html);
                        //layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function GetMyUser() {
            $.ajax({
                url: "../SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    Func: "GetUserInfoData",
                    Ispage: "false",
                    IsStu: "false",
                    TeaNo: "<%=UserInfo.UniqueNo%>"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var i = 0;
                        $(json.result.retData).each(function () {
                            if (i == 0) {
                                Stu += "'" + this.UniqueNo + "'";
                            }
                            else {
                                Stu += ",'" + this.UniqueNo + "'";
                            }
                            i++;
                        })

                        geCoursetData(1, 10);

                    }
                    else {
                        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        $("#tb_Manage").html(html);
                        //layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //获取课程数据
        function geCoursetData(startIndex, pageSize) {

            var TeaID = $("#HUserIdCard").val();
            var name = $("#CourseName_my").val();
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
                    //StuID: Stu,
                    Name: $("#CourseName").val(),
                    CourseType: $("#CourceType").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#TeaCourse").html("");
                        if (json.result.retData != null && json.result.retData.length > 0) {
                            $("#li_CurLesson").tmpl(json.result.retData).appendTo("#TeaCourse");
                        }
                        else {
                            $('#TeaCourse').append('<div style="width:100%;height:800px;background:url(/images/nomessage.png) no-repeat center"><p style="line-height:30px;font-size:18px;color:#989898;">所负责班级学生无人选课</p></div>');
                        }

                    }

                    else {
                        $('#TeaCourse').append('<div style="width:100%;height:800px;background:url(/images/nomessage.png) no-repeat center"><p style="line-height:30px;font-size:18px;color:#989898;">所负责班级学生无人选课</p></div>');
                    }
                    hoverEnlarge($('.mycourse_lists .mycourse_img img'));
                },
                error: function () {
                    $('#TeaCourse').append('<div style="width:100%;height:800px;background:url(/images/nomessage.png) no-repeat center"><p style="line-height:30px;font-size:18px;color:#989898;">所负责班级学生无人选课</p></div>');
                }
            });
        }

    </script>
</body>
</html>
