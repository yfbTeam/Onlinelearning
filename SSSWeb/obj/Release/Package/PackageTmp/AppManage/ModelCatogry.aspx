<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModelCatogry.aspx.cs" Inherits="SSSWeb.AppManage.ModelCatogry" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>分类管理</title>
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
            <td>${Name}</td>
            <td>{{if Status==0}}禁用
                {{else}}启用
                {{/if}}</td>
            <td>${SortNum}</td>
            <td>${DateTimeConvert(CreateTime,"yyyy-MM-dd")}</td>
            <td>
                <a href="javascript:;" onclick="EditCatagory(${ID},'${Name}',${Status})"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DelCatagory(${ID})"><i class="icon icon-trash"></i>删除</a>
            </td>
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
                    <img src="/images/fenleiguanli.png" />
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
                    <div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" onclick="AddCatagory()" id="icon-plus">
                            <i class="icon icon-plus"></i>新建分类
                        </a>
                    </div>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th class="pr checkall">类别名称</th>
                            <th>状态</th>
                            <th>排序号</th>
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
    });
    function CatoryModel() {
        $.ajax({
            url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "ModelCatogory" },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData).appendTo("#tb_Manage");
                }
                else {
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }

    //添加课程
    function AddCatagory() {
        OpenIFrameWindow('添加分类', '/AppManage/CatogoryAdd.aspx', '300px', '280px');
    }
    //修改课程
    function EditCatagory(id, name, Status) {
        OpenIFrameWindow('修改分类', '/AppManage/CatogoryAdd.aspx?ID=' + id + '&Name=' + name + '&Status=' + Status, '300px', '280px');
    }
    function DelCatagory(ID) {
        if (confirm("确定要删除模块分类吗？")) {
            $.ajax({
                url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "Func": "DelCatagory", ID: ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("删除成功！");
                        CatoryModel();
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
