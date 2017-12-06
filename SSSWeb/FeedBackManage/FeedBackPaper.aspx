<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedBackPaper.aspx.cs" Inherits="SSSWeb.FeedBackManage.FeedBackPaper" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/iconfont.css" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script type="text/javascript" src="../ZZSX/js/tz_slider.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
        .feedback input {
            padding: 0 2px;
            margin-left: 5px;
            border-radius: 3px;
            line-height: 10px;
        }

        .feedback textarea {
            padding: 0 2px;
            margin-left: 2px;
            border-radius: 3px;
            border: 1px solid #ccc;
        }

        .feedback tr {
            height: 30px;
            line-height: 44px;
        }

        .feedback .btn {
            color: #fff;
            width: 100px;
            border: none;
            border-radius: 3px;
            padding: 15px 0;
            font-size: 14px;
            font-family: "微软雅黑";
            background: #96cc66;
            cursor: pointer;
        }

        .feedback_con {
            margin: 20px;
        }

        .feedback {
            width: 98%;
            margin: 10px auto;
        }

            .feedback caption {
                height: 80px;
                line-height: 80px;
                text-align: center;
                vertical-align: middle;
                border: 1px solid #000;
                border-bottom: none;
            }

            .feedback tr td {
                padding: 15px;
                line-height: 20px;
                height: 20px;
                border: 1px solid #000;
            }

            .feedback tr.rightf td {
                text-align: right;
                padding-right: 100px;
            }

            .feedback tr.date td {
                padding-right: 50px;
                text-align: right;
            }

                .feedback tr.date td span {
                    display: inline-block;
                    min-width: 40px;
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="feedback" id="FeedBack">
                <caption>实习生鉴定表</caption>
                <tr>
                    <td>学生姓名</td>
                    <td id="StuName">张三</td>
                    <td>学生性别</td>
                    <td>女</td>
                </tr>
                <tr>
                    <td>所在学校</td>
                    <td>门头沟中等职业学校</td>
                    <td>所在班级</td>
                    <td id="ClassName">高三一班</td>
                </tr>
                <tr>
                    <td>学习专业</td>
                    <td>计算机信息管理</td>
                    <td>实习岗位</td>
                    <td id="JobName">软件研发工程师</td>
                </tr>
                <tr>
                    <td>实习单位</td>
                    <td id="EnterName">北京A公司</td>
                    <td>起止时间：</td>
                    <td>
                        <input id="StartTime" type="text" value="" onclick="WdatePicker(FormData('yyyy-MM-dd'))" style="width: 90px;" />-
                        <input id="endTime" type="text" value="" onclick="WdatePicker(FormData('yyyy-MM-dd'))" style="width: 90px;" /></td>
                </tr>
                <tr>
                    <td>实习内容：</td>
                    <td colspan="3">
                        <textarea id="Content" cols="20" rows="2" style="height: 100px; width: 600px"></textarea>
                    </td>

                </tr>
                <tr>
                    <td>实习成绩：</td>
                    <td colspan="3">
                        <input type="text" id="ScoreResult" />
                    </td>

                </tr>
                <tr>
                    <td>实习鉴定：</td>
                    <td colspan="3">
                        <textarea id="IdentifidMsg" cols="20" rows="2" style="height: 100px; width: 600px"></textarea>
                    </td>

                </tr>


                <tr class="rightf">
                    <td colspan="4">领导签字：</td>
                </tr>
                <tr class="rightf">
                    <td colspan="4">单位盖章：</td>

                </tr>
                <tr class="date">
                    <td colspan="4"><span></span>年<span></span>月<span></span>日</td>
                </tr>
                <tr>
                    <td colspan="6" style="text-align: center;">
                        <input type="reset" class="btn" value="提交" onclick="Save()" />
                        <%--<input type="reset" class="btn" value="取消重填" id="reset3" runat="server" />--%>
                    </td>
                </tr>
            </table>


        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            getData();
        })
        var UrlDate = new GetUrlDate();
        function getData() {

            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "FeedBack/FeedBack.ashx", "Func": "GetPageList", IsPage: "false", "ID": UrlDate.ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $.each(json.result.retData, function () {
                            $("#EnterName").html(this.EnterName);
                            $("#JobName").html(this.JobName);
                            $("#StuName").html(this.CreateName);
                            $("#ClassName").html(this.OrgName);
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
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "FeedBack/FeedBack.ashx", "Func": "Edit", StartTime: $("#StartTime").val(),
                    "EndTime": $("#endTime").val(), Content: $("#Content").val(), "ID": UrlDate.ID,
                    ScoreResult: $("#ScoreResult").val(), IdentifidMsg: $("#IdentifidMsg").val()
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
    </script>
</body>
</html>




