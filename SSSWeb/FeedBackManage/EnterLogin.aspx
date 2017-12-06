<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnterLogin.aspx.cs" Inherits="SSSWeb.FeedBackManage.EnterLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        .login_dl {
            margin: 200px auto;
            font-family: "微软雅黑",microsoft yehei ui;
        }

        .logincon {
            width: 430px;
            background: #ffffff;
            border-radius: 3px;
            box-shadow: 1px 1px 8px rgba(0, 0, 0, 0.6);
            margin: 0 auto;
        }

        .login_tit {
            color: #4d4d4d;
            font-size: 24px;
            padding: 20px;
        }

        .login_dl .condl {
            padding: 20px;
            padding-top: 0px;
        }

            .login_dl .condl .contable {
                width: 340px;
                margin: auto;
            }

        .contable tr td {
            padding: 4px;
            color: #666;
            font-size: 16px;
            line-height: 36px;
        }

            .contable tr td input {
                line-height: 28px;
                border-radius: 3px;
                border: 1px solid #ccc;
                height: 28px;
                padding: 0 10px;
                color: #666;
                width: 190px;
            }

        .btn {
            text-align: center;
            padding-top: 10px;
        }

            .btn input {
                cursor: pointer;
                border-radius: 3px;
                border: 1px solid #4782c2;
                color: #fff;
                font-size: 14px;
                padding: 2px 14px;
                background: #5593d7;
            }

                .btn input:hover {
                    background: #427fc1;
                    border: 1px solid #4782c2;
                    color: #fff;
                }
    </style>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
</head>
<body>

    <div>
        <div class="login_dl">
            <div class="logincon">
                <div class="login_tit">
                    用户登录           
                </div>
                <div class="condl">
                    <table class="contable">
                        <%--<tr >
                    <td class="lftd">企业名称：</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" ></asp:TextBox>
                </tr>--%>
                        <tr>
                            <td class="lftd">用&nbsp;户&nbsp;&nbsp;名：</td>
                            <td>
                                <input type="text" id="txtUser" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lftd">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
                            <td>
                                <input type="password" id="txtPwd" />

                            </td>

                        </tr>

                    </table>
                    <div class="btn">
                        <input type="button" onclick="Login()" value="登陆" />
                    </div>
                </div>
            </div>

        </div>
    </div>
    <script type="text/javascript">
        function Login() {

            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "FeedBack/Enterprise.ashx", "Func": "GetPageList", IsPage: "false", LoginName: $("#txtUser").val(), "PassWord": $("#password").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        window.location= "FeedBack_Manage.aspx?EnterName=" + json.result.retData[0].ID;
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
