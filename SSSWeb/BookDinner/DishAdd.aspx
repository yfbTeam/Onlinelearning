<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DishAdd.aspx.cs" Inherits="SSSWeb.BookDinner.DishAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增菜品</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../Scripts/Webuploader/css/webuploader.css" rel="stylesheet" />

    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=2.0"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>

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

        .chosen-container {
            float: left;
        }

        .course_form_img {
            width: 258px;
            height: 124px;
            border: 1px solid #1783c7;
            overflow: hidden;
            position: absolute;
            right: 0px;
            top: 0px;
        }

            .course_form_img .change_picture { /*width:90px;height: 24px;line-height: 24px;background: #40bb6b;*/
                text-align: center;
                display: block;
                font-size: 12px;
                position: absolute;
                right: 0;
                top: 0;
                color: #fff;
                z-index: 2;
                cursor: pointer;
                margin-top: 0px;
            }
    </style>


</head>
<body style="background: #fff;">
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo %>" />

        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix pr">
                    <div class="course_form_div">
                        <label for="">菜品名称：</label>
                        <input type="text" placeholder="课程名称" class="text" id="Name" maxlength="20" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_select fl">
                        <label for="">菜品分类：</label>
                        <select id="DishType">
                        </select><i class="stars"></i>
                    </div>
                    <div style="clear: both"></div>
                    <div class="course_form_div fl">
                        <label for="">菜品价格：</label>
                        <input type="text" placeholder="菜品价格" class="text" id="Price" maxlength="20" />
                        <i class="stars" style="float: right;"></i>
                    </div>


                    <div class="course_form_img">
                        <img id="img_Pic" alt="" src="" />
                        <div class="change_picture">
                            <div id="filePicker">选择图片</div>
                        </div>
                    </div>
                    <style>
                        .course_form_img .uploadify-button {
                            font-size: 14px;
                            color: #fff;
                            border: none;
                            background: #19c857;
                        }
                    </style>
                </div>
                <div class="course_form_select fl" style="margin-top: 0;">
                    <label for="">菜品热度：</label>
                    <select id="HotDegree">
                        <option value="0">不辣</option>
                        <option value="1">微辣</option>
                        <option value="2">特辣</option>
                    </select><i class="stars"></i>
                </div>

                <div style="clear: both"></div>
                <div class="course_form_select">
                    <label for="">菜品备注：</label>
                    <textarea name="" rows="" cols="" id="Description"></textarea>
                </div>

            </div>
            <div class="course_form_div clearfix" style="text-align: center;">
                <input type="button" class="course_btn confirm_btn" onclick="Save()" id="btnCreate" value="确定" style="border: none;" />
            </div>

        </div>
    </form>
    <script src="../js/common.js"></script>
    <script src="../Scripts/Webuploader/dist/webuploader.js"></script>


    <script>
        var GetUrlDate = new GetUrlDate();
        $(function () {
            WebUploader.create({
                pick: '#filePicker',
                formData: { Func: "Uplod" },
                accept: {
                    title: 'Images',
                    extensions: 'jpg,gif,png,jpeg',
                    mimeTypes: 'image/!*'
                },
                auto: true,
                chunked: false,
                chunkSize: 512 * 1024,
                server: 'UploadHtml5.ashx',
                // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
                disableGlobalDnd: true,
                fileNumLimit: 1,
                fileSizeLimit: 200 * 1024 * 1024,    // 200 M
                fileSingleSizeLimit: 50 * 1024 * 1024    // 50 M
            })
           .on('uploadSuccess', function (file, response) {

               var json = $.parseJSON(response._raw);
               $("#img_Pic").attr("src", json.result.retData);

           }).onError = function (code) {
               switch (code) {
                   case 'exceed_size':
                       alert('文件大小超出');
                       break;

                   case 'interrupt':
                       alert('上传暂停');
                       break;

                   default:
                       alert('错误: ' + code);
                       break;
               }
           };

            BindDishType();
            var ID = GetUrlDate.ID;
            if (ID != undefined) {
                GetDataByID(ID);
            }

        })
        function BindDishType() {
            $("#DishType").html("<option value=''>==菜品分类==</option>");
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: { PageName: "/CanteenReservation/Order_DishHander.ashx", Func: "GetDishType", },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var option = "<option value='" + this.ID + "'>" + this.Name + "</option>";
                            $("#DishType").append(option);
                        });
                    }
                    else {
                    }
                },
                error: function (errMsg) {

                }
            });
        }

        //添加数据
        function Save() {

            var CreateUID = $("#HUserIdCard").val();
            var Name = $("#Name").val().trim();
            var Type = $("#DishType").val();//.children('span').attr("value").trim();
            var Description = $("#Description").val();
            var Photo = $("#img_Pic").attr("src");
            var Price = $("#Price").val();
            var HotDegree = $("#HotDegree").val();
            var func = "Add";
            var ID = "";
            if (GetUrlDate.ID != undefined) {
                ID = GetUrlDate.ID;
                func = "Edit";
            }
            if (!Name || !Type || !Price || !HotDegree) {
                layer.msg("请输入必填项！");
            }
            else {
                $.ajax({
                    url: "../Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "CanteenReservation/Order_DishHander.ashx",
                        func: func, Name: Name, Type: Type, Description: Description, Photo: Photo, Price: Price, HotDegree: HotDegree, ID: ID
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
        }
        //绑定数据
        function GetDataByID(ID) {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CanteenReservation/Order_DishHander.ashx", "Func": "GetPageList", IsPage: "false", ID: ID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {

                            $("#Name").val(this.Name);
                            $("#DishType").val(this.Type);//.children('span').attr("value", this.CourceType)
                            $("#img_Pic").attr("src", this.Photo);
                            $("#Price").val(this.Price);
                            $("#Description").val(this.Description);
                            $("#HotDegree").val(this.HotDegree);
                            $("#Description").val(this.Description);
                        });
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
