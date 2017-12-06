<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowNotice.aspx.cs" Inherits="SSSWeb.PersonalOffice.ShowNotice" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link type="text/css" rel="stylesheet" href="/ZZSX/css/common.css" />
    <link type="text/css" rel="stylesheet" href="/ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="/ZZSX/css/iconfont.css" />
    <link type="text/css" rel="stylesheet" href="/ZZSX/css/animate.css" />
    <link href="/ZZSX/css/style.css" rel="stylesheet" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />

    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/KindUeditor/kindeditor.js"></script>
    <script src="../Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="../Scripts/KindUeditor/lang/zh_CN.js"></script>

    <link href="../Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="../Scripts/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script src="../Scripts/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <script src="../Scripts/zTree/js/jquery.ztree.exedit-3.5.js"></script>
</head>
<body>
    <div class="MenuDiv New_announcement">

        <div>
            <table class="tbEdit">
                <tbody>
                    <tr>
                        <td style="width:50px; text-align:right">标题</td>
                        <td class="ku" id="Title">
                        </td>
                    </tr>

                    <tr>
                        <td style="width:50px; text-align:right">内容</td>
                        <td class="ku" id="content">
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "SystemSettings/NoticeManage.ashx", "Func": "GetData", IsPage: "false", ID: UrlDate.ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#Title").html(this.Title);
                            $("#content").html(this.Content);
                        });
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        })
    </script>
</body>
</html>

