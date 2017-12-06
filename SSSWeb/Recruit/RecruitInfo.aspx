<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecruitInfo.aspx.cs" Inherits="SSSWeb.Recruit.RecruitInfo" %>

<!DOCTYPE html>


<html>
<head>
    <meta charset="utf-8" />
    <title>招生信息</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }

        .qijin {
            display: inline-block;
            border-radius: 15px;
            background: #E6E6E6;
            cursor: pointer;
        }

            .qijin span.Enable.active {
                background: #96cc66;
            }

            .qijin span {
                padding: 6px 10px;
                border-radius: 15px;
                display: inline-block;
                color: #fff;
            }

                .qijin span.Disable.active {
                    background: #F77B74;
                }

        .hot1 {
            display: inline-block;
            width: 17px;
            height: 17px;
            background: url(../ZZSX/images/hot1.png) no-repeat;
        }

        .hot2 {
            display: inline-block;
            width: 25px;
            height: 17px;
            background: url(../ZZSX/images/hot2.png) no-repeat;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td>${Name}</td>
            <td>${DateTimeConvert(BeginTime,"yyyy-MM-dd")}</td>
            <td>${DateTimeConvert(EndTime,"yyyy-MM-dd")}</td>
            <td>${HotLine}</td>
            <td>${EnrollmentPlan}</td>
            <td>${EnrollMents}</td>
            <td>
                <div class="qijin">
                    {{if Status==1}}
                    <span class="Enable active">启用</span><span class="Disable" onclick="ChangeStatus(0,${ID})">禁用</span>
                    {{else}}<span class="Enable" onclick="ChangeStatus(1,${ID})">启用</span><span class="Disable active">禁用</span>
                    {{/if}}
                </div>
            </td>
            <td>
                <a href="javascript:;" onclick="Edit(${ID})">修改</a>
                <a href="javascript:;" onclick="Del(${ID})">删除</a>
                <a href="javascript:;" onclick="javascript:OpenIFrameWindow('报名', 'Recruit_StuSin.aspx?InfoNo=${InfoNo}', '700px', '600px');">报名</a>

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

        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">

                <div class="newcourse_select clearfix" id="CourseSel">

                    <div class="stytem_select_right fl" style="margin-left: 10px;">

                        <div class="search_exam fl pr">

                            <input type="text" name="" id="Name" value="" placeholder="请输关键字">
                            <i class="icon  icon-search" onclick="getData(1,10)"></i>
                        </div>
                    </div>
                    <div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" onclick="javascript:OpenIFrameWindow('发布招生信息', 'Recruit_Add.aspx', '700px', '600px');">发布招生信息</a>

                    </div>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th>名称</th>
                            <th>开始时间</th>
                            <th>截止时间</th>
                            <th>热线</th>
                            <th>招生计划</th>
                            <th>分数线</th>
                            <th>状态</th>
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
        <footer id="footer"></footer>
    </form>
</body>
<script type="text/javascript" src="../js/common.js"></script>
<script>
    var UrlDate = new GetUrlDate();

</script>
<script type="text/javascript">
    $(document).ready(function () {
        //SetPageButton('<%=UserInfo.UniqueNo%>')
        $('#footer').load('../footer.html');
        getData(1, 10);
    });
    function ChangeStatus(status, id) {
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            dataType: "json",
            data: { PageName: "Recruit/RecruitHandler.ashx", Func: "ChangeStatus", Status: status, ID: id },
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

    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "Recruit/RecruitHandler.ashx", "Func": "GetPageList",
                PageIndex: startIndex, pageSize: pageSize, "Name": $("#Name").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(".page").show();
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
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

    //修改菜单
    function Edit(id) {
        OpenIFrameWindow('修改招生计划', 'Recruit_Add.aspx?ID=' + id, '630px', '540px');
    }

    function Del(ID) {
        if (confirm("确定要删招生信息吗？")) {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "Recruit/RecruitHandler.ashx", "Func": "Del", ID: ID
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
