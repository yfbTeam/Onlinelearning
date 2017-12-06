<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Enterprise_Edit.aspx.cs" Inherits="SSSWeb.FeedBackManage.Enterprise_Edit" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>修改企业</title>
    <meta name="Keywords" content="关键词,关键词">
    <meta name="description" content="">
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/iconfont.css" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script type="text/javascript" src="../ZZSX/js/tz_slider.js"></script>
</head>
<body style="background: #FAFAFA;">

    <!--tz_dialog start-->
    <div class="yy_dialog">

        <div class="t_content">
            <div class="yy_tab">
                <div class="content">
                    <div class="tc">
                        <div class="t_message">
                            <div class="message_con">
                                <form>
                                    <table class="m_top">
                                        <tr>
                                            <td class="mi"><span class="m">企业名称：</span></td>
                                            <td class="ku">
                                                <input type="text" class="hu" placeholder=" 请输入企业名称" id="Name"><i class="tishi">&#xe61d;</i></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">企业账号：</span></td>
                                            <td class="ku">
                                                <input type="text" class="hu" placeholder=" 请输入企业账号" id="LoginName"><i class="tishi">&#xe619;</i></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">密码：</span></td>
                                            <td class="ku">
                                                <input type="password" class="hu" placeholder=" 请输入密码" id="PassWord"><i class="tishi">&#xe61d;</i></td>
                                        </tr>
                                    </table>
                                    <table class="c_line">
                                        <tr></tr>
                                    </table>
                                    <table class="m_bottom">
                                        <tr>
                                            <td class="mi"><span class="m">负责人：</span></td>
                                            <td class="ku">
                                                <input type="text" class="hu" placeholder=" 请输入负责人名称" id="ContactMan"><i class="tishi">&#xe61d;</i></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">电话：</span></td>
                                            <td class="ku">
                                                <input type="text" class="hu" placeholder=" 请输入电话" id="ContactPhone"><i class="tishi">&#xe61d;</i></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">电子邮箱：</span></td>
                                            <td class="ku">
                                                <input type="text" class="hu" placeholder=" 请输入邮箱" id="Email"><i class="tishi">&#xe61d;</i></td>
                                        </tr>
                                    </table>

                                </form>
                            </div>

                        </div>
                        <div class="t_btn">
                            <input type="button" value="保存" onclick="Save()" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            GetDateByID();
        })
        function GetDateByID() {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "FeedBack/Enterprise.ashx", "Func": "GetPageList", Ispage: "false", ID: UrlDate.ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $.each(json.result.retData, function () {
                            $("#Name").val(this.Name);
                            $("#LoginName").val(this.LoginName);
                            $("#PassWord").val(this.PassWord);
                            $("#ContactMan").val(this.ContactMan);
                            $("#ContactPhone").val(this.ContactPhone);
                            $("#Email").val(this.Email);
                        })
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
        function Save() {
            var flag = true;
            $("input.hu").each(function () {
                var value = $(this).val();
                if (!value) {
                    $(this).parent().find('i').addClass('iconfont').removeClass('true_t').addClass('fault_t');
                    $(this).parent().find('i').html("&#xe619;");
                    layer.msg("请输入必填项数据")
                    flag=false;
                }
            })
            if (flag) {

                var Name = $("#Name").val();
                var LoginName = $("#LoginName").val();
                var PassWord = $("#PassWord").val();
                var ContactMan = $("#ContactMan").val();
                var ContactPhone = $("#ContactPhone").val();
                var Email = $("#Email").val();
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    dataType: "json",
                    data: {
                        "PageName": "FeedBack/Enterprise.ashx", "Func": "AddEnterprise", ID: UrlDate.ID, Name: Name, LoginName: LoginName,
                        PassWord: PassWord, ContactMan: ContactMan, ContactPhone: ContactPhone, Email: Email, Status: ""
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            parent.layer.msg('操作成功!');
                            parent.getData(1, 10);
                            parent.CloseIFrameWindow();
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
        }
        $("input.hu").blur(function () {
            var value = $(this).val();
            if (!value) {
                $(this).parent().find('i').addClass('iconfont').removeClass('true_t').addClass('fault_t');
                $(this).parent().find('i').html("&#xe619;");
            }
            else {
                $(this).parent().find('i').addClass('iconfont').removeClass('fault_t').addClass('true_t');
                $(this).parent().find('i').html("&#xe61d;");

            }
        });
    </script>

</body>
</html>
