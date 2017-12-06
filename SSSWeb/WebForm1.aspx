<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SSSWeb.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>门头沟中等职业学校</title>
    <link type="text/css" rel="stylesheet" href="ZZSX/css/common.css" />
    <link type="text/css" rel="stylesheet" href="ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="ZZSX/css/iconfont.css" />
    <link type="text/css" rel="stylesheet" href="ZZSX/css/animate.css" />
    <link href="Scripts/layer/skin/layer.ext.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <script src="Scripts/Common.js"></script>
    <script src="Scripts/layer/layer.js"></script>
    <%--<script src="Scripts/jquery-1.11.2.min.js"></script>--%>
    <script type="text/javascript">
        function loading() {
            var Timtrigger = new Date();
            var silderBox = document.getElementById("sliderbox");//dom对象
            var adoms = silderBox.getElementsByTagName("a");//这是一个集合对象HTMLCollection对象
            var len = adoms.length;
            while (len--) {
                new Date().getTime();
                adoms[len].onclick = function () {
                    var src = this.getAttribute("data-src");
                    if (src != null) {
                        $(".submenu").find('li.selected').removeClass("selected");
                        $(this).parent().addClass("selected");//.siblings().removeClass("selected");

                        if (src == "#") {
                            $('#right_content iframe').attr('src', "/noContent.html");
                        }
                        else {
                            if (src.indexOf("?") < 0) {
                                src = src + "?parm=" + new Date().getTime(); // + Math.random();
                            }
                            else {
                                src = src + "&parm=" + new Date().getTime(); // + Math.random();
                            }
                            if (src.toString().indexOf("http") < 0) {
                                //window.location.href = '/webform1.aspx?PageName=' + src;
                                $('#right_content iframe').attr('src', src);
                            }
                            else {
                                window.open(src);
                            }
                        }
                    }
                }
            };
        };
        window.onload = loading;
        function ShowMain() {
            $('#right_content iframe').attr('src', "PersonalOffice/Main.aspx");
        }
    </script>


    <script type="text/javascript" src="ZZSX/js/tz_slider.js"></script>

</head>
<body>
    <div id="container">
        <!--头部-->
        <div class="header main1">
        </div>
        <div class="center1 main1">
            <div class="center_top">
                <div class="left_logo fl">
                    <img src="ZZSX/images/logo.png" style="cursor: pointer" onclick="ShowMain()" />
                </div>
                <div class="message_right fr">
                    <%--<div class="xiaoxi fl">
                        <div class="youxiang fl"><a href="#"><i class="iconfont">&#xe92e;</i></a></div>
                        <div class="shezhi fl"><a href="#"><i class="iconfont">&#xe621;</i></a></div>
                    </div>--%>
                    <div class="email fl">
                        <ul>
                            <li>
                                <dl class="slidedown">
                                    <dt class=""><a href="#"><i class="photo">
                                        <img src="<%=UserInfo.AbsHeadPic %>" /></i><em><%=UserInfo.Name %></em></a></dt>
                                    <dd>
                                        <div class="slidecon" style="display: none;">
                                            <ul class="s_con">
                                                <li><a href="#" onclick="javascript:OpenIFrameWindow('修改密码', '/AppManage/EditPwd.aspx', '500px', '300px');">修改密码</a></li>
                                                <%--<li><a href="#">消息提醒</a></li>--%>
                                                <li><a href="#" onclick="logOut()">退出系统</a></li>
                                            </ul>
                                        </div>
                                    </dd>
                                </dl>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
            <!--内容区域-->
            <div class="box main1">
                <!--左边-->
                <div class="left" id="sliderbox">
                    <div class="menubox">
                        <!--菜单区域-->
                        <div class="menuf">
                            <ul id="menubox">
                            </ul>
                        </div>
                        <!--end 菜单区域-->

                    </div>
                </div>
                <!--右边-->
                <div class="right">
                    <div class="aside1"></div>
                    <div id="right_content">
                        <iframe name="right-content" src="PersonalOffice/Main.aspx" width="100%" height="800px"></iframe>
                    </div>
                </div>

            </div>
        </div>
        <div class="clear"></div>
        <div class="main1 footer">
            <div class="footer_con">
                <p>版权所有：北京市门头沟区中等职业学校 地址： 门头沟区城子大街10号 邮编：102300   </p>
                <p>
                    京ICP备06040017号-1 京公网安备11010902000310
                </p>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            GetLeftNavigationMenu();
        })
        /*var UrlDate = new GetUrlDate();
        $(function () {
            if (UrlDate.PageName != undefined) {
                if ($("#menubox").html().trim() == "") {
                    $('#right_content').load('PersonalOffice/Main.aspx');
                    GetLeftNavigationMenu();
                }
                GetAByName(UrlDate.PageName);
            }
            else {
                $('#right_content').load('/PersonalOffice/Main.aspx');
                GetLeftNavigationMenu();
            }
        })
        function GetAByName(PageName) {
            $("#menubox").find('a').each(function () {
                var src = this.getAttribute("data-src");
                if (src != null) {
                    if (PageName.indexOf(src) >= 0) {
                        $(".menubox").find('li.selected').removeClass("selected");
                        $(".submenu").hide();
                        $(this).parent().addClass("selected");//.siblings().removeClass("selected");
                        $(this).parent().parent().show();
                        $(this).parent().parent().parent().addClass("selected");
                        //if (PageName.indexOf(src) >= 0) {
                        $('#right_content').load(PageName);
                        //}
                    }
                }
            })
        }*/
        var jsonMenu = [];
        function GetLeftNavigationMenu() {
            $("#Menu").html("");
            $.ajax({
                url: "Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "IDCard": '<%=UserInfo.UniqueNo%>', "Func": "GetModelList", Ispage: "false"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        jsonMenu = json.result.retData;
                        BindMenu(0)

                    }
                    else {
                        // $("#main").html('<div class="modult" id=""><h1 class="title"><span>无分类</span></h1><div class="apps_wrap clearfix"><div class="apps clearfix"><div class="add fl" onclick="AddApp()"><i class="iconfont icon-add"></i></div></div></div></div>');

                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function BindMenu(pid) {
            $(jsonMenu).each(function () {
                if (pid == "0" && this.Pid == "0") {
                    var MenuID = 'ul' + this.ID;
                    var i = $("#menubox>li").length
                    var display = "";
                    if (i > 0) {
                        display = ' style = "display: none;"';
                    }
                    var li = '<li><a class="menuclick"><i>-</i>' + this.ModelName
                        + '</a><ul class="submenu"' + display +
                        ' id=' + MenuID + '></ul> </li>';
                    $("#menubox").append(li);
                    BindMenu(this.ID);
                    //i++;
                }
                else {
                    if (this.Pid == pid) {
                        var MenuID = 'ul' + this.Pid;
                        $("#" + MenuID).append(' <li><a href="javascript:void(0);" data-src="' + this.LinkUrl + '">' + this.ModelName + '</a></li>');
                    }
                }

            })
        }

    </script>
    <script src="ZZSX/js/tz_slider.js" type="text/javascript"></script>
</body>
</html>

