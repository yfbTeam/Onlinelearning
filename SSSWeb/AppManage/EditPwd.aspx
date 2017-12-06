<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditPwd.aspx.cs" Inherits="SSSWeb.AppManage.EditPwd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />

    <title></title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/Validform_v5.3.1.js?Parm=123"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <style>
        .course_form_div {
            width: 290px;
            margin: 10px auto;
            position: relative;
        }

            .course_form_div label {
                width: 80px;
                text-align: right;
            }

        .Validform_checktip {
            text-indent: 80px;
            display: block;
        }

        .Validform_wrong {
            color: #ff0000;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var valiNewForm = $("#form2").Validform({
                btnSubmit: "#btnNewEdit",
                tiptype: 3,
                showAllError: true,
                ajaxPost: true,
                beforeSubmit: function (curform) {
                    UpdatePwd();
                }
            })
        })
        function UpdatePwd() {
            var OldPwd = $("#OldPwd").val();
            var NewPwd = $("#NewPwd").val();
            if (!NewPwd) {
                layer.msg("请输入新密码和确认密码");
            }
            else if (OldPwd == NewPwd) {
                layer.msg("旧密码不能和新密码一致");
            }
            else {
                $.ajax({
                    url: "../SystemSettings/UserInfo.ashx",
                    type: "post",
                    dataType: "json",
                    data: {
                        func: "UpdatePwd",
                        LoginName: $("#LoginName").val(),
                        OldPwd: $("#OldPwd").val(),
                        LoginName: "<%=UserInfo.LoginName%>",
                        NewPwd: $("#NewPwd").val(),
                    },
                    success: function (json) {
                        if (json.result.errNum == 0) {
                            $.removeCookie("TokenID");
                            parent.layerMsg("密码修改成功");
                            parent.window.location = "../Login.aspx?Param=0";
                        } else {
                            parent.layerMsg(json.result.errMsg);
                        }
                    },
                    error: function (errMsg) {
                        parent.layerMsg(errMsg);
                    }
                });
            }
    }
    </script>

</head>
<body style="background: #fff;">
    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div class="newcourse_dialog_detail">
            <div class="clearfix">
                <div class="course_form_div clearfix">
                    <label for="">原密码：</label>
                    <input type="password" placeholder="原密码" class="text" id="OldPwd" datatype="*" nullmsg="请输入原密码！" />
                    <div class="clear" style="height: 10px;"></div>
                </div>
                <div class="course_form_div clearfix">
                    <label for="">新密码：</label>
                    <input type="password" placeholder="请输入密码" class="text" datatype="/\w{8,15}/" errormsg="请输入包含数字、字母、符号至少两种，长度在8-16位之间的密码" nullmsg="请输入新密码！" id="NewPwd" name="NewPwd" />
                    <div class="clear" style="height: 10px;"></div>
                </div>
                <div class="course_form_div clearfix">
                    <label for="">确认密码：</label>
                    <input type="password" placeholder="请再次输入密码" class="text" datatype="*" recheck="NewPwd" errormsg="两次输入的密码不一致！" nullmsg="请输入确认密码！" id="NewPwd1" />
                    <div class="clear" style="height: 10px;"></div>
                </div>
                <div class="course_form_select clearfix" style="text-align: center;">
                    <a class="course_btn confirm_btn" id="btnNewEdit">确定</a>
                </div>
            </div>
        </div>
    </form>


</body>
</html>
