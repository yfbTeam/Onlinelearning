<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Enterprise_Add.aspx.cs" Inherits="SSSWeb.FeedBackManage.Enterprise_Add" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>添加企业</title>
    <meta name="Keywords" content="关键词,关键词">
    <meta name="description" content="">
    <link href="../ZZSX/css/common.css" rel="stylesheet" />
    <link href="../ZZSX/css/style.css" rel="stylesheet" />
    <link href="../ZZSX/css/iconfont.css" rel="stylesheet" />
    <link href="../ZZSX/css/animate.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <%--<script src="../ZZSX/js/tz_slider.js"></script>--%>
</head>
<body>

    <!--tz_dialog start-->
    <div class="yy_dialog">

        <div class="t_content">
            <!---选项卡-->
            <div class="yy_tab">
                <div class="yy_tabheader">
                    <ul>
                        <li class="selected"><a href="#"><span class="zong_tit"><span class="num_1">1</span><span class="add_li">添加企业信息</span></span></a></li>
                        <li><a href="#"><span class="zong_tit"><span class="num_2">2</span><span class="add_li">添加实习岗位</span></span></a></li>
                        <li><a href="#"><span class="zong_tit"><span class="iconfont num_3">&#xe61d;</span><span class="add_li">完成</span></span></a></li>
                    </ul>
                </div>
                <div class="content">
                    <div class="tc" style="display: block;">
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
                            <input type="button" value="下一步" onclick="next()" />
                        </div>
                    </div>
                    <div class="tc" style="display: none;">
                        <div class="t_message">
                            <div class="message_con">
                                <form>
                                    <table class="m_top" id="job">

                                        <tr>
                                            <td class="mi"><span class="m">实习岗位：</span></td>
                                            <td class="ku">
                                                <input type="text" placeholder=" 请输入实习岗位"><a href="#"><i class="iconfont tishi jia_t" onclick="AppendJob(this)">&#xe6cd;</i></a>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </div>

                        </div>
                        <div class="t_btn">
                            <input type="button" value="完成" onclick="Save()" />
                        </div>
                    </div>

                    <div class="tc" style="display: none;">
                        <p class="finish">
                            <span class="fl icon_f"><i class="iconfont finish_t">&#xe61d;</i></span>
                            <span class="fr info_f">您已成功添加信息</span>
                        </p>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        function AppendJob(em) {
            var JobName = $(em).parent().parent().find("input").val();
            if (!JobName) {
                layer.msg("请输入岗位名称")
            }
            else {
                $(em).removeClass("jia_t").addClass("jian_t");
                $(em).html("&#xe9c6;");
                $(em).removeAttr("onclick").attr("onclick", "DelJob(this)");
                $("#job").append('<tr><td class="mi"><span class="m">实习岗位：</span></td><td class="ku"><input type="text" placeholder=" 请输入实习岗位"><a href="#"><i class="iconfont tishi jia_t" onclick="AppendJob(this)">&#xe6cd;</i></a></td></tr>');
            }
        }
        function DelJob(em) {
            $(em).parent().parent().parent().remove();
        }
      
        function Save() {
            var Job = "";
            $("#job").find("input").each(function () {
                Job += $(this).val() + ",";
            })
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
                    PassWord: PassWord, ContactMan: ContactMan, ContactPhone: ContactPhone, Email: Email, Job: Job
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "1") {
                        $(".content").find(".tc").eq(2).show().siblings().hide();
                        $(".yy_tabheader").find("ul").find("li").eq(2).addClass("selected").siblings().removeClass("selected");
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
        function next() {
            var flag = true;
            $("input.hu").each(function () {
                var value = $(this).val();
                if (!value) {
                    $(this).parent().find('i').addClass('iconfont').removeClass('true_t').addClass('fault_t');
                    $(this).parent().find('i').html("&#xe619;");
                    flag = false;
                    layer.msg("请输入必填项数据")
                }
            })
            if (flag) {
                $(".content").find(".tc").eq(1).show().siblings().hide();
                $(".yy_tabheader").find("ul").find("li").eq(1).addClass("selected").siblings().removeClass("selected");
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
