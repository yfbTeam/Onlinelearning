<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserSkinAnalys.aspx.cs" Inherits="SSSWeb.StatisticalAnalysis.UserSkinAnalys" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>页面访问统计</title>
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
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
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
            <td>${UserName}</td>
            <td>${ToUrl}</td>
            <td>${SkinLong}秒</td>
            <td>${CreateTime}</td>
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
                    <%--<img src="/images/coursesystem.png" />--%>
                </div>
                <nav class="navbar menu_mid fl">
                    <ul>
                        <li class="active"><a href="#">页面访问统计</a></li>
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
                            <span style="float: left; line-height: 26px;">访问时间：</span>

                            <input type="text" name="" id="Time1" value="" placeholder="访问时间" style="width: 90px" onclick="WdatePicker()"><span style="float: left; line-height: 26px;">-</span>
                            <input type="text" name="" id="Time2" value="" placeholder="访问时间" style="width: 90px; margin-right: 20px;" onclick="WdatePicker()">&nbsp;&nbsp;
                            <span style="float: left; line-height: 26px;">停留时长：</span><input type="text" name="" id="SkinLong1" value="" placeholder="停留时长" style="width: 80px" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')">
                            <span style="float: left; line-height: 26px;">-</span>
                            <input type="text" name="" id="SkinLong2" value="" placeholder="停留时长" style="width: 80px; margin-right: 20px;" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')">
                            <span style="float: left; line-height: 26px;">页面路径：</span><input type="text" name="" id="ToUrl" value="" placeholder="页面路径">
                            <i class="icon  icon-search" onclick="getData(1,10)"></i>
                        </div>
                    </div>
                    <%--<div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" onclick="AddCource()" id="icon-plus">
                            <i class="icon icon-plus"></i>新建课程
                        </a>
                    </div>--%>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th class="pr checkall">用户账号</th>
                            <th>访问地址</th>
                            <th>停留时间</th>
                            <th>访问时间</th>
                        </thead>
                        <tbody id="tb_Manage">
                        </tbody>
                    </table>

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
        SetPageButton('<%=UserInfo.UniqueNo%>')

        $('#footer').load('../footer.html');
        var myDate = new Date();
        var CurrTime = myDate.getFullYear() + '-' + parseInt(myDate.getMonth()+ 1)  + '-' + myDate.getDate()
        $("#Time1").val(CurrTime);
        getData(1, 10);
    });
    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        var StudyTerm = $("#StudyTerm").val();

        $.ajax({
            url: "../SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageIndex: startIndex, pageSize: pageSize, Func: "GetUserSkim", "MinLong": $("#SkinLong1").val(), "MaxLong": $("#SkinLong2").val()
                , "MinTime": $("#Time1").val(), "MaxTime": $("#Time2").val(), ToUrl: $("#ToUrl").val()
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
                    //layer.msg(json.result.errMsg);
                }
                //checkAll($('#Course input[type=checkbox]'));
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }

</script>
</html>
