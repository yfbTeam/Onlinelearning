<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CatogoryAdd.aspx.cs" Inherits="SSSWeb.AppManage.CatogoryAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>

    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            var GetName = UrlDate.Name;
            if (GetName != undefined) {
                CatoryModelByID();
                //$("#Name").val(UrlDate.Name);
                //$("#Status").val(UrlDate.Status);
            }
        });
        function CatoryModelByID() {
            $.ajax({
                url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "ModelCatogory", ID: UrlDate.ID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#Name").val(this.Name);
                            $("#SortNum").val(this.SortNum);
                            $("#Status").val(this.Status);
                        })
                    }

                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function AddCatogory() {
            var Name = $("#Name").val();

            if (!Name.length) {
                layer.msg("请填写分类名称！");
            }
            else {
                $.ajax({
                    url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "Func": "AddCatory",
                        ID: UrlDate.ID,
                        Name: $("#Name").val(),
                        Status: $("#Status").val(),
                        SortNum: $("#SortNum").val()
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            parent.layer.msg('操作成功!');
                            parent.CatoryModel();
                            parent.CloseIFrameWindow();
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
        }

    </script>

</head>
<body>
    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">分类名称：</label>
                            <input type="text" placeholder="分类名称" class="text" id="Name" />
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">分类排序：</label>
                            <input type="text" placeholder="分类排序" class="text" id="SortNum" value="0" />
                        </div>
                        <div class="course_form_select clearfix">
                            <label for="">分类状态：</label>
                            <select id="Status">
                                <option value="0">禁用</option>
                                <option value="1" selected="selected">启用</option>
                            </select>
                        </div>

                        <div class="course_form_select clearfix">
                            <a class="course_btn confirm_btn" onclick="AddCatogory()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>


</body>
</html>

