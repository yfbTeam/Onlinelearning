<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Job_Add.aspx.cs" Inherits="SSSWeb.FeedBackManage.Job_Add" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>添加实习岗位</title>
    <meta name="Keywords" content="关键词,关键词">
    <meta name="description" content="">
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/iconfont.css" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>

    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script type="text/javascript" src="../ZZSX/js/tz_slider.js"></script>
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td class="tt">
                <span class="m">${Name}</span>
                <div class="qijin">
                    {{if Status==1}}
                    <span class="Enable active">启用</span><span class="Disable" onclick="ChangeStatus(0,${ID})">禁用</span>
                    {{else}}<span class="Enable" onclick="ChangeStatus(1,${ID})">启用</span><span class="Disable active">禁用</span>
                    {{/if}}
                </div>
            </td>
        </tr>
    </script>
</head>
<body style="background: #FAFAFA;">

    <!--tz_dialog start添加实习岗位-->
    <div class="yy_dialog">

        <div class="t_content">
            <!---选项卡-->
            <div class="yy_tab">
                <div class="content">
                    <div class="internship">
                        <div class="t_message">
                            <div class="message_con">
                                <div class="add_input">
                                    <input type="text" class="add_sear" id="Name" placeholder="请输入职位名称">
                                    <input type="button" class="b_add" value="添加" onclick="AddJob()">
                                </div>
                                <form>
                                    <table class="add_internship" id="tb_Manage">
                                    </table>
                                </form>
                            </div>

                        </div>
                        <%--<div class="t_btn">
                            <input type="button" value="保存" onclick="AddJob()"/>
                        </div>--%>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            $('.qijin>span').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
            })
            getData();
        })
        //获取数据
        function getData() {
            //初始化序号 
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "FeedBack/Enterprise.ashx", "Func": "GetJobList", EnterID: UrlDate.EnterID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#tb_Manage").html('');
                        $("#tr_User").tmpl(json.result.retData).appendTo("#tb_Manage");
                    }
                    else {
                        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        $("#tb_Manage").html(html);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function AddJob() {
            var Name = $("#Name").val();
            if (!Name) {
                layer.msg("请输入岗位名称");
                return;
            }
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "FeedBack/Enterprise.ashx", "Func": "AddJob", Name: $("#Name").val(), EnterID: UrlDate.EnterID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("添加成功");
                        getData();
                        parent.getData(1,10);
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
        function ChangeStatus(Status, ID) {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "FeedBack/Enterprise.ashx", "Func": "AddJob", ID: ID, Status: Status
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("修改成功");
                        getData();
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
    </script>
</body>
</html>
