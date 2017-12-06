<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TextbookEdit.aspx.cs" Inherits="SSSWeb.ResourceManage.TextbookEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>编辑教材</title>
    <link href="../css/stylebase.css" rel="stylesheet" />
    <link href="../css/commonbase.css" rel="stylesheet" />
    <link href="../css/iconfont.css" rel="stylesheet" />
    <link href="../css/animate.css" rel="stylesheet" />
    <link href="../css/choosen/chosen.css" rel="stylesheet" />
    <link href="../css/choosen/prism.css" rel="stylesheet" />
    <link href="../css/choosen/style.css" rel="stylesheet" />


    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/choosen/chosen.jquery.js"></script>
    <script src="../Scripts/choosen/prism.js"></script>
</head>
<body>
    <input type="hidden" id="hid_Id" runat="server" />
    <input type="hidden" id="hid_UserIDCard" value="<%=UserInfo.UniqueNo %>" />
    <!--tz_dialog start-->
    <div class="yy_dialog">
        <div class="t_content">
            <div class="yy_tab">
                <div class="content">
                    <div class="tc">
                        <div class="t_message">
                            <div class="message_con">
                                <form>
                                    <table class="m_top">
                                        <tr>
                                            <td class="mi"><span class="m">教材名称：</span></td>
                                            <td class="ku">
                                                <input id="Name" type="text" class="hu" /><span class="wstar">*</span></td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">专业名称：</span></td>
                                            <td class="ku">
                                                <select id="Major" class="option" onchange="MajorChange()"></select>
                                                <span class="wstar">*</span>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">科目：</span></td>
                                            <td class="ku">
                                                <select class="chosen-select" data-placeholder="选择专业" multiple="multiple" id="Subject" style="width: 178px;">
                                                </select>
                                                <%--<select id="Subject" class="option"></select>--%><span class="wstar">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="mi"><span class="m">版本：</span></td>
                                            <td class="ku">
                                                <select id="Version" class="option"></select><span class="wstar">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="submit_btn">
                            <span class="Save_and_submit">
                                <input type="submit" value="确定" class="Save_and_submit" onclick="Save();" /></span>
                            <span class="cancel">
                                <input type="submit" value="取消" class="cancel" onclick="javascript: parent.CloseIFrameWindow();" /></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end tz_dialog-->

    <!--tz_yy start-->
    <div class="tz_yy"></div>
    <!--end tz_yy-->
</body>
<script type="text/javascript">
    $(document).ready(function () {
        var itemid = $("#hid_Id").val();
        BindMajorAndSubJect();
        BindVersion();
        /*原学习平台*/
        //BindGradeOfPeriod();
        // BindSubjectData();
        //BindVersionData();
        //if (itemid.length) {
        //    //为控件绑定数据
        //    BindDataById(itemid);
        //}
    });
    function MajorChange() {
        var MajorID = $("#Major").val();
        BindSubJect(MajorID);
    }
    function BindMajorAndSubJect() {
        $.ajax({
            url: "../SystemSettings/EduHander.ashx",
            dataType: "json",
            type: "post",
            data: {
                func: "GetSubJect",
                "IsPage": "false"
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    var MajorOption = "";
                    var i = 0;
                    $.each(json.result.retData, function () {
                        if (MajorOption.indexOf(this.MajorName) < 0) {
                            MajorOption += "<option value='" + this.MajorID + "'>" + this.MajorName + "</option>";
                            i++;
                        }
                    });
                    $("#Major").html(MajorOption);
                    BindSubJect($("#Major").val());
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function BindSubJect(MajorID) {
        $.ajax({
            url: "../SystemSettings/EduHander.ashx",
            dataType: "json",
            type: "post",
            data: {
                func: "GetSubJect",
                "IsPage": "false"
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $.each(json.result.retData, function () {
                        if (this.MajorID == MajorID) {
                            $("#Subject").append("<option value='" + this.SubID + "'>" + this.SubjectName + "</option>");
                        }
                    });
                }
                var config = {
                    '.chosen-select': {},
                    '.chosen-select-deselect': { allow_single_deselect: true },
                    '.chosen-select-no-single': { disable_search_threshold: 10 },
                    '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
                    '.chosen-select-width': { width: "95%" }
                }
                for (var selector in config) {
                    $(selector).chosen(config[selector]);
                }
                $("#Subject").trigger("chosen:updated");
                //$("#Grade").trigger("liszt:updated");--旧版本
                $("#Subject").chosen();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        })
    }

    function BindVersion() {
        //初始化序号 
        $.ajax({
            url: "../SystemSettings/EduHander.ashx",
            type: "post",
            dataType: "json",
            data: {
                func: "GetBookVersion",
                IsPage: "false",

            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $.each(json.result.retData, function () {

                        $("#Version").append("<option value='" + this.ID + "'>" + this.Name + "</option>");

                    });
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }

    //保存接口
    function Save() {
        var Name = $("#Name").val().trim();
        var Major = $("#Major").val();
        var Subject = $("#Subject").val();
        var Version = $("#Version").val();
        if (!Name || !Major || !Subject || !Version) {
            layer.msg("数据填写不完整");
        }
        else {
            $.ajax({
                url: "../SystemSettings/EduHander.ashx",
                type: "get",
                async: false,
                dataType: "json",
                data: {
                    func: "AddBook",
                    Name: Name,
                    Major: Major,
                    Subject: Subject,
                    Version: Version
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        parent.getData(1, 10);
                        parent.CloseIFrameWindow();
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            })
        }
    }
    /*
    //获取班级年级数据
    function BindMajor() {
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
                    var option = "<option value='" + this.id + "'>" + this.name + "</option>"
                    $("#Grade").append(option);
                    var config = {
                        '.chosen-select': {},
                        '.chosen-select-deselect': { allow_single_deselect: true },
                        '.chosen-select-no-single': { disable_search_threshold: 10 },
                        '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
                        '.chosen-select-width': { width: "200px" }
                    }
                    for (var selector in config) {
                        $(selector).chosen(config[selector]);
                    }
                    $("#Grade").trigger("chosen:updated");
                    //$("#Grade").trigger("liszt:updated");--旧版本
                    $("#Grade").chosen();
                    //html += '<div class="clearfix" style="padding:5px 0px;margin-bottom:10px;border:1px solid #ccc;">'
                    //html += '<div class="fl" style="width:70px;line-height:20px;font-size:14px;text-align:center;border-right:1px solid #ccc;"> ' + this.name + '</div>';
                    //html += '<div class="class_select fl" style="width:">';
                    //$.each(this.children, function () {
                    //    html += "<span style='margin-left:10px;'><input id=\"rdoOpA\" name=\"classid\" type=\"checkbox\" value=\"" + this.id + "\" />" + this.name + "</span>";

                    //})
                    //html += '</div></div>';
                    //$("#GetGrade").html(html);
                });

            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //学段绑定
    function BindGradeOfPeriod() {
        $.ajax({
            type: "post",
            url: "../Common.ashx",
            dataType: "json",
            async: false,
            data: {
                "PageName": "InitialDataHandler.ashx",
                func: "PeridOfGrade",
                //PeriodID: $("#Period").val()
            },
            success: function (json) {
                $("#Grade").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {

                        var option = "<option value='" + item.Id + "'>" + item.GradeName + "</option>"
                        $("#Grade").append(option);
                    });
                    var config = {
                        '.chosen-select': {},
                        '.chosen-select-deselect': { allow_single_deselect: true },
                        '.chosen-select-no-single': { disable_search_threshold: 10 },
                        '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
                        '.chosen-select-width': { width: "95%" }
                    }
                    for (var selector in config) {
                        $(selector).chosen(config[selector]);
                    }
                    $("#Grade").trigger("chosen:updated");
                    //$("#Grade").trigger("liszt:updated");--旧版本
                    $("#Grade").chosen();
                }
            }
        });

    }
    //科目绑定
    function BindSubjectData() {
        $.ajax({
            type: "post",
            url: "../Common.ashx",
            dataType: "json",
            data: {
                "PageName": "SubjectHandler.ashx",
                func: "Plat_GetSubjectData"
            },
            success: function (json) {
                $("#Subject").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {
                        var option = "<option value='" + item.Id + "'>" + item.Name + "</option>"
                        $("#Subject").append(option);
                    });
                }
            }
        });
    }
    //版本绑定
    function BindVersionData() {
        $.ajax({
            type: "post",
            url: "../Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "TextbookVersionHandler.ashx?",
                func: "Plat_GetTVData"
            },
            success: function (json) {
                $("#Version").empty();
                if (json.result.errNum.toString() != "0" && json.result.errNum.toString() != "100") {
                    layer.msg(json.result.errMsg);
                    return;
                }
                if (json.result.retData) {
                    $.each(json.result.retData, function (i, item) {
                        var option = "<option value='" + item.Id + "'>" + item.Name + "</option>"
                        $("#Version").append(option);
                    });
                }
            }
        });
    }
    //获得数据
    function BindDataById(Id) {
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "TextbookHandler.ashx",
                func: "GetTextbookById",
                Id: Id,
            },
            success: function (json) {
                var model = json.result.retData;
                if (model.toString() != "") {
                    $("#Name").val(model.Name);
                    $("#Period").val(model.PeriodID);
                    $("#Subject").val(model.SubjectID);
                    $("#Version").val(model.VersionID);
                }
            }
        });
    }
    //保存接口
    function Save() {
        var Name = $("#Name").val().trim();
        //var Period = $("#Period").val();
        var Subject = $("#Subject").val();
        var Version = $("#Version").val();
        var Grade = $("#Grade").val()
        var UserIDCard = $("#hid_UserIDCard").val().trim();
        var Id = $("#hid_Id").val();
        var func = Id != "" ? "UpdateTextbook" : "AddTextbook";
        if (!Name.length || !Subject.length || !Version.length || !Grade.length) {
            layer.msg("所有项不允许为空");
        }
        else {
            $.ajax({
                url: "../Common.ashx?",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "TextbookHandler.ashx",
                    func: func,
                    Id: Id,
                    UserIDCard: UserIDCard,
                    Name: Name,
                    //PeriodID: Period,
                    SubjectID: Subject,
                    VersionID: Version,
                    Grade: Grade
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == -1) {
                        layer.msg(result.errMsg);
                    }
                    else if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        parent.getData(1);
                        parent.CloseIFrameWindow();
                    } else {
                        layer.msg("操作失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
    }*/
</script>
</html>

