﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Status_ClassStu.aspx.cs" Inherits="SSSWeb.StatisticalAnalysis.GradeStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>班级人员</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />

    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <%--    <script src="/CourseManage/Term.js"></script>
    <script src="/CourseMenu.js"></script>--%>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td>${CreateName}</td>
            <td>${Name}</td>
            <td>${BatchUserName}</td>
            <%--<td>${GradeName}</td>--%>
            <td>${OrgName}</td>
            <td>${CalculatePercent(CoStatistics,1,1)}</td>
            <%--  <td>${CalculatePercent(CoStatistics,2,1)}</td>
            <td>${CalculatePercent(CoStatistics,2,2)}</td>--%>
            <td>${DateTimeConvert(LastStudyTime,"yyyy-MM-dd HH:mm:ss")}</td>
        </tr>
    </script>

</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo%>" />
    <%--<input type="hidden" id="HUserName" value="<%=UserInfo.Name %>" />--%>
    <input type="hidden" id="HPId" />
    <form id="form1" runat="server">
        <input id="option" type="hidden" value=">" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../AppManage/Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/coursesystem.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul id="Menu">
                        <li class="active"><a href="#">班级人员</a></li>
                        <li><a href="Status_ClassCourse.aspx">班级课程</a></li>
                        <li><a href="Status_ClassExam.aspx">题库管理</a></li>
                        <li><a href="Status_ClassExam.aspx">试卷管理</a></li>
                        <li><a href="Status_ClassExam.aspx">考试管理</a></li>
                        <li><a href="Status_ClassExam.aspx">考试分析</a></li>
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

                <div class="newcourse_select clearfix" id="CourseSel">
                    <div class="stytem_select_right fl" style="margin-left: 10px;">

                        <div class="search_exam fl pr">

                            <input type="text" name="" id="CourseName" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="getData(1,10)"></i>
                        </div>
                    </div>

                </div>
                <div class="wrap">
                    <div class="wrap">
                        <table id="Course">
                            <thead>
                                <tr>
                                    <th>学员姓名</th>
                                    <th class="pr checkall">课程名称</th>
                                    <th>讲师</th>
                                    <%--<th>年级</th>--%>
                                    <th>班级/部门</th>
                                    <th>学习完成情况</th>
                                    <%-- <th>作业完成情况</th>
                                    <th>作业批改情况</th>--%>
                                    <th>最后学习时间</th>
                                </tr>
                            </thead>
                            <tbody id="tb_Manage">
                            </tbody>
                        </table>
                    </div>
                </div>
                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                </div>
            </div>
        </div>
        <footer id="footer"></footer>
    </form>
</body>
<script type="text/javascript" src="../js/common.js"></script>
<script>
    var UrlDate = new GetUrlDate();

</script>
<script type="text/javascript">
    $(document).ready(function () {
         GetSameLiveMenu(location.href, '<%=UserInfo.UniqueNo%>', '');
       
        //SetPageButton('<%=UserInfo.UniqueNo%>')
        $('#footer').load('../footer.html');
        getData(1, 10);
        //GetMyStu();
    });
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
                        getData(1, 10);
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
                TeaNo: $("#HUserIdCard").val()
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

                    getData(1, 10);

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
    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        var StudyTerm = $("#StudyTerm").val();
        //if (Stu == "") {
        //    Stu == "0";
        //}
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            dataType: "json",
            data: {
                PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                Func: "GetMyLessonsDataPage",
                PageIndex: startIndex,
                pageSize: pageSize,
                ispage: true,
                Name: $("#CourseName").val(),
                //StuNo: Stu,
                //TeaID: UrlDate.TeaID,
                TeaID: $("#HUserIdCard").val(),
                IsPercent: 1,
                CourseID: $("#sel_AllCourse").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(".page").show();
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                    //ButtonList($("#HPId").val());
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_Manage").html(html);
                    $(".page").hide();
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function CalculatePercent(perinfo, len, Num) {
        var allwidth = 0;
        var oneArray = perinfo.split(',');
        for (var i = 0; i < oneArray.length; i++) {
            if (i == len) {
                var twoArray = oneArray[i].split('|');
                if (twoArray[2].toString() != "0") {
                    if (Num == 1) {
                        allwidth += Math.round((twoArray[3] / twoArray[2]) * (twoArray[1] / 100) * 10000) / 100.00;
                    }
                    else {
                        allwidth += Math.round((twoArray[4] / twoArray[2]) * (twoArray[1] / 100) * 10000) / 100.00;

                    }
                }
            }
        }
        return allwidth + "%";
    }
</script>
</html>
