<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModelAdd_MTG.aspx.cs" Inherits="SSSWeb.AppManage.ModelAdd_MTG" %>

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

    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            if (UrlDate.ID != undefined) {
                getData();
            }
        });
        function CatoryModel() {
            $("#ModelType").html("");
            $.ajax({
                url: "../Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "ModelCatogory", "Status": "1" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#ModelType").append("<option value='" + this.ID + "'>" + this.Name + "</option>");
                        })
                    }
                    else {
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function AddModol() {
            var ModelName = $("#ModelName").val();
            var ModelType = "6";

            //var OpenType = $("#OpenType").val();
            //var ModelCss = $("#color").val();
            var iconCss = $("#ButtonIcon").val();
            var LinkUrl = $("#LinkUrl").val();
            var OrderNum = $("#OrderNum").val();
            var ID = UrlDate.ID;
            var Pid = UrlDate.Pid;

            if (ID == "undefined" || ID == undefined) {
                ID = "";
            }
            if (!ModelName.length || ModelType == "") {
                layer.msg("请填写完模块名称,选择模块分类！");
            }
            else {
                $.ajax({
                    url: "../Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "Func": "AddModol",
                        ID: ID,
                        ModelName: ModelName,
                        ModelType: ModelType,
                        //OpenType: OpenType,
                        //ModelCss: ModelCss,
                        iconCss: iconCss,
                        LinkUrl: LinkUrl,
                        OrderNum: OrderNum,
                        MenuType: $("#MenuType").val(),
                        Pid: Pid,
                        UniqueNo: "<%=UserInfo.UniqueNo%>"


                    },
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
                        layer.msg(errMsg);
                    }
                });
            }
        }
        function getData() {

            $.ajax({
                url: "../Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "GetModelList", ID: UrlDate.ID, Ispage: 'false' },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#ModelName").val(this.ModelName);
                            $("#MenuType").val(this.MenuType);
                            ChangeShow();
                            $("#ButtonIcon").val(this.iconCss);
                            $("#ModelName").val(this.ModelName);
                            $("#icoName").val(this.iconCss);
                            $("#LinkUrl").val(this.LinkUrl);
                            //$("#color").val(this.ModelCss);
                            $("#OrderNum").val(this.OrderNum);

                        })
                    }
                    else {
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function ChangeShow() {
            if ($("#MenuType").val() == "2") {
                $(".fr").hide();
                $("#bgColor").hide();
            }
            else {
                $(".fr").show();
                $("#bgColor").show();
            }
        }
        function ChangeShow() {
            if ($("#MenuType").val() == "2") {
                $("#div_BtnType").show();
                $("#ModelName").val("查看");
            }
            else {
                $("#div_BtnType").hide();
            }
        }
        function ChangeName() {
            var Name = $("#ButtonIcon").find("option:selected").text()
            $("#ModelName").val(Name);
        }
    </script>

</head>
<body style="background: #fff">
    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div>
                        <div class="course_form_select clearfix">
                            <label for="">菜单类型：</label>
                            <select id="MenuType" onchange="ChangeShow()">
                                <option value="1" selected="selected">菜单</option>
                                <option value="2">按钮</option>

                            </select>
                        </div>
                        <div id="div_BtnType" class="course_form_select none clearfix">
                            <label for="" class="row_label fl">按钮类型：</label>
                            <select id="ButtonIcon" onchange="ChangeName()">
                                <option value="icon-view" selected="selected">查看</option>
                                <option value="icon-plus">新增</option>
                                <option value="icon-edit">修改</option>
                                <option value="icon-del">删除</option>
                                <option value="icon-appintroom">预约教室</option>
                                <option value="icon-releasecourse">发布课程</option>
                                <option value="icon-weekset">选课周设置</option>
                                <option value="icon-coursecatogory">课程分类</option>                                
                                <option value="icon-Download">下载</option>
                                <option value="icon-Remove">移动到</option>
                                <option value="icon-ReName">重命名</option>
                                <option value="icon-CheckUser">指定审核人</option>
                                <option value="icon-NewFolder">新建文件夹</option>
                            </select>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">菜单名称：</label>
                            <input type="text" placeholder="菜单名称" class="text" id="ModelName" value="" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">菜单排序：</label>
                            <input type="text" placeholder="菜单排序" class="text" id="OrderNum" value="0" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">链接地址：</label>
                            <input type="text" placeholder="链接地址" class="text" id="LinkUrl" value="" />
                            <i class="stars"></i>
                        </div>

                    </div>

                    <div class="clear"></div>
                    <div class="course_form_select clearfix" style="text-align: center; margin-top: 20px;">
                        <a class="course_btn confirm_btn" onclick="AddModol()" id="btnCreate">确定</a>
                    </div>

                </div>
            </div>
        </div>
    </form>


</body>
</html>
