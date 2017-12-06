<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreatMenu.aspx.cs" Inherits="SSSWeb.BookDinner.CreatMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>创建菜单</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js"></script>

    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="newtest_detail">
            <div class="newtest_class" id="GetGrade"></div>
            <div style="margin: 0 auto; width: 246px;" class="clearfix">
                <input type="button" value="确认" class="btn fl " onclick="Save()" />
            </div>

        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    var UrlDate = new GetUrlDate();
    $(function () {
        GetDishList();
    })


    //获取班级年级数据
    function GetDishList() {
        $("#GetGrade").html("");
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: {
                "PageName": "/CanteenReservation/Order_DishHander.ashx", "Func": "GetPageList", IsPage: 'false', Status: 1, "useDate": UrlDate.useDate, "ScaleID": UrlDate.ScaleID
            },
            success: function (json) {
                $("#GetGrade").append("<p>选择菜品</p>");
                var resultData = json.result.retData;
                var TypeName = "";
                $.each(resultData, function () {
                    var TypeID = "Type" + this.Type;
                    if ($("#" + TypeID).html() != undefined) {
                        $("#" + TypeID).append("<span style='margin-left:10px;'><input id=\"rdoOpA\" name=\"classid\" type=\"checkbox\" value=\"" + this.ID + "\" />" + this.Name + "</span>");
                    }
                    else {
                        var html = "";
                        html += '<div class="clearfix" style="padding:5px 0px;margin-bottom:10px;border:1px solid #ccc;">'
                        html += '<div class="fl" style="width:70px;line-height:20px;font-size:14px;text-align:center;border-right:1px solid #ccc;"> ' + this.TypeName + '</div>';
                        html += '<div class="class_select fl" style="width:" id=' + TypeID + '></div></div>';
                        $("#GetGrade").append(html);
                        $("#" + TypeID).append("<span style='margin-left:10px;'><input id=\"rdoOpA\" name=\"classid\" type=\"checkbox\" value=\"" + this.ID + "\" />" + this.Name + "</span>");

                    }
                });

            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }

    //创建菜单
    function Save() {

        var cid = "";
        $("input[name='classid']:checked").each(function () {
            cid += $(this).val() + ",";
        });
        if (!cid) {
            layer.msg("请选择菜品");
        }
        else {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/CanteenReservation/Order_DishMenuHander.ashx",
                    "Func": "Add", "useDate": UrlDate.useDate, "ScaleID": UrlDate.ScaleID, "DishIDArry": cid
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        parent.layer.msg("菜单分配成功");
                        parent.GetMenuDish();
                        parent.CloseIFrameWindow();
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                }
            });
        }
    }
</script>

