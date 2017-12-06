<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskDetail.aspx.cs" Inherits="SSSWeb.StatisticalAnalysis.TaskDetail" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>我的班级</title>
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
    <script src="/CourseManage/Term.js"></script>
    <script src="/CourseMenu.js"></script>
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
            <td>${Name}</td>
            <td>${CreateName}</td>
            <td>{{if CreateTime==""}}未答题{{else}}${CreateTime}{{/if}}</td>
            <td>{{if CorrectTime==""}}未批改{{else}}${CorrectTime}{{/if}}</td>
            <td>${TwoUserName}</td>
            <td>${Score}</td>
            <td>${StoreLevel}</td>
            <td>${CorrectContent}</td>
            <td>{{if CreateTime==""}}{{else}}<a href="${Attachment}">查看答案</a>{{/if}}</td>
        </tr>
    </script>

</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo%>" />
    <input type="hidden" id="HUserName" value="<%=UserInfo.Name %>" />
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
                    <ul>
                        <li><a href="#">班级人员</a></li>
                        <li class="active"><a href="../StatisticalAnalysis/Status_ClassCourse.aspx">班级课程</a></li>
                        <li><a href="../StatisticalAnalysis/Status_ClassExam.aspx">班级考试</a></li>
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
                    <div class="crumbs fl">
                        <a id="Mycource" style="cursor: pointer;">班级课程</a>
                        <span>></span>
                        <a  id="CourseClass">作业统计</a>
                        <span>></span>
                        <a href="#">作业详情</a>
                    </div>
                    <%--<div class="stytem_select_right fr clearfix" style="margin-right: 10px;">

                        <div class="search_exam fl pr">

                            <input type="text" name="" id="CourseName" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="getData(1,10)"></i>
                        </div>
                    </div>--%>
                </div>
                <div class="wrap">
                    <div class="wrap">
                        <table id="Course">
                            <thead>
                                <tr>
                                    <th>作业标题</th>
                                    <th>学生姓名</th>
                                    <th>答题时间</th>
                                    <th>批改时间</th>
                                    <th>批改老师</th>
                                    <th>分数</th>
                                    <th>成绩等级</th>
                                    <th>评语</th>
                                    <th>答案附件</th>
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

<script type="text/javascript">
    var UrlDate = GetUrlDate();
    $(function () {
        $("#CourseClass").attr("href", "/StatisticalAnalysis/Status_ClassCourse_TaskList.aspx?itemid=" + UrlDate.itemid)
        //SetPageButton('<%=UserInfo.UniqueNo%>')
        $('#footer').load('../footer.html');
        getData();
    });
    var UrlDate = new GetUrlDate();
    function getData() {
        if (UrlDate.itemid.toString().length > 0) {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func: "GetStuSubWorkDetail",
                    StuNo: UrlDate.StuNo,
                    CourseID: UrlDate.itemid
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(".page").show();
                        $("#tb_Manage").html('');
                        $("#tr_User").tmpl(json.result.retData).appendTo("#tb_Manage");
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
    }

</script>
</html>
