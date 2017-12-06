<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SSSWeb.Login" %>

<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
    <meta charset="utf-8" />
    <title>门头沟中等职业学校</title>
    <link type="text/css" rel="stylesheet" href="css/layout.css" />
    <link type="text/css" rel="stylesheet" href="css/reset.css" />
    <style type="text/css">
        .code {
            background-image: url(w1.jpg);
            font-family: Arial;
            font-style: italic;
            color: Red;
            border: 0;
            padding: 2px 3px;
            letter-spacing: 3px;
            font-weight: bolder;
        }

        .header_wrap {
            width: 100%;
            height: 114px;
            border-top: 6px solid #23A0F0;
        }

        .header {
            width: 1200px;
            margin: 0 auto;
        }

        .footer_wrap {
            width: 100%;
            height: 120px;
            background: url(images/footer_bg.png) repeat-x;
        }

            .footer_wrap .footer {
                width: 1200px;
                margin: 0 auto;
            }

        .logo {
            margin-top: 29px;
        }

        .footer_right {
            margin-top: 33px;
        }

            .footer_right p {
                font-size: 12px;
                color: #666666;
                line-height: 22px;
                text-align: right;
            }

                .footer_right p a {
                    color: #666666;
                }

        .content {
            width: 100%;
            height: 660px;
            background: url(images/content_02.png) no-repeat center top;
            background-size: cover;
        }

        .main1 {
            width: 1200px;
            margin: 0 auto;
            position: relative;
            height: 100%;
        }

        .login_conaa {
            padding: 10px;
            background: rgba(255,255,255,.2);
            border-radius: 3px;
            width: 340px;
            height: 320px;
            float: right;
            position: absolute;
            right: 0;
            top: 50%;
            margin-top: -155px;
        }

        .Login .login_con {
            height: 280px;
        }

        .Login {
            padding-top: 0;
        }

        .login_img {
            position: relative;
            height: 100%;
            width: 43%;
        }

            .login_img img {
                position: absolute;
                top: 0;
                left: 0;
                bottom: 0;
                margin: auto;
            }

        @media screen and (min-width:1366px) and (max-width:1920px) {
            .login_img {
                width: 50%;
            }
        }
    </style>
</head>
<body>
    <input type="hidden" id="HAdminUser" value="" />
    <input type="hidden" id="hidPreUrl" runat="server" />
    <!--- -->
    <div class="header_wrap">
        <div class="header">
            <img src="images/header.png" />
        </div>

    </div>
    <div class="content">
        <div class="Login main1">
            <div class="fl login_img pr">
                <img src="images/login_img.png" />
            </div>
            <div class="login_conaa">
                <div class="login_con">
                    <h1>系统登录</h1>
                    <div class="form">
                        <form method="get" action="">
                            <ul class="con">
                                <li class="xian"><span class="icon">
                                    <img src="images/people.png" /></span><input id="txt_loginName" type="text" class="kuang" value="admin" placeholder="请输入用户名" /></li>
                                <li class="xian"><span class="icon">
                                    <img src="images/password.png" /></span><input id="txt_passWord" type="password" class="kuang" value="yfb@2017" placeholder="请输入密码" /></li>
                                <li class="yzm xian clearfix"><span class="icon">
                                    <input type="hidden" id="hidCode" name="hidCode" />
                                    <img src="images/yzm.png" /></span><input id="inpCode" type="text" style="ime-mode: disabled" class="kuang1" placeholder="请输入验证码" />
                                    <img src="SystemSettings/VerificationCode.ashx" id="checkCode" style="width: 120px; height: 35px; float: right; border: 1px solid #e5e5e5;" alt="点击切换验证码" title="点击切换验证码" onclick="ToggleCode();return false;" />
                                    <%--<input type="text" id="checkCode" class="code" style="width: 50px" /></span><a href="#" onclick="createCode()">刷新</a>--%>
                                </li>
                                <li class="clearfix">
                                    <a href="forgetPwd.aspx" target="_blank" class="fr" id="forgetPwd">忘记密码？</a>
                                </li>
                                <li>
                                    <span class="btn">
                                        <input id="BtnLogin" type="button" class="btn_btn" value="登录" onclick="Login()" />
                                    </span>
                                </li>
                            </ul>
                            <div class="clear"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="footer_wrap" id="footer">
        <div class="footer clearfix">
            <div class="logo fl">
                <img src="images/logo1.png" style="height: 60px;" />
            </div>

            <div class="footer_right fr">
                <p>
                    咨询电话: 010-83068508
                </p>
                <p>
                    地址: 北京市丰台区南四环西路128号诺德中心3座7层
                </p>
            </div>
        </div>
    </footer>
</body>

<script src="Scripts/jquery-1.11.2.min.js"></script>
<script src="Scripts/layer/layer.js"></script>
<script src="Scripts/jquery.cookie.js"></script>
<script src="Scripts/Common.js?parm=2.2"></script>
<script src="Scripts/md5.js"></script>

<script>
    var UrlDate = new GetUrlDate();
    $(document).ready(function () {
        //加载验证码
        ToggleCode();
        //回车提交事件
        $("body").keydown(function (e) {
            var e = e || window.event;
            if (e.keyCode == "13") {//keyCode=13是回车键
                $("#BtnLogin").click();
            }
        });
        if (UrlDate.Param == null) {
            GetSysToken();
        }
    });
    function ToggleCode() {
        $("#checkCode").attr("src", "SystemSettings/VerificationCode.ashx?time=" + Math.random());
    }
    var code; //在全局 定义验证码
    function createCode() {
        code = "";
        var codeLength = 4;//验证码的长度
        var checkCode = document.getElementById("checkCode");
        checkCode.value = "";
        var selectChar = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

        for (var i = 0; i < codeLength; i++) {
            var charIndex = Math.floor(Math.random() * 60);
            code += selectChar[charIndex];
        }
        if (code.length != codeLength) {
            createCode();
        }
        checkCode.value = code;
        $("#hidCode").val(code);
    }
    function Login() {
        var loginName = $("#txt_loginName").val();
        var passWord = $("#txt_passWord").val();
        if (!loginName.trim().length) {
            ToggleCode();
            layer.msg("请输入用户名！");
            return;
        }
        if (!passWord.trim().length) {
            ToggleCode();
            layer.msg("请输入密码！");
            return;
        }
        if ($("#inpCode").val().trim().toUpperCase() != getCookie("VerificationCode").toUpperCase()) {
            ToggleCode();
            layer.msg("验证码错误！");
            return;
        }
        layer.load(1, {
            shade: [0.8, '#393D49'], //0.1透明度的白色背景
        });
        /******************************统一认证登录*************************************/
       

        var postData = { Func: "Login", userName: loginName, password: hex_md5(passWord), returnUrl: window.location.href };
        $.ajax({
            type: "Post",
            url: '<%=TokenPath%>',
            data: postData,
            dataType: "jsonp",
            jsonp: "jsoncallback",
            success: function (returnVal) {
                var result = returnVal.result;
                GetUserInfoByToken(result);

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToggleCode();
                layer.closeAll('loading');
                //console.log(errorThrown);
            }
        });

    }
    function GetSysToken() {
        //var userInfo = "{\"Id\":7,\"UniqueNo\":\"啊发生\",\"UserType\":3,\"Name\":\"唐\",\"Nickname\":\"唐\",\"Sex\":1,\"Phone\":\"\",\"Birthday\":\"2016-09-29\",\"LoginName\":\"tang\",\"IDCard\":\"140481199805263255\",\"HeadPic\":\"\",\"RegisterOrg\":\"1001\",\"AuthenType\":0,\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"CreateTime\":\"2016-09-29 11:12:47\",\"EditUID\":null,\"EditTime\":null,\"IsEnable\":1,\"IsDelete\":0}";
        //$.cookie('TokenID', "e90bd89c594744c0b15d916a22b8ae92", { path: '/', secure: false });
        //$.cookie('LoginCookie_Author', userInfo, { path: '/', secure: false });
        if ($.cookie('TokenID') != null && $.cookie('TokenID') != "null" && $.cookie('TokenID') != "")
            GetUserInfoByToken($.cookie('TokenID'));
        else if ($.cookie('LoginCookie_Author') != null && $.cookie('LoginCookie_Author') != "null" && $.cookie('LoginCookie_Author') != "") {
            layer.closeAll('loading');
            var item = JSON.parse($.cookie('LoginCookie_Author'));
            if (item.LoginName != "") $("#txt_loginName").val(item.LoginName);
            if ($.cookie('RememberCookie_Cube') != null && $.cookie('RememberCookie_Cube') != "null" && $.cookie('RememberCookie_Cube') != "") {
                if (item.Password != "") $("#txt_passWord").val($.cookie('RememberCookie_Cube'));
                $("#rem_paddword").prop("checked", true);
            }
        }
        else
            layer.closeAll('loading');
    }
    function GetUserInfoByToken(tokenID) {
        if (tokenID != "") {
            var postData = { Func: "GetUserInfoByToken", tokenID: tokenID, returnUrl: window.location.href };
            $.ajax({
                type: "Post",
                url: '<%=TokenPath%>',
                data: postData,
                dataType: "jsonp",
                jsonp: "jsoncallback",
                success: function (returnVal) {
                    var flg = returnVal.result;
                    if (flg != null) {
                        if (flg.errNum == 0) {
                            if (flg.retData.IsEnable=="0") {
                                layer.msg("用户已被禁用");
                            }
                            else if (flg.retData.IsDelete == "1") {
                                layer.msg("用户不存在");
                            }
                            else {
                                var item = flg.retData;
                                $.cookie('TokenID', tokenID, { path: '/', secure: false });
                                if (item.CreateTime != null) item.CreateTime = DateTimeConvert(item.CreateTime);
                                if (item.EditTime != null) item.EditTime = DateTimeConvert(item.EditTime);
                                if (item.Birthday != null) item.Birthday = DateTimeConvert(item.Birthday);
                                $.cookie('LoginCookie_Author', encodeURIComponent(JSON.stringify(item)), { path: '/', secure: false });
                                if ($("#rem_paddword").is(":checked"))
                                    $.cookie('RememberCookie_Cube', $("#txt_passWord").val(), { path: '/', secure: false });
                                //GetUserRole();
                                //var adminUser = $("#HAdminUser").val();
                                //if (adminUser.indexOf(flg.retData.UniqueNo) < 0) {
                                //    window.location = "/PersonalSpace/CourseManIndex.aspx";
                                //}
                                //else
                                //window.location = "Index_NZ.aspx";
                                window.location = "WebForm1.aspx";
                            }

                        } else {
                            layer.msg(flg.errMsg);
                        }
                    }
                    layer.closeAll('loading');
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.closeAll('loading');
                }
            });
        }
    }
    function GetUserRole() {
        $.ajax({
            url: "SystemSettings/UserInfo.ashx",
            async: false,
            dataType: "text",
            data: { "Func": "GetUserRole" },
            success: function (result) {
                $("#HAdminUser").val(result);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg(errorThrown);
            }
        });
    }
    function OnSuccessLogin(json) {
        layer.closeAll('loading');
        var cookie = json.result;
        if (cookie.errNum == "0") {
            var str = cookie.retData[0];
            if (str != "" && str.length > 0) {
                var items = JSON.parse(cookie.retData[0]);
                if (items != null && items.data.length > 0) {
                    var item = items.data;
                    $.cookie('LoginCookie_Author', JSON.stringify(item[0]), { path: '/', secure: false });
                    if ($("#rem_paddword").is(":checked")) $.cookie('RememberCookie_Cube', $("#txt_passWord").val(), { path: '/', secure: false });
                    if ($("#hidPreUrl").val() != "" && ($("#hidPreUrl").val().toLocaleLowerCase().indexOf("login.aspx") < -1 || $("#hidPreUrl").val().toLocaleLowerCase().indexOf("register.aspx") < -1)) window.location = $("#hidPreUrl").val();
                    else window.location = "AppManage/Index.aspx";// "/StuAssociate/AssoIndex.aspx";
                    return;
                }
            }
            layer.msg("用户名或密码错误！");

        } else if (cookie.errNum == "333") {
            layer.msg("帐号已被禁用请联系管理员！");
        } else if (cookie.errNum == "444") {
            layer.msg("帐号已被删除请重新注册！");
        } else if (cookie.errNum == "999") {
            layer.msg("用户名或密码错误！");
        }
        else {
            layer.msg(json.result.errMsg + "！");
        }
    }
    function OnErrorLogin(XMLHttpRequest, textStatus, errorThrown) {
        layer.msg("登录名或密码错误！" + errorThrown);
    }

  
</script>
</html>
