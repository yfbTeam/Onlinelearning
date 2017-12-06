<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditWeike.aspx.cs" Inherits="SSSWeb.CourseManage.EditWeike" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>创建课程</title>
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

    <style type="text/css">
        .course_form_img {
            width: 258px;
            height: 124px;
            border: 1px solid #1783c7;
            overflow: hidden;
            position: absolute;
            top: 82px;
            left: 20px;
        }
    </style>

</head>
<body style="background: #fff;">
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HCourceType" value="" />
        <input type="hidden" id="HStatus" value="" />

        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="course_form_div">
                    <label for="">视频名称：</label>
                    <input type="text" placeholder="视频名称" class="text" id="VideoName" maxlength="20" />
                </div>
                <div style="clear: both"></div>

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
            <div style="clear: both"></div>
            <div class="course_form_div clearfix" style="margin: 0px auto 0px 20px; text-align: center; bottom: 14px; position: absolute;">
                <input type="button" class="course_btn confirm_btn" onclick="EditeVideo()" id="btnCreate" value="确定" style="border: none;" />
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script src="../Scripts/Webuploader/dist/webuploader.js"></script>


    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            $("#VideoName").val(decodeURI(UrlDate.Name));
            $("#img_Pic").attr("src", UrlDate.ImageUrl);
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
                   case "Q_EXCEED_NUM_LIMIT":
                       alert('文件个数超出限制');
                       break;
                   default:
                       alert('错误: ' + code);
                       break;
               }
           };
        })
        //添加数据
        function EditeVideo() {

            var ID = UrlDate.ID;
            var NewName = $("#VideoName").val().trim();
            var VideoImg = $("#img_Pic").attr("src");

            if (!NewName.length) {
                layer.msg("视频名称为空");
            }
            else if (!VideoImg.length) {
                layer.msg("请选择封面图片");
            }
            else {
                $.ajax({
                    url: "../ResourceManage/ResourceHander.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        func: "EditVideo", ID: ID, NewName: NewName, FileUrl: UrlDate.FileUrl, oldName: decodeURI(UrlDate.Name), VideoImg: VideoImg
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            parent.layer.msg('操作成功!');
                            parent.BindWeikeResource();
                            parent.CloseIFrameWindow();
                        }
                        else {
                            layer.msg(result.errMsg);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.msg("操作失败！");
                    }
                });
            }
        }

    </script>
</body>
</html>
