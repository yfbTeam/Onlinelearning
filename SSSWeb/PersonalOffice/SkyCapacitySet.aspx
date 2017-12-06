<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SkyCapacitySet.aspx.cs" Inherits="SSSWeb.PersonalOffice.SkyCapacitySet" %>

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

    <script src="../Scripts/choosen/chosen.jquery.js"></script>
    <script src="../Scripts/choosen/prism.js"></script>
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
        var UrlDate = new GetUrlDate();
        $(function () {
            var Type = UrlDate.Type;
            if (Type == "All") {
                $("#User").hide();
                GetBaseSet();
            }
            else {
                $("#User").show();
                $("#AddLen").val(UrlDate.AddLen);
            }
            BindTeacher();


            var UserID = UrlDate.CreateUID;
            if (UserID == "") {
                UserID = UrlDate.UserID;
            }
            $("#UserID").val(UserID);
        })
        function Edit() {

            var ID = UrlDate.ID;
            var Type = UrlDate.Type;
            var AddLen = parseInt($("#AddLen").val());
            var Func = "";
            if (Type == "All") {
                Func = "BaseSet";
            }
            else {
                Func = "EachSet";
            }
            if (Func == "") {
                layer.msg("方法名无效");
            }
            else if (AddLen<=0) {
                layer.msg("容量值只能设置大于0的值")
            }
            else {
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "ResourceManage/SkySet.ashx", "Func": Func, AddLen: $("#AddLen").val(), UserID: $("#UserID").val(), ID: ID },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            parent.layer.msg('操作成功!');
                            parent.getData(1, 10);
                            parent.CloseIFrameWindow();

                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (errMsg) {
                        layer.msg('下载失败！');
                    }
                });
            }
        }
        function GetBaseSet() {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: { "PageName": "ResourceManage/SkySet.ashx", "Func": "GetBaseSet" },
                success: function (json) {
                    var Option = "";
                    var result = json.result;
                    if (result.errNum == 0) {
                        $(json.result.retData).each(function () {
                            $("#AddLen").val(this.BaseLen);
                        })


                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        function BindTeacher() {
            $("#UserID").html("");
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
                        $("#UserID").html(Option);

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
<body style="background: #fff;">
    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div class="newcourse_dialog_detail">
            <div class="clearfix">
                <div class="course_form_div clearfix" id="User">
                    <label for="" style="width: 100px;">选择用户：</label>
                    <select class="select" id="UserID" style="width: 178px;">
                    </select>
                    <%--<select class="chosen-select" data-placeholder="选择用户" multiple="multiple" id="UserID" style="width: 178px;">
                    </select>--%>
                </div>
                <div class="course_form_div clearfix">
                    <label for="" style="width: 100px;">容量设置值：</label>
                    <input type="text" placeholder="容量设置值" class="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" id="AddLen" />
                    <div class="clear" style="height: 10px;"></div>
                </div>

                <div class="course_form_select clearfix" style="text-align: center;">
                    <a class="course_btn confirm_btn" onclick="Edit()">确定</a>
                </div>
            </div>
        </div>
    </form>


</body>
</html>
