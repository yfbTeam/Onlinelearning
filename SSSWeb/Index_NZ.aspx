<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index_NZ.aspx.cs" Inherits="SSSWeb.Index_NZ" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="Scripts/jquery-1.11.2.min.js"></script>
    <script src="Scripts/layer/layer.js"></script>
    <script type="text/javascript">
        $(function () {

            $.ajax({
                url: "Common.ashx",
                type: "post",
                dataType: "json",
                data: { "PageName": "SystemSettings/RoleHandler.ashx", "Func": "GetRoleData", "IsPage": "false", "UserIDCard": '<%=UserInfo.UniqueNo %>' },
                success: function (json) {
                    if (json.result.errNum == "0") {
                        $.each(json.result.retData, function () {
                            if (this.DefaultUrl != "") {
                                window.location.href = this.DefaultUrl;
                            }
                            else {
                                window.location.href = "AppManage/Index.aspx"
                            }
                        })
                    }
                    else {
                        window.location.href = "NoPower.html"
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg(errorThrown);
                }
            });
        })
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
