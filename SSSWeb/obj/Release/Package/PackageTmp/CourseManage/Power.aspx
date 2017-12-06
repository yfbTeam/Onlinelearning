<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Power.aspx.cs" Inherits="SSSWeb.CourseManage.Power" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>权限设置</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link href="/css/plan.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }

        .change_picture .uploadify-button {
            font-size: 14px;
            border: none;
            background: #00a1ec;
            color: #fff;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->

</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.IDCard %>" />
    <form id="form1" runat="server">
        <input id="option" type="hidden" value=">" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/AppManage/Index.aspx">
                    <img src="/images/logo.png" />
                </a>
                <div class="wenzi_tips fl">
                    <img src="/images/quanxianshezhi.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul>
                        <li><a href="/CourseManage/SystemParam.aspx">系统参数</a></li>
                        <li class="active"><a href="#">权限设置</a></li>
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
            <div id="officeResource">
                <iframe src="/SystemSettings/RoleSettings.aspx" width="100%" height="1200px" id="iframeContent" scrolling="no" allowtransparency="true" frameborder="no"></iframe>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript" src="/js/common.js"></script>


</html>
