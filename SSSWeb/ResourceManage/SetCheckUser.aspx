<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetCheckUser.aspx.cs" Inherits="SSSWeb.ResourceManage.SetCheckUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>设置审核人</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />

    <link href="../css/choosen/chosen.css" rel="stylesheet" />
    <link href="../css/choosen/prism.css" rel="stylesheet" />
    <link href="../css/choosen/style.css" rel="stylesheet" />

    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/choosen/chosen.jquery.js"></script>
    <script src="../Scripts/choosen/prism.js"></script>
    <style>
        .course_form_selecta {
            margin-bottom: 20px;
        }

            .course_form_selecta label {
                float: left;
                color: #666666;
                font-size: 14px;
                line-height: 30px;
            }

            .course_form_selecta .chosen-select {
                width: 178px;
            }
    </style>

</head>
<body style="background: #fff">
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">

        <!--创建课程dialog-->
        <div>
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="course_form_selecta clearfix">
                        <label for="">审核人：</label>
                        <select class="chosen-select" data-placeholder="审核人" multiple="multiple" id="LecturerName">
                        </select>
                    </div>
                    <div class="clearfix">
                        <div class="course_form_select clearfix">
                            <a class="course_btn confirm_btn" onclick="Save()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();

        $(function () {
            BindTeacher();
        })




        function BindTeacher() {
            $("#LecturerName").html("");
            $.ajax({
                url: "../SystemSettings/CommonInfo.ashx",
                type: "post",
                dataType: "json",
                async: false,
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
                        $("#LecturerName").html(Option);
                        var config = {
                            '.chosen-select': {},
                            '.chosen-select-deselect': { allow_single_deselect: true },
                            '.chosen-select-no-single': { disable_search_threshold: 10 },
                            '.chosen-select-no-results': { no_results_text: 'Oops,未找到!' },
                            '.chosen-select-width': { width: "178px" }
                        }
                        var TeaArry = UrlDate.CheckUsers.toString().split(',');
                        for (var i = 0; i < TeaArry.length; i++) {
                            $("#LecturerName option[value='" + TeaArry[i] + "']").attr("selected", true);
                        }

                        $("#LecturerName").trigger("chosen:updated");
                        //$("#Grade").trigger("liszt:updated");--旧版本
                        $("#LecturerName").chosen();

                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        function Save() {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceManage/ResourceInfoHander.ashx", "Func": "SetCheckUser", ID: UrlDate.ID, UserNo: $("#LecturerName").val() },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("设置成功");
                    }
                    else { layer.msg('重命名失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('重命名失败！');
                }
            });

        }

    </script>
</body>
</html>
