<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourceManage.aspx.cs" Inherits="SSSWeb.CourseManage.CourceManage" %>

<!DOCTYPE html>


<html>
<head>
    <meta charset="utf-8" />
    <title>课程管理</title>
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
<%--    <script src="Term.js"></script>
    <script src="/CourseMenu.js"></script>--%>
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
            <td class="checkradio pr" style="cursor: pointer; color: #555; text-decoration: underline;" onclick="CourceDetail(${ID});">${Name}</td>
            <td>${CatogaryName}
            
            </td>
            <td>${StatusName}</td>
            <%-- {{if Status==0}}<td class="noverified">待审核</td>
            {{else}}{{if Status==2}}<td class="noverified">审核失败</td>
            {{else}}<td class="verified">审核通过</td>
            {{/if}}{{/if}}--%>

            <td>${DateTimeConvert(CreateTime,"yyyy-MM-dd")}</td>
            <td>
                <a href="javascript:;"  style="display:none;"onclick="EditCource(${ID})" btncls="icon-edit">基本信息</a>
                <a href="javascript:;" style="display:none;" onclick="DelCource(${ID})" btncls="icon-del">删除课程</a>
                <a href="javascript:;" style="display:none;" onclick="CourceDetail(${ID})" btncls="icon-edit">课程内容</a>
                <a href="javascript:;" style="display:none;" onclick="AppointRoom(${ID},${Status})" btncls="icon-appintroom">预约教室</a>
                <a href="javascript:;" style="display:none;" onclick="ReleaseCource(${ID},'${Name}',${Status})" btncls="icon-releasecourse">发布课程</a>
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
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../AppManage/Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/coursesystem.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul>
                        <li class="active"><a href="#">课程管理</a></li>
                        <li><a href="StuManage.aspx?Type=1">进度查看</a></li>
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
                <%--<div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on" onclick="History('>',this)">当前课程</a>
                        <a href="javascript:;" onclick="History('<',this)">历史课程</a>
                        <a href="javascript:;" onclick="History('',this)">模版管理</a>
                    </div>
                </div>--%>
                <div class="newcourse_select clearfix" id="CourseSel">

                    <div class="stytem_select_right fl" style="margin-left: 10px;">

                        <div class="search_exam fl pr">
                            <select name="" class="select" id="CourseType" onchange="getData(1, 10)" style="height: 30px; margin: 0px 5px">
                            </select>
                            <input type="text" name="" id="CourseName" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="getData(1,10)"></i>
                        </div>
                    </div>
                    <div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse none"  btncls="icon-coursecatogory"  onclick="javascript:OpenIFrameWindow('分类管理', 'CourceCatogry.aspx', '500px', '270px');">分类管理
                        </a>
                        <a href="javascript:;" class="newcourse none"  btncls="icon-plus" onclick="javascript:OpenIFrameWindow('新建课程', 'CourceAdd_MTG.aspx', '700px', '600px');">新建课程
                        </a>
                        <a href="javascript:;" class="newcourse none" btncls="icon-weekset" onclick="javascript:OpenIFrameWindow('选课周设置', 'CourceSelTimeSet.aspx', '600px', '540px');">选课周设置
                        </a>
                    </div>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th class="pr checkall">课程名称</th>
                            <th>课程分类</th>
                            <th>课程状态</th>
                            <th>创建时间</th>
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

    $(function () {
        SetPageButton('<%=UserInfo.UniqueNo%>')
        $('#footer').load('../footer.html');
        BindCourseCatagory();
        getData(1, 10);
        //GetTerm();
    });
    //预约教室
    //when 0 then '初始化' when 2 then '创建完成' when 3 then '教室预约中'  when 4 then '教室预约成功' when 5 then '教室预约失败' when 1 then '课程已发布'
    function AppointRoom(ID, status) {
        if (status == 0) {
            layer.msg("请先完善课程资料");
        }
        else if (status == 2 || status == 5) {
            OpenIFrameWindow("预约教室", "../ResourceReservations/BookingCar.aspx?CourseAppoint=" + ID, "800px", "800px");
        }
        else if (status == 3) {
            layer.msg("教室预约中，请等待审核")
        }
        else if (status == 4) {
            layer.msg("已预约教室，不需要重复预约")
        }
        else if (status == 1) {
            layer.msg("课程已经发布，不可以再预约教室");
        }
    }
    //发布课程
    function ReleaseCource(ID, Name, status) {
        if (status == 0) {
            layer.msg("请先完善课程资料");
        }
        else if (status == 2) {
            layer.msg("请先完善课程资料");
        }
        else if (status == 3 || status == 5) {
            layer.msg("教室尚未预约成功，不可以发布课程")
        }
        else if (status == 4) {
            OpenIFrameWindow("发布课程", "ReleaseCourse.aspx?ID=" + ID + "&Name=" + encodeURI(Name), "800px", "800px")
        }
        else if (status == 1) {
            layer.msg("课程已经发布，不需要重新发布");
        }
    }
    function BindCourseCatagory() {
        $("#CourseType").html("<option value=''>==课程分类==</option>");
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            dataType: "json",
            data: { PageName: "/CourseManage/Course_Catagory.ashx", Func: "GetData", },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        var option = "<option value='" + this.ID + "'>" + this.Name + "</option>";
                        $("#CourseType").append(option);
                    });
                }
                else {
                    //$("#Catagory").html("暂无证书模板！");
                }
            },
            error: function (errMsg) {
                // $("#Certificate").html(errMsg);
            }
        });
    }
    function CourceDetail(ID) {
        window.location.href = 'CourseDetail.aspx?itemid=' + ID + "&Type=1";// + "&PageName=" + UrlDate.PageName;
    }
    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        //var StudyTerm = $("#StudyTerm").val();

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", CreateUID: $("#HUserIdCard").val(),
                PageIndex: startIndex, pageSize: pageSize, "Name": $("#CourseName").val(), "CourseType": $("#CourseType").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(".page").show();
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                    //ButtonList($("#HPId").val());
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_Manage").html(html);
                    $(".page").hide();
                    //layer.msg(json.result.errMsg);
                }
                //checkAll($('#Course input[type=checkbox]'));
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
        SetPageButton('<%=UserInfo.UniqueNo%>','','a')
    }


    //修改课程
    function EditCource(id) {
        OpenIFrameWindow('修改课程', 'CourceAdd_MTG.aspx?ID=' + id, '630px', '540px');
    }

    function History(option, em) {
        $(em).addClass("on").siblings().removeClass("on");
        if (option != "") {
            $("#tb_Modol").children().remove();
            $("#Course").show();
            $("#Modol").hide();
            $("#option").val(option);
            getData(1, 10);
            $("#CourseSel").show();
        }
        else {
            $("#tb_Manage").children().remove();
            //BindModol(1, 10);
            $("#Course").hide();
            $("#Modol").show();
            $("#CourseSel").hide();
        }
    }
    //人员调整
    function StuAdjust(id) {
        window.location.href = 'personnel_allotment.aspx?ID=' + id;// + "&PageName=" + UrlDate.PageName;
    }
    function Modol(id) {
        OpenIFrameWindow('生成模版', 'ModolAdd.aspx?CourceID=' + id, '330px', '300px');

    }
    /* function AddCourseByModol(id) {
         OpenIFrameWindow('生成课程', 'AddCourseByModol.aspx?ModolID=' + id, '330px', '300px');
     }*/
    function DelCource(ID) {
        if (confirm("确定要删除课程吗？")) {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "CourseManage/CourceManage.ashx", "Func": "DelCourse", ID: ID, IdCard: $("#HUserIdCard").val()
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
    function ExportCource(ID) { }
</script>
</html>

