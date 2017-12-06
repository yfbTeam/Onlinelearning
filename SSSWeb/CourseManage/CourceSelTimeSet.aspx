<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourceSelTimeSet.aspx.cs" Inherits="SSSWeb.CourseManage.CourceSelTimeSet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/stylebase.css" rel="stylesheet" />
    <link href="../css/commonbase.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script id="tb_Unit" type="text/x-jquery-tmpl">
        <tr id="${ID}">
            <td>${pageIndex()}</td>
            <td>${WeekNames}</td>
            <td>
                <input type="button" name="save" class="Topic_btn" value="编辑" onclick="Edit('${ID}', '${WeekIDs}');" />
                <input type="button" name="delete" class="Topic_btn" value="删除" onclick="Delete('${ID}');" />
            </td>
        </tr>
    </script>

</head>
<body>
    <input type="hidden" id="hid_UserIDCard" value="<%=UserInfo.UniqueNo %>" />
    <div class="yy_tab">
        <div class="content">
            <div class="tc">
                <div class="t_message">
                    <table class="W_form">
                        <thead>
                            <tr class="trth">
                                <th class="number">序号</th>
                                <th class="Project_name" style="width: 60%;">上课时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="tb_CatalogList">
                        </tbody>
                    </table>
                </div>
                <div class="submit_btn">
                    <span class="Save_and_submit">
                        <input type="submit" value="新建" class="Save_and_submit" onclick="Add();" /></span>
                    <span class="cancel">
                        <input type="submit" value="取消" class="cancel" onclick="javascript: parent.CloseIFrameWindow();" /></span>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
    var UrlDate = new GetUrlDate();
    $(function () {
        getData();
    })

    //获取数据
    function getData() {
        $("#tb_CatalogList").html('');
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            dataType: "json",
            data: { "PageName": "/CourseManage/CourceManage.ashx", func: "Course_WeekSet" },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tb_Unit").tmpl(json.result.retData).appendTo("#tb_CatalogList");
                }
                else {
                    layer.msg(json.result.errMsg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("#tb_CatalogList").html("<tr><td class='NoContent' colspan='100'>无内容</td></tr>");
            }
        });
    }
    function Add() {
        $("#tb_CatalogList").append('<tr><td>--</td><td><div class="class_select fl"><span style="margin-left: 10px;"><input name="classid" id="rdoOpA" type="checkbox" value="1">周一</span><input name="classid" type="checkbox" value="2">周二</span><span style="margin-left: 10px;"><input name="classid" type="checkbox" value="3">周三</span><span style="margin-left: 10px;"><input name="classid" type="checkbox" value="4">周四</span><span style="margin-left: 10px;"><input name="classid" type="checkbox" value="5">周五</span></div></td><td><input type="button" name="save" class="Topic_btn" value="保存" onclick="javascript: Save();" /></td></tr>');
    }
    function Save(id) {
        var ids = "";
        var Names = "";
        $("input[name='classid']:checked").each(function () {
            var id = $(this).val();
            var Name = $(this).parent().text();
            ids += id + ",";
            Names += Name + ",";

        });
        if (ids != "") {
            var fun = "EditWeeKSet";
            if (id == "") {
                fun = "AddWeeKSet";
            }
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "/CourseManage/CourceManage.ashx", func: fun, ID: id,
                    WeekIDs: ids, WeekNames: Names

                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (Pid == "0") {
                            if (name == "") { //如果新添加则应改id为新加项的id
                                id = json.result.retData;
                            }
                            newname = "<a href=\"javascript:getSonData('" + id + "');\">" + newname + "</a>";
                        }
                    }
                }
            });
        }
    }
    function Edit(id, weekIds) {
        var tds = $("#" + id).find("td");
        var btnsave = $(tds).eq(2).html('<input type="button" name="save" class="Topic_btn" value="保存" onclick="javascript: Save(' + id + ');" />');
        $(tds).eq(1).html('<div class="class_select fl"><span style="margin-left: 10px;"><input name="classid" id="rdoOpA" type="checkbox" value="1">周一</span><input name="classid" type="checkbox" value="2">周二</span><span style="margin-left: 10px;"><input name="classid" type="checkbox" value="3">周三</span><span style="margin-left: 10px;"><input name="classid" type="checkbox" value="4">周四</span><span style="margin-left: 10px;"><input name="classid" type="checkbox" value="5">周五</span></div></td><td>');
        $("input[name='classid']").each(function () {
            var id = $(this).val();
            if (weekIds.indexOf(id) >= 0) {
                $(this).attr("checked", true);
            }

        });
    }
    function Delete(id) {
        $.ajax({
            url: "../Common.ashx",
            "PageName": "/CourseManage/CourceManage.ashx",
            type: "post",
            dataType: "json",
            data: { func: "DelCourse_Week", Id: id },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    getData();
                }
            }
        });
    }
</script>
</html>
