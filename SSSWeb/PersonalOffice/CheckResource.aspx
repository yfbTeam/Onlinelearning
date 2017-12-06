<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckResource.aspx.cs" Inherits="SSSWeb.PersonalOffice.CheckResource" %>

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
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />

    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>

    <script type="text/javascript">

        var UrlDate = new GetUrlDate();
        function Save() {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceManage/ResourceInfoHander.ashx",
                    func: "Edit", ID: UrlDate.ID, Status: $("#Status").val(),
                    CheckMessage: $("#CheckMessage").val(), UserNo: '<%=UserInfo.UniqueNo%>',
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
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
    </script>

</head>
<body style="background:#fff">
    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">


                        <div class="course_form_select clearfix">
                            <label for="">是否通过：</label>
                            <select id="Status">
                                <option value="1" selected="selected">通过</option>
                                <option value="2">拒绝</option>
                            </select>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">审核意见：</label>
                            <input type="text" placeholder="审核意见" class="text" id="CheckMessage" />
                        </div>
                        <div class="course_form_select clearfix" style="text-align: center;">
                            <a class="course_btn confirm_btn" onclick="Save()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>


</body>
</html>
