<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnswerDetail.aspx.cs" Inherits="SSSWeb.ExamManage.AnswerDetail" %>

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
            <td>${ExamPaperName}</td>
            <td>${QuestionName}</td>
            <td>${TrueAnswer}</td>
            <td>${AllScore}</td>
            <td>${CreateName}</td>
            <td>${MyAnswer}</td>
            <td>${MyScore}</td>
        </tr>
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <%--<input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo %>" />--%>
        <input id="ExamID" type="hidden" value="" />
        <!--header-->

        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">

                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th class="pr checkall">试卷名称</th>
                            <th>试题名称</th>
                            <th>正确答案</th>
                            <th>试题分数</th>
                            <th>答题人</th>
                            <th>答案</th>
                            <th>得分</th>
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

    $(function () {
        getData();
    });
    var UrlDate = new GetUrlDate();
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
                PageName: "/ExamManage/AnaliseHander.ashx", "action": "QuestionScoreDetail", QID: UrlDate.Qid
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
</script>
</html>
