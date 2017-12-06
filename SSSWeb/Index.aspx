<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SSSWeb.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <title></title>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/Common.js?parm=1.01"></script>
    <script src="/Scripts/layer/layer.js"></script>

</head>
<body>
    <input type="hidden" id="HAdminUser" value="" />
    <input type="hidden" id="LoginName" value="" runat="server" />
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            GetUserInfo();
        })
        function GetUserInfo() {

            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",
                async: false,
                dataType: "json",
                data: { "Func": "GetUserInfoData", "LoginName": $("#LoginName").val() },
                success: function (returnVal) {
                    var flg = returnVal.result;
                    if (flg != null) {
                        if (flg.errNum == 0) {
                            if (flg.retData.IsEnable == "0") {
                                layer.msg("用户已被禁用");
                            }
                            else if (flg.retData.IsDelete == "1") {
                                layer.msg("用户不存在");
                            }
                            else {
                                var item = flg.retData;
                                if (item.CreateTime != null) item.CreateTime = DateTimeConvert(item.CreateTime);
                                if (item.EditTime != null) item.EditTime = DateTimeConvert(item.EditTime);
                                if (item.Birthday != null) item.Birthday = DateTimeConvert(item.Birthday);
                                $.cookie('LoginCookie_Author', JSON.stringify(item), { path: '/', secure: false });
                                GetUserRole();
                                var adminUser = $("#HAdminUser").val();
                                var i = adminUser.indexOf(flg.retData[0].UniqueNo);
                                if (i < 0) {
                                    window.location = "/PersonalSpace/CourseManIndex.aspx";
                                }
                                else {
                                    window.location = "/AppManage/Index.aspx";
                                }

                            }

                        } else {
                            layer.msg("用户尚未同步到本系统");
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.closeAll('loading');
                }
            });

        }
        function GetUserRole() {
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",
                async: false,
                dataType: "text",
                data: { "Func": "GetUserRole" },
                success: function (result) {
                    $("#HAdminUser").val(result);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg(errorThrown);
                }
            });
        }

    </script>
</body>
</html>
