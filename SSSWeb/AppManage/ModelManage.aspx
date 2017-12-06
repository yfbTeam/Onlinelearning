<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModelManage.aspx.cs" Inherits="SSSWeb.AppManage.ModelManage" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />

    <title>模块管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />
    <link href="../ZZSX/css/iconfont.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <link href="../Scripts/jquery-treetable-3.1.0-0/stylesheets/jquery.treetable.css" rel="stylesheet" />
    <link href="../Scripts/jquery-treetable-3.1.0-0/stylesheets/jquery.treetable.theme.default.css" rel="stylesheet" />
    <script src="../Scripts/jquery-treetable-3.1.0-0/vendor/jquery-ui.js"></script>
    <script src="../Scripts/jquery-treetable-3.1.0-0/javascripts/src/jquery.treetable.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <style>
        #table_tree thead tr th {
            height: 40px;
            background: #eef5fd;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #d0ebff;
            font-size: 14px;
            color: #777;
        }

        table.treetable tbody tr td {
            height: 32px;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #d0ebff;
            font-size: 14px;
            color: #888;
            position: relative;
        }

            table.treetable tbody tr td:first-child {
                text-align: left;
                padding-left: 70px;
            }

            table.treetable tbody tr td .setings {
                position: absolute;
                top: -18px;
                right: -18px;
                transform: rotate(225deg);
                border: 18px solid #91c954;
                width: 0px;
                height: 0px;
                border-color: #91c954 transparent transparent transparent;
                z-index: 9999;
                cursor: pointer;
            }

                table.treetable tbody tr td .setings .iconfont {
                    color: #fff;
                    font-size: 13px;
                    position: absolute;
                    bottom: 5px;
                    left: -7px;
                }

            table.treetable tbody tr td .setting_none {
                display: none;
                z-index: 999;
                position: absolute;
                right: -80px;
                top: 0;
                width: 78px;
                border: 1px solid #DEEFCB;
            }

                table.treetable tbody tr td .setting_none a {
                    display: block;
                    text-align: center;
                    width: 100%;
                    height: 29px;
                    border-bottom: 1px solid #DEEFCB;
                    background: #fff;
                    line-height: 29px;
                    color: #777777;
                    font-size: 14px;
                }

                    table.treetable tbody tr td .setting_none a:hover {
                        background: #91c954;
                        color: #fff;
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
                <a class="logo fl" href="../AppManage/Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/mokuaiguanli.png" />
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
                                    <img src="<%=UserInfo.AbsHeadPic%>" />
                                </div>
                                <h2><%=UserInfo.Name%></h2>
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
                        <%--<a href="../AppManage/ModelCatogry.aspx" class="newcourse" target="_blank">分类管理
                        </a>--%>
                        <%--<a href="javascript:;" class="newcourse" onclick="AddModol()" id="icon-plus">
                            <i class="icon icon-plus"></i>新建模块
                        </a>--%>
                    </div>
                </div>
                <%--<div class="wrap">
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
                </div>--%>
                <div id="div_table"></div>

                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                </div>
            </div>
        </div>
        <footer id="footer"></footer>
    </form>
</body>
<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">
    $(function () {
        SetPageButton('<%=UserInfo.UniqueNo%>')

        $('#footer').load('../footer.html');
        CatoryModel();
        getData(1, 10);
    });
    function CatoryModel() {
        $("#ModelType").html("<option value=''>==请选择==</option>");
        $.ajax({
            url: "../Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
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
    var menu_list = [];
    function getData(startIndex, pageSize) {
        var ModelType = $("#ModelType").val();
        $("#div_table").html('<table id="table_tree"><thead><tr><th style="width: 45%">导航名称</th><th style="width: 55%;">URL</th></tr></thead><tbody id="tb_list" style="background:#ffffff;"><tr data-tt-id="0" data-tt-parent-id="null"><td>全部<div btncls="icon-setting"  class="setings" onclick="AddModol(0,0);"><i class="iconfont" style="transform:rotate(-45deg)">&#xf000e;</i></div></td><td></td></tr></tbody></table>');
        $.ajax({
            url: "../Hander/ModelHander.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "Func": "GetModelList", Ispage: "false", "ModelType": ModelType
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    var html = '';
                    menu_list = json.result.retData;
                    BindMenu(0);
                    $("#table_tree").treetable({ expandable: true });
                    $('table.treetable tbody tr').find('.setings').click(function () {
                        if ($(this).next().is(':hidden')) {
                            $('table.treetable tbody tr').find('.setting_none').hide();
                            $(this).next().show();
                            $(this).next().mouseleave(function () {
                                $(this).hide();
                            });
                        } else {
                            $(this).next().hide();
                        }
                    })
                }
                else {
                    $("#tb_list").html("<tr><td colspan='2' style='text-align:center;'>暂无模块！</td></tr>");
                    $("#table_tree").treetable({ expandable: true });
                }
            },
            error: function (errMsg) {
                $("#tb_list").html("<tr><td colspan='2' style='text-align:center;'>暂无模块！</td></tr>");
                $("#table_tree").treetable({ expandable: true });
            }
        });
    }
    function BindMenu(parentid) {
        for (var menu in menu_list) {
            var curmenu = menu_list[menu];
            if (curmenu.Pid == parentid) {
                var mtr = '<tr data-tt-id=' + curmenu.ID + ' data-tt-parent-id=' + (curmenu.Pid == 0 ? null : curmenu.Pid) + '><td>' + curmenu.ModelName
                    + '<div btncls="icon-setting" class="setings"><i class="iconfont">&#xe6bd;</i></div><div class="setting_none">' +
                    (curmenu.IsMenu.toString().toUpperCase() == "TRUE" ? '' : '<a href="javascript:;" onclick="AddModol(0,' + curmenu.ID + ');">添加</a>') + '<a href="javascript:;" onclick="EditModol(' + curmenu.ID +
                    ');">编辑</a><a href="javascript:;" onclick="DelModol(' + curmenu.ID + ');">删除</a></div></td><td>' + curmenu.LinkUrl + '</td></tr>';
                $('#tb_list').append(mtr);
                if (curmenu.ChildCount > 0) {
                    BindMenu(curmenu.ID);
                }
            }
        }
    }
    /*function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        var ModelType = $("#ModelType").val();

        $.ajax({
            url: "../Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
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
                    var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_Manage").html(html);

                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    */
    //添加模块
    function AddModol(itemid, pid) {
        OpenIFrameWindow('添加模块', 'ModelAdd.aspx?Pid=' + pid, '360px', '440px');
    }
    //修改模块
    function EditModol(id) {
        OpenIFrameWindow('修改模块', 'ModelAdd.aspx?ID=' + id, '360px', '440px');
    }
    function DelModol(ID) {
        if (confirm("确定要删除模块吗？")) {
            $.ajax({
                url: "../Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
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
