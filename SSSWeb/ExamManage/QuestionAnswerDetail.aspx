<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuestionAnswerDetail.aspx.cs" Inherits="SSSWeb.ExamManage.QuestionAnswerDetail" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>错题分析</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />

    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/echarts.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="/CourseMenu.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="/CourseManage/Term.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }

        td {
            background: #ffffff;
            border: solid 1px #266cb8;
            height: 50px;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td onclick="CourceDetail(${ID});">${QuestionName}</td>
            <td>${答题人数}</td>

            <td>${得分率}</td>
            <td>
                <a href="javascript:;" onclick="ShowDetail(${QuestionID})">详细信息</a>
            </td>
        </tr>
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo %>" />
        <input id="ExamID" type="hidden" value="" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../AppManage/Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/testsystem.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul id="Menu">
                        <li currentclass="active"><a href="ExamQManager.aspx">题库管理</a></li>
                        <li currentclass="active"><a href="ExamManager.aspx">试卷管理</a></li>
                        <li currentclass="active"><a href="MyExam.aspx">我的试卷</a></li>
                        <li class="active"><a href="ExamAnalisy.aspx">统计分析</a></li>
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
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="ExamAnalisy.aspx">成绩分析</a>
                        <a href="javascript:;" class="on">错题分析</a>
                    </div>
                </div>
                <div class="newcourse_select clearfix" id="CourseSel">
                    <div class="clearfix fl course_select">
                        <select name="" class="select" id="ExamPaper" onchange="getData()">
                        </select>
                        <select id="Grade" class="select" onchange="GradSelChange()">
                            <option value="0">==请选择年级==</option>
                        </select>
                        <select name="" class="select" id="Class">
                            <option value="0">==请选择班级==</option>
                        </select>
                    </div>
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th class="pr checkall">试题内容</th>
                            <th>答题人数</th>
                            <th>正确率</th>
                            <th>操作</th>
                        </thead>
                        <tbody id="tb_Manage">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--分页-->
        <%--<div class="page">
            <span id="pageBar"></span>
        </div>--%>
    </form>
</body>
<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">
    function ShowDetail(Qid) {
        OpenIFrameWindow('答题详情', 'AnswerDetail.aspx?Qid=' + Qid, '600px', '540px');
    }
    $(function () {

         GetSameLiveMenu("ExamManage/ExamAnalisy.aspx", '<%=UserInfo.UniqueNo%>', '');
       
        GetExam();
        GetGrade();
        getData();
    });

    //获取数据
    function getData() {
        //初始化序号 
        //pageNum = (startIndex - 1) * pageSize + 1;

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/AnaliseHander.ashx", "action": "AnaliseQuestionScore", ExamID: $("#ExamPaper").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(".page").show();
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData).appendTo("#tb_Manage");
                    //ButtonList($("#HPId").val());
                    //makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
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
    }

    function GetExam() { //初始化序号 
        $("#ExamPaper").html('');//<option value="0">==请选择年级==</option>');
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            async: false,
            data: {
                PageName: "/ExamManage/PaperHandler.ashx",
                "action": "GetExamPaperDataPage",
                IsPage: "false",
                //"Status": 2
            },
            success: function (json) {
                var i = 0;
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        if (i == 0) {
                            $("#ExamPaper").append("<option value='" + this.Id + "' selected='selected'>" + this.Title + "</option>");

                            i++;
                        }
                        else {
                            $("#ExamPaper").append("<option value='" + this.Id + "'>" + this.Title + "</option>");
                            i++;
                        }
                    })
                }
                else {
                    layer.msg(json.result.errMsg);
                }

            },
        });
    }
    var jsonClass = [];
    //年级
    function GetGrade() {
        var option = '<option value="0">==请选择年级==</option>';
        //$("#Grade").html('<option value="0">==请选择年级==</option>');
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            async: "false",
            data: { Func: "GetGradeClass" },
            success: function (json) {

                //var j = 0;
                if (json.result.errNum.toString() == "0") {
                    var resultData = eval(json.result.retData);
                    jsonClass = resultData;
                    $(resultData).each(function () {
                        option += "<option value='" + this.id + "'>" + this.name + "</option>";
                        //if (j == 0) {
                        //$("#Grade").append("<option value='" + this.id + ">" + this.name + "</option>");
                        //BindClass();
                        //j++;
                        //}
                        //else {
                        //    $("#Grade").append("<option value='" + this.id + "'>" + this.name + "</option>");
                        //    j++;
                        //}
                    })
                    $("#Grade").html(option);
                }
                else {
                    layer.msg(json.result.errMsg);
                }
                //$("#Grade").append(option);
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function GradSelChange() {
        BindClass();
    }

    function BindClass() {
        $("#Class").html('<option value="0">==请选择班级==</option>');
        //if (jsonClass.result.errNum.toString() == "0") {
        var GradeID = $("#Grade").val();//.children('span').attr("value").trim()
        var k = 0;
        $(jsonClass).each(function () {
            if (this.id == GradeID) {
                $.each(this.children, function () {
                    //if (k == 0) {
                    $("#Class").append("<option value='" + this.id + "'>" + this.name + "</option>");
                    //    k++;
                    //}
                    //else {
                    //    $("#Class").append("<option value='" + this.id + "'>" + this.name + "</option>");
                    //    k++;
                    //}
                })
            }
        });
        //}
        //else {
        //        layer.msg(json.result.errMsg);
        //}
    }
</script>
</html>
