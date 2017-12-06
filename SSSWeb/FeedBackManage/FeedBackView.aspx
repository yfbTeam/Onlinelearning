<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedBackView.aspx.cs" Inherits="SSSWeb.FeedBackManage.FeedBackView" %>

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
    <script src="../js/jquery.jqprint.js"></script>
    <script src="../js/jquery-migrate-1.1.0.js"></script>
    <link href="StyleSheet1.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {
            $("#print").click(function () {
                //$("#Print_mess").show();
                $("#FeedBack").jqprint({
                    debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
                    importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
                    printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
                    operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
                });
                //$("#Print_mess").hide();

            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <table class="feedback" id="FeedBack">
                <caption>实习生鉴定表</caption>
                <tr>
                    <td style="min-width:100px;">学生姓名</td>
                    <td id="StuName"></td>
                    <td>学生性别</td>
                    <td></td>
                </tr>
                <tr>
                    <td>所在学校</td>
                    <td>门头沟中等职业学校</td>
                    <td>所在班级</td>
                    <td id="ClassName"></td>
                </tr>
                <tr>
                    <td>学习专业</td>
                    <td></td>
                    <td>实习岗位</td>
                    <td id="JobName"></td>
                </tr>
                <tr>
                    <td>实习单位</td>
                    <td id="EnterName"></td>
                    <td>起止时间</td>
                    <td id="Time"></td>
                </tr>
                <tr>
                    <td>实习内容</td>
                    <td colspan="3" id="Content"></td>

                </tr>
                <tr>
                    <td>实习成绩</td>
                    <td colspan="3" id="ScoreResult">合格</td>

                </tr>
                <tr>
                    <td>实习鉴定</td>
                    <td colspan="3" id="IdentifidMsg"></td>

                </tr>
                <tr class="rightf">
                    <td colspan="4">领导签字：</td>
                </tr>
                <tr class="rightf">
                    <td colspan="4">单位盖章：</td>

                </tr>
                <tr class="date">
                    <td colspan="4">签字时间：</td>
                </tr>
              
            </table>
            <input type="reset" class="btn" value="打印" id="print" runat="server" />

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
                            $("#Content").html(this.Content);
                            $("#ScoreResult").html(this.ScoreResult);
                            $("#IdentifidMsg").html(this.IdentifidMsg);
                            $("#Time").html(DateTimeConvert(this.StartTime, "yyyy-MM-dd") + '-' + DateTimeConvert(this.EndTime, "yyyy-MM-dd"));
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
    </script>
</body>
</html>
