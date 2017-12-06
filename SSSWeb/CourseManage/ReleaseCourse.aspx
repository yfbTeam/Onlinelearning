<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReleaseCourse.aspx.cs" Inherits="SSSWeb.CourseManage.ReleaseCourse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>发布课程</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js"></script>

    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="newtest_detail">
            <div class="newtest_title clearfix">
                <p class="newtest_name"><span>课程名称：</span><span id="content"></span></p>
                <div class="newtest_starttime fl clearfix">
                    <label for="">报名开始时间：</label>
                    <span class="fl pr">
                        <input id="startime" class="Wdate fl" type="text" placeholder="选择日期" value="" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
                    </span>
                    <i class="star"></i>
                </div>
                <div class="newtest_startend fl clearfix">
                    <label for="">报名结束时间：</label>
                    <span class="fl pr">
                        <input id="endtime" class="Wdate fl" type="text" placeholder="选择日期" value="" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
                    </span>
                    <i class="star"></i>
                </div>
            </div>
            <%--            <div class="newtest_class" id="evaluated"></div>
            <div class="newtest_class" id="teacher"></div>--%>
            <div class="newtest_class" id="GetGrade"></div>
            <div style="margin: 0 auto; width: 246px;" class="clearfix">
                <input type="button" value="确认发布" class="btn fl " onclick="Save()" />
                <%--<input type="button" value="取消发布" class="btn fl" onclick="nokeep()" style="margin-left: 10px;" />--%>
            </div>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    var UrlDate = new GetUrlDate();
    $(function () {
        $("#content").html(decodeURI(UrlDate.Name));
        GetGradeClass();
    })


    //获取班级年级数据
    function GetGradeClass() {
        var html = "";
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "GetGradeClass" },
            success: function (json) {
                html += "<p>选择参加考试班级</p>";
                var resultData = eval(json.result.retData);

                $.each(resultData, function () {
                    html += '<div class="clearfix" style="padding:5px 0px;margin-bottom:10px;border:1px solid #ccc;">'
                    html += '<div class="fl" style="width:70px;line-height:20px;font-size:14px;text-align:center;border-right:1px solid #ccc;"> ' + this.name + '</div>';
                    html += '<div class="class_select fl" style="width:">';
                    $.each(this.children, function () {
                        html += "<span style='margin-left:10px;'><input id=\"rdoOpA\" name=\"classid\" type=\"checkbox\" value=\"" + this.id + "\" />" + this.name + "</span>";

                    })
                    html += '</div></div>';
                    $("#GetGrade").html(html);
                });

            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }

    //课程发布
    function Save() {

        var cid = "";
        var startime = $("#startime").val();
        var endtime = $("#endtime").val();

        $("input[name='classid']:checked").each(function () {
            cid += $(this).val() + ",";
        });
        if (!startime || !endtime) {
            layer.msg("请设置开始时间和结束时间");
        }
        else {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/CourseManage/CourceManage.ashx",
                    "Func": "RealeseCourse", "ID": UrlDate.ID, "StartTime": startime, "EndTime": endtime, "Classes": cid
                },
                success: function (json) {
                    if (json.result.retData != "") {
                        parent.layer.msg("发布成功");
                        parent.getData(1, 10);
                        parent.CloseIFrameWindow();
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                }
            });
        }
    }
    //function nokeep() {
    //    parent.location.href = "ExamManager.aspx?ParentID=19";
    //}
</script>
