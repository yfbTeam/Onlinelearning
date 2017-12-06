<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SingTimeSet.aspx.cs" Inherits="SSSWeb.CourseManage.SingTimeSet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>签到时间管理</title>
    <!--图标样式-->
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link rel="stylesheet" href="../css/plan.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="/ResourceReservationMenu.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script id="tr_User" type="text/x-jquery-tmpl">
        <li class="data" id="${WeekID}">${WeekName}：
            <input name="Wdate" class="Wdate" id="${BeginTimeID}" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',maxDate:'#F{$dp.$D(\'${EndTimeID}\');}'})" type="text" value="${BeginTime}">
            <input name="Wdate" class="Wdate" id="${EndTimeID}" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',minDate:'#F{$dp.$D(\'${BeginTimeID}\');}'})" type="text" value="${EndTime}">
        </li>
    </script>
</head>
<body>
    <div class="time_base">
        <ul class="time">
        </ul>
        <div style="text-align: center">
            <input type="button" name="sure" id="sure" value="确定" class="sure" onclick="SetTime()" />
        </div>
    </div>
    <script src="../js/common.js"></script>
    <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(function () {
            getData();
        })
        function SetTime() {
            var flag = true;
            var arry = [];
            for (var i = 1; i < 8; i++) {
                var BeginTimeID = "BeginTime" + i;
                var EndTimeID = "EndTime" + i;
                var BeginTime = $("#" + BeginTimeID).val();
                var EndTime = $("#" + EndTimeID).val();
                if ((BeginTime.length == 0 && EndTime.length > 0) || (BeginTime.length > 0 && EndTime.length == 0)) {
                    flag = false;
                    layer.msg("每一天的起止时间必须同时设置或者同时不设置");
                }
                else {
                    arry += "{" + i + "," + BeginTime + "," + EndTime + "}-"
                }
            }
            if (flag) {

                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    dataType: "json",
                    data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "EditActiveTime", "Data": arry },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            parent.layer.msg('修改成功!');
                            parent.CloseIFrameWindow();
                        }
                        else {
                            getData();
                            parent.layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }
        }
        function getData() {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "SingActiveTime", "Ispage": "false" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#tr_User").tmpl(json.result.retData).appendTo(".time");
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
