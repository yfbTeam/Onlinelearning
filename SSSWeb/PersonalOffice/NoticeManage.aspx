<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeManage.aspx.cs" Inherits="SSSWeb.PersonalOffice.NoticeManage" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>通知公告</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Common.js?parm=5.0"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <%--<script src="/CourseManage/Term.js"></script>--%>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td class="checkradio pr">
                <input type="checkbox" name="Check_box" value="${ID}" />
                <input type="hidden" id="HID" value="${ID}" />
            </td>
            <td title="${Content}">${Title}</td>
            <%--<td>${CatagoryName} </td>--%>
            <td>${CreateName}</td>
            <td>${DateTimeConvert(CreateTime,"yyyy-MM-dd")}
            </td>
            <td>
                <a href="javascript:;" style="display: none;" onclick="javascript:OpenIFrameWindow('编辑通知', 'AddNotice.aspx?ID=${ID}', '800px', '540px');" btncls="icon-edit">修改</a>
                <a href="javascript:;" style="display: none;" onclick="Del(${ID})" btncls="icon-del">删除</a>
                <a href="javascript:;"  onclick="javascript:OpenIFrameWindow('查看通知', 'ShowNotice.aspx?ID=${ID}', '800px', '540px');">查看</a>

            </td>
        </tr>
    </script>

</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo%>" />
    <input type="hidden" id="HUserName" value="<%=UserInfo.Name %>" />
    <input type="hidden" id="HPId" />
    <form id="form1" runat="server">
        <input id="option" type="hidden" value=">" />
        <!--header-->

        <div class="onlinetest_item width">
            <div class="course_manage bordshadrad">
                <%--<div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on" onclick="History('>',this)">当前课程</a>
                        <a href="javascript:;" onclick="History('<',this)">历史课程</a>
                        <a href="javascript:;" onclick="History('',this)">模版管理</a>
                    </div>
                </div>--%>
                <div class="newcourse_select clearfix" id="CourseSel">

                    <%--<div class="stytem_select_right fl" style="margin-left: 10px;">

                        <div class="search_exam fl pr">
                            <select name="" class="select" id="CourseType" onchange="getData(1, 10)" style="height: 30px; margin: 0px 5px">
                               
                            </select>
                            <input type="text" name="" id="CourseName" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="getData(1,10)"></i>
                        </div>
                    </div>--%>
                    <div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" btncls="icon-plus" style="display: none" onclick="javascript:OpenIFrameWindow('新增通知', '/PersonalOffice/AddNotice.aspx', '830px', '580px');">
                            <i class="icon icon-plus"></i>新增
                        </a>
                        <a href="javascript:;" btncls="icon-del" class="newcourse" style="display: none" btncls="icon-del" onclick="Del('')">
                            <i class="icon icon-trash"></i>删除
                        </a>
                    </div>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th class="pr checkall" style="width: 60px;">
                                <input type="checkbox" name="checkbox" id="checkbox" />
                            </th>
                            <th>标题</th>
                            <%--<th>分类</th>--%>
                            <th>发布人</th>
                            <th>发布时间</th>
                            <th>操作</th>
                        </thead>
                        <tbody id="tb_Manage">
                        </tbody>
                    </table>

                </div>
                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                </div>
            </div>
        </div>
        <footer id="footer" class="none"></footer>
    </form>
</body>
<script type="text/javascript" src="../js/common.js"></script>
<script>
    var UrlDate = new GetUrlDate();
    $(function () {
        SetPageButton('<%=UserInfo.UniqueNo%>', 'a')
        //$('#footer').load('../footer.html');
        //选择所有checkbox
        $('.checkall>input').click(function () {
            if ($(this).is(':checked')) {
                $('.checkradio>input').prop('checked', true);
            } else {
                $('.checkradio>input').prop('checked', false);
            }
        })

        getData(1, 10);
    });
    function Del(ID) {

        var ids = "";
        if (ID == "") {
            $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    ids += this.value + ",";
                }
            });
            ids = ids.substring(0, ids.length - 1);
        }
        else {
            ids = ID;
        }

        if (ids == "") {
            layer.msg("请选择要删除的资源!");
        }
        else {

            if (confirm("确定要执行删除操作？")) {

                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "SystemSettings/NoticeManage.ashx", "Func": "DelNotice", ID: ids
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {

                            getData(1, 10);
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
    }
    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        //初始化序号 
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "SystemSettings/NoticeManage.ashx", "Func": "GetData", PageIndex: startIndex, pageSize: pageSize
                , CreateUID: '<%=UserInfo.UniqueNo%>', Org: '<%=UserInfo.RegisterOrg%>', UserNo: '<%=UserInfo.UniqueNo%>'
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(".page").show();
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    SetPageButton("<%=UserInfo.UniqueNo%>", 'a');
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_Manage").html(html);
                    $(".page").hide();
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
</script>
</html>
