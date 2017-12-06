<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SkeDiskSet.aspx.cs" Inherits="SSSWeb.PersonalOffice.SkeDiskSet" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>网盘配置</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>

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
            <td>${SumSize/1024/1024}M </td>
            <td>${AddLen}M</td>
            <td>${AllLen}M</td>
            <td>${SumSize/(AllLen*1024*1024)}
            </td>
            <td><a href="javascript:;" onclick="javascript:OpenIFrameWindow('修改设置', '/PersonalOffice/SkyCapacitySet.aspx?Type=Each&ID=${ID}&AddLen=${AddLen}&CreateUID=${CreateUID}&UserID=${UserID}', '600px', '270px');"><i class="icon icon-edit"></i>修改</a>
            </td>
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
        <header class="repository_header_wrap manage_header none">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../AppManage/Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/coursesystem.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul>
                        <li class="active"><a href="#">课程管理</a></li>
                        <li><a href="../CourseManage/StuManage.aspx?Type=1">进度查看</a></li>
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
        <div class="onlinetest_item width">
            <div class="course_manage bordshadrad">
                
                <div class="newcourse_select clearfix" id="CourseSel">

                    <%--<div class="stytem_select_right fl" style="margin-left: 10px;">

                        <div class="search_exam fl pr">
                            <select name="" class="select" id="CourseType" onchange="getData(1, 10)" style="height: 30px; margin: 0px 5px">
                               
                            </select>
                            <input type="text" name="" id="CourseName" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="getData(1,10)"></i>
                        </div>
                    </div>--%>
                    <div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" onclick="javascript:OpenIFrameWindow('整体设置', '/PersonalOffice/SkyCapacitySet.aspx?Type=All', '500px', '270px');">
                            <i class="icon icon-plus"></i>整体设置
                        </a>
                        
                    </div>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th>使用人</th>
                            <th>已使用</th>
                            <th>个人新增容量</th>
                            <th>总容量</th>
                            <th>使用率</th>
                            <th>操作</th>
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
        <footer id="footer" class="none"></footer>
    </form>
</body>
<script type="text/javascript" src="../js/common.js"></script>
<script>
    var UrlDate = new GetUrlDate();

    $(document).ready(function () {
        //SetPageButton('<%=UserInfo.UniqueNo%>')
        //$('#footer').load('../footer.html');
        getData(1, 10);
    });

    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "ResourceManage/SkySet.ashx", "Func": "GetAllUserInfo", PageIndex: startIndex, pageSize: pageSize,"Parm":new Date().getTime()
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
</script>
</html>
