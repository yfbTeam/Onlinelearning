<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TextbookVersionManager.aspx.cs" Inherits="SSSWeb.ResourceManage.TextbookVersionManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>教材版本管理</title>
    <link href="../css/stylebase.css" rel="stylesheet" />
    <link href="../css/commonbase.css" rel="stylesheet" />
    <link href="../css/iconfont.css" rel="stylesheet" />
    <link href="../css/animate.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Name}</td>
            <td>${CreateTime}</td>
            <td>
                <input type="button" class="Topic_btn" value="删除" onclick="Delete('${ID}')" />
            </td>
        </tr>

    </script>
</head>
<body>
    <input type="hidden" id="hid_UserIDCard" runat="server" />
    <input type="hidden" id="hid_LoginName" runat="server" />
    <form id="form1" runat="server">
        <div class="Teaching_plan_management">
            <%--<h1 class="Page_name">教材版本信息列表</h1>--%>
            <div class="Operation_area">
                <%--<div class="left_choice fl">
                    <ul>
                        <li class="Sear">
                            <input type="text" id="Name" name="search_w" class="search_w" placeholder="请输入名称" value="" /><a class="sea" href="#" onclick="SearchClass();">搜索</a>
                        </li>
                    </ul>
                </div>--%>
                <div class="right_add fr">
                    <a class="add" href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('新增教材版本','TextbookVersionEdit.aspx', '560px', '200px');"><i class="iconfont">&#xe726;</i>新增教材版本</a>
                </div>
            </div>
            <div class="Honor_management">
                <table class="W_form" id="tb_UserList">
                    <thead>
                        <tr class="trth">
                            <th class="number">序号</th>
                            <th class="Project_name">教材版本名称</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            <!--分页页码开始-->
            <div class="paging none">
                <span id="pageBar"></span>
            </div>
            <!--分页页码结束-->
        </div>
    </form>
</body>
<script type="text/javascript">
    var Name = "";
    $(document).ready(function () {
        //获取数据
        getData();
    });
    function SearchClass() {
        Name = $("#Name").val().trim();
        getData();
    }
    function getData() {
        //初始化序号 
        $.ajax({
            url: "../SystemSettings/EduHander.ashx",
            type: "post",
            dataType: "json",
            data: {
                func: "GetBookVersion",
                IsPage: "false",

            },
            success: OnSuccess,
            error: OnError
        });
    }
    //获取数据
    /*function getData() {
        //初始化序号 
        $.ajax({
            url: "../EduManage/BooKManage.ashx",
            type: "get",
            async: false,
            dataType: "json",
            data: {
                "PageName": "TextbookVersionHandler.ashx",
                func: "GetBookVersion",
                Name: Name,
                IsPage: "false",
            },
            success: OnSuccess,
            error: OnError
        });
    }*/
    function OnSuccess(json) {
        if (json.result.errNum.toString() != "0") {
            $("#tb_UserList tbody").html("<tr><td class='NoContent' colspan='100'>无内容</td></tr>");
            $("#pageBar").hide();
        } else {
            $("#tb_UserList tbody").html('');
            $("#tr_User").tmpl(json.result.retData).appendTo("#tb_UserList");
            //隔行变色以及鼠标移动高亮
            $(".main-bd table tbody tr").mouseover(function () {
                $(this).addClass("over");
            }).mouseout(function () {
                $(this).removeClass("over");
            })
            $(".main-bd table tbody tr:odd").addClass("alt");
            //$("#pageBar").show();
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
            //makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
        }
    }
    function OnError(XMLHttpRequest, textStatus, errorThrown) {
        $("#tb_UserList tbody").html("<tr><td class='NoContent' colspan='100'>无内容</td></tr>");
    }

    function Delete(itemid) {
        layer.msg("确定要删除该接口？", {
            time: 0 //不自动关闭
            , btn: ['确定', '取消']
            , yes: function (index) {
                layer.close(index);
                $.ajax({
                    url: "../SystemSettings/EduHander.ashx",
                    type: "post",
                    dataType: "json",
                    data: {
                        func: "DelBookVersion",
                        Id: itemid,
                    },
                    success: function (json) {
                        getData();
                        //var result = json.result;
                        //if (result.errNum == 0) {
                        //    layer.msg("删除成功！");
                        //    getData();; //刷新列表
                        //} else {
                        //    layer.msg("删除失败！");
                        //}
                    },
                    //error: OnErrorDelete
                });
            }
        });
    }
</script>
</html>

