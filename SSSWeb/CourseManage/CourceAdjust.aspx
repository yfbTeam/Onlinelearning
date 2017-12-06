<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourceAdjust.aspx.cs" Inherits="SSSWeb.CourseManage.CourceAdjust" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>人员调整</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link href="../css/choosen/chosen.css" rel="stylesheet" />
    <link href="../css/choosen/prism.css" rel="stylesheet" />
    <link href="../css/choosen/style.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/choosen/chosen.jquery.js"></script>
    <script src="../Scripts/choosen/prism.js"></script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix ">
                        <label for="">课程名称：</label>
                        <input type="text" placeholder="" class="text" id="txt_Name" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_select fl">
                        <label for="">人员选择：</label>
                        <select class="chosen-select" data-placeholder="人员选择" multiple="multiple" id="SelectedStu">
                        </select>
                    </div>

                    <div style="clear: both;"></div>
                    <div class="course_form_select clearfix">
                        <span class="course_btn confirm_btn" onclick="Save();" style="cursor: pointer;">确定</span>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            $("#txt_Name").val(UrlDate.CourceName);
            BindTeacher();
            GetSelStu();

            var config = {
                '.chosen-select': {},
                '.chosen-select-deselect': { allow_single_deselect: true },
                '.chosen-select-no-single': { disable_search_threshold: 10 },
                '.chosen-select-no-results': { no_results_text: 'Oops, 未找到!' },
                '.chosen-select-width': { width: "95%" }
            }
            for (var selector in config) {
                $(selector).chosen(config[selector]);
            }
        })
        function BindTeacher() {
            $("#SelectedStu").html("");
            $.ajax({
                url: "../SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    func: "GetUserInfoData", IsStu: "false"
                },
                success: function (json) {
                    var Option = "";
                    var result = json.result;
                    if (result.errNum == 0) {
                        $(json.result.retData).each(function () {
                            Option += "<option value='" + this.UniqueNo + "'>" + this.Name + "</option>";
                        })
                        $("#SelectedStu").html(Option);
                    }
                    else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        //绑定数据
        function GetSelStu() {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/CourseManage/CourceManage.ashx",
                    Func: "GetSelStu",
                    CourseID: UrlDate.CourceID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        //在学人员
                        $.each(json.result.retData, function (n, value) {
                            $("#SelectedStu option[value='" + this.StuNo + "']").attr("selected", true);
                        });
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
        function Save() {
            //alert($("#SelectedStu").val());
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/CourseManage/CourceManage.ashx",
                    Func: "AdJustStu",
                    CourseID: UrlDate.CourceID,
                    StuNo: $("#SelectedStu").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                       layer.msg("调整成功");
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
    </script>
</body>
</html>
