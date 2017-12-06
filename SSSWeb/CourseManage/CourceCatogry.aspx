<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourceCatogry.aspx.cs" Inherits="SSSWeb.CourseManage.CourceCatogry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>课程分类管理</title>
    <link href="../css/stylebase.css" rel="stylesheet" />
    <link href="../css/commonbase.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script id="tb_Unit" type="text/x-jquery-tmpl">
        <tr id="un_${ID}">
            <td><a href="javascript:getSonData('${ID}','${Name}');">${Name}</a></td>
            <td>
                <input type="button" name="save" class="Topic_btn" value="编辑" onclick="javascript: Save('un_${ID}', '${Name}');" />
                <input type="button" name="delete" class="Topic_btn" value="删除" onclick="javascript: Delete('un_${ID}');" />
            </td>
        </tr>
    </script>

</head>
<body>
    <input type="hidden" id="hid_Id" runat="server" />
    <input type="hidden" id="hid_UserIDCard" runat="server" />
    <input type="hidden" id="hid_LoginName" runat="server" />
    <div class="yy_tab">
        <div class="content">
            <div class="tc">
                <div class="t_message">
                    <table class="W_form" id="tb_CatalogList">
                        <thead>
                            <tr class="trth">
                                <th class="Project_name" style="width: 60%;">类别名称</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
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
    $(document).ready(function () {
        getData();
    });
    //获取数据
    function getData() {
        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
        $("#tb_CatalogList tbody").html('');

        $.ajax({
            url: "../Common.ashx",
            type: "post",
            dataType: "json",
            data: {
                "PageName": "/CourseManage/Course_Catagory.ashx",
                func: "GetData"
            },
            success: function (json) {
                if (json.result.errNum.toString() != "0") {
                    $("#tb_CatalogList tbody").html(html);
                } else {
                    $("#tb_Unit").tmpl(json.result.retData).appendTo("#tb_CatalogList");
                    //隔行变色以及鼠标移动高亮
                    $(".main-bd table tbody tr").mouseover(function () {
                        $(this).addClass("over");
                    }).mouseout(function () {
                        $(this).removeClass("over");
                    })
                    $(".main-bd table tbody tr:odd").addClass("alt");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("#tb_CatalogList tbody").html(html);
            }
        });
    }
    function Add() {
        var trCount = $("#tb_CatalogList tbody").find("tr").length;
        var random = Math.random().toString();
        var randomId = random.substr(2, random.length);
        randomId = "un_" + randomId;

        var tbody = $("#tb_CatalogList tbody");
        if (tbody.text() == "无内容") {
            $(tbody).html(''); trCount = 0;
        }
        $(tbody).append("<tr id='" + randomId + "'><td><input type='text' value='' /></td><td><input type='button' name='save' class='Topic_btn' value='保存' onclick=\"javascript: Save('" + randomId + "','');\" /></td></tr>");
    }
    function Save(id, name) {
        var tds = $("#" + id).find("td");
        var btnsave = $(tds).eq(1).find("input[name='save']");
        if (btnsave.val() == "保存") {
            var newname = $(tds).eq(0).find("input").val();
            if (newname != "") {
                id = id.substr(3, id.length);
                var fun = "EditCatatory";
                if (name == "") {
                    fun = "AddCatatory";
                }
                if (name != newname) { //更改或添加
                    $.ajax({
                        url: "../Common.ashx",
                        type: "post",
                        dataType: "json",
                        data: { "PageName": "/CourseManage/Course_Catagory.ashx", func: fun, Id: id, Name: newname },

                        success: function (json) {
                            if (json.result.errNum.toString() == "0") {
                                if (name == "") { //如果新添加则应改id为新加项的id
                                    id = json.result.retData;
                                }
                                newname = "<a href=\"javascript:Save('un_" + id + "'', '" + name + "');\">" + newname + "</a>";
                            }
                            else {
                                getData();
                                layerMsg(json.result.errMsg);
                            }
                        }
                    });
                }
                else { //还原
                    newname = "<a href=\"javascript:Save('un_" + id + "'', '" + name + "');\">" + name + "</a>";
                }
                $(tds).eq(0).html(newname);
                btnsave.val("编辑");
            }
        }
        else {
            var oldname = $(tds).eq(0).text();
            $(tds).eq(0).html("<input type='text' value='" + oldname + "' />");
            btnsave.val("保存");
        }
    }

    function Delete(id) {
        var caid = id.substr(3, id.length);
        $.ajax({
            url: "../Common.ashx",
            type: "get",
            async: false,
            dataType: "json",
            data: { "PageName": "/CourseManage/Course_Catagory.ashx", func: "DelCatatory", ID: caid },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    getData();
                }
                else {
                    layer.msg(json.result.errMsg);
                }
            }
        });
    }
</script>
</html>
