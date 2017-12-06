<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModelManage.aspx.cs" Inherits="SSSWeb.AppManage.ModelManage" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>模块管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />

    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
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
            <td>${ModelName}</td>
            <td>${CatogryName}</td>
            <td>${LinkUrl}</td>
            <td>{{if OpenType=='_blank'}}新页面
                {{else}}当前面{{/if}}</td>
            <td>${DateTimeConvert(CreateTime,"yyyy-MM-dd")}</td>
            <td>
                <a href="javascript:;" onclick="EditModol(${ID})"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DelModol(${ID})"><i class="icon icon-trash"></i>删除</a>
        </tr>
    </script>

</head>
<body>

    <form id="form1" runat="server">
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/AppManage/Index.aspx">
                    <img src="/images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="/images/mokuaiguanli.png" />
                </div>
                <nav class="navbar menu_mid fl">

                    <ul id="CourceMenu">
                    </ul>
                </nav>
                <div class="search_account fr clearfix">
                    <ul class="account_area fl">

                        <li>
                            <a href="javascript:;" class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=UserInfo.AbsHeadPic %>" />
                                </div>
                                <h2><%=UserInfo.Name %></h2>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr ">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">

                <div class="newcourse_select clearfix" id="CourseSel">
                    <div class="clearfix fl course_select">
                        <label for="">模块分类：</label>
                        <select name="" class="select" id="ModelType" onchange="getData(1, 10)">
                        </select>
                    </div>

                    <div class="stytem_select_right fr">
                        <a href="/AppManage/ModelCatogry.aspx" class="newcourse" target="_blank">分类管理
                        </a>
                        <a href="javascript:;" class="newcourse" onclick="AddModol()" id="icon-plus">
                            <i class="icon icon-plus"></i>新建模块
                        </a>
                    </div>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th class="pr checkall">模块名称</th>
                            <th>所属分类</th>
                            <th>链接地址</th>
                            <th>打开方式</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </thead>
                        <tbody id="tb_Manage">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
    </form>
</body>
<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">
    $(function () {
        CatoryModel();
        getData(1, 10);
    });
    function CatoryModel() {
        $("#ModelType").html("<option value=''>==请选择==</option>");
        $.ajax({
            url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "ModelCatogory", Status: "1" },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        $("#ModelType").append("<option value='" + this.ID + "'>" + this.Name + "</option>");
                    })
                }
                else {
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        var ModelType = $("#ModelType").val();

        $.ajax({
            url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "CourseManage/CourceManage.ashx", "Func": "GetModelList", PageIndex: startIndex, pageSize: pageSize, Ispage: "true", "ModelType": ModelType
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background:#fff url(/images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_Manage").html(html);

                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }

    //添加课程
    function AddModol() {
        OpenIFrameWindow('添加模块', '/AppManage/ModelAdd.aspx', '380px', '680px');
    }
    //修改课程
    function EditModol(id) {
        OpenIFrameWindow('修改模块', '/AppManage/ModelAdd.aspx?ID=' + id, '380px', '680px');
    }
    function DelModol(ID) {
        if (confirm("确定要删除模块吗？")) {
            $.ajax({
                url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "Func": "DelModel", ID: ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("删除成功！");
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

</script>
</html>
