<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReleaseExam.aspx.cs" Inherits="SSSWeb.ExamManage.ReleaseExam" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>试卷管理</title>
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
        <asp:HiddenField ID="name" runat="server" />
        <asp:HiddenField ID="QID" runat="server" />
        <asp:HiddenField ID="hIDCard" runat="server" />
        <asp:HiddenField ID="qtype" runat="server" />
        <div class="newtest_detail">
            <div class="newtest_title clearfix">
                <p class="newtest_name"><span>试卷名称：</span><span id="content"></span></p>
                <div class="newtest_starttime fl clearfix">
                    <label for="">试卷有效开始时间：</label>
                    <span class="fl pr">
                        <input id="startime" class="Wdate fl" type="text" placeholder="选择日期" value="" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
                    </span>
                    <i class="star"></i>
                </div>
                <div class="newtest_startend fl clearfix">
                    <label for="">试卷有效结束时间：</label>
                    <span class="fl pr">
                        <input id="endtime" class="Wdate fl" type="text" placeholder="选择日期" value="" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
                    </span>
                    <i class="star"></i>
                </div>
            </div>
            <div class="newtest_class" id="evaluated"></div>
            <div class="newtest_class" id="teacher"></div>
            <div class="newtest_class" id="GetGrade"></div>
            <div style="margin: 0 auto; width: 246px;" class="clearfix">
                <input type="button" value="确认发布" class="btn fl " onclick="keep()" />
                <input type="button" value="取消发布" class="btn fl" onclick="nokeep()" style="margin-left: 10px;" />
            </div>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    var id = $("#QID").val();
    var name = $("#name").val();
    $("#content").text(name);
    $(function () {
        if ($("#qtype").val() == "4") {
            getteacher();
        }
        GetGradeClass();
    })

    var evaluated = "";
    function getteacher() {
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "GetUserInfoData", "IsStu": "false" },
            success: function (json) {
                html += "选择要发布的教师";
                evaluated += "请选择被评价的教师";
                $.each(json.result.retData, function () {
                    html += "<span style='margin-left:10px;'><input id=\"rdoOpA\" name=\"teachid\" type=\"checkbox\" value=\"" + this.IDCard + "\" />" + this.Name + "</span>";
                    evaluated += "<span style='margin-left:10px;'><input id=\"" + this.Name + "\" name=\"teacherid\" type=\"radio\" value=\"" + this.IDCard + "\" />" + this.Name + "</span>";
                });
                $("#evaluated").html(evaluated);
            }
        });
    }
   
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

    //发布试卷
    function keep() {
        var name = "";
        $("input[name='teacherid']:checked").each(function () {
            name += $(this).val();
        });
        var title = $("#name").val();
        var username = $("#hIDCard").val();
        var studentcid = "";
        var IsRelease = 1;
        var Answer = "";
        var startime = $("#startime").val();
        var endtime = $("#endtime").val();
        Answer += ",";
        if ($("#qtype").val() == "4") {
            $("input[name='teachid']:checked").each(function () {
                studentcid += $(this).val() + ",";
            });
        }
        var kk = "";
        $("input[name='teacherid']:checked").each(function () {
            kk = $(this).attr("id");
        });
        $("input[name='classid']:checked").each(function () {
            var cid = $(this).val();
            Answer += $(this).val() + ",";
            $("input[name='" + cid + "']").each(function () {
                studentcid += $(this).val() + ",";
            });
        });
        studentcid = studentcid.substr(0, studentcid.length - 1);
        studentcid = studentcid.split(",");
        if ($("#qtype").val() == "4") {
            addSysNotice(title, "评价" + name, 2, username, studentcid, "", "");
        }
        if (startime != "" && endtime != "") {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/ExamManage/PaperHandler.ashx",
                    "action": "upExam_PaperDal", "ID": id, "WorkBeginTime": startime, "WorkEndTime": endtime, "ClassID": Answer, "IsRelease": IsRelease, "evaluate": kk
                },
                success: function (json) {
                    if (json.result.retData != "") {
                        alert('发布成功');
                        parent.location.href = "ExamManager.aspx?ParentID=19";
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                }
            });
        }
    }
    function nokeep() {
        parent.location.href = "ExamManager.aspx?ParentID=19";
    }
</script>
