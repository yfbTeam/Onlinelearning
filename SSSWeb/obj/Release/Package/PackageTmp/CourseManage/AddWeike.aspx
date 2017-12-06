<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddWeike.aspx.cs" Inherits="SSSWeb.CourseManage.AddWeike" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>上传微课</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/simple-demo.css" rel="stylesheet" />

    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/js/jquery-migrate-1.1.0.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HClassID" runat="server" />

    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff; height: 100%; padding-bottom: 80px;">
            <div id="drag-and-drop-zone" class="uploader">
                <div>拖动封面到这里</div>
                <img id="img_Pic" alt="" src="" />
            </div>
            <div id="drag-and-drop-zone1" class="uploader">
                <div><a id="weike" class="or" style="color:#92aab0;">拖动微课视频到这里</a></div>
                
            </div>
            <div style="margin-top: 20px; text-align: center">
                <input id="Button1" type="button" value="确定" onclick="AddWeike()" style="border-radius: 3px; text-decoration: none; font-size: 14px; background-color: #0DA6EC; color: white; border: 0px; padding: 6px 15px; cursor: pointer;" />
            </div>
        </div>
    </form>
    <script src="/js/common.js"></script>
    <%--<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>--%>
    <script src="/js/dmuploader.js"></script>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();

        $('#drag-and-drop-zone1').dmUploader({
            url: 'Uploade.ashx?Func=UplodWeik&Type=2&UserIdCard=' + $("#HUserIdCard").val(),
            //data: { Func: "UplodWeik", Type: 2, UserIdCard: GetUrlDate.UserIdCard },
            dataType: 'json',
            //allowedTypes: '*',
            extFilter: 'mp4;mav;mpeg;',

            onUploadSuccess: function (id, data) {
                var retD = data.result.retData;
                $("#weike").attr("href", retD.toString().split('-')[1]);
                $("#weike").attr("alt", retD.toString().split('-')[0]);

                $("#weike").html("点击查看");
                // $("#weike").attr("src", decodeURIComponent(data.url))
            },
            onUploadError: function (id, message) {
                alert("上传失败" + message);
            },
            onFileTypeError: function (file) {
                alert("所选文件格式不被支持" + file.name);
            },

            onFileSizeError: function (file) {
                alert("文件超过大小限制");
            },
            onFileExtError: function (file) {
                alert('文件 \'' + file.name + '\' 格式错误');
            },
            onFallbackMode: function (message) {
                alert('Browser not supported(do something else here!): ' + message);
            }
        });

        $('#drag-and-drop-zone').dmUploader({
            url: 'Uploade.ashx?Func=UplodWeik&Type=1&UserIdCard=' + $("#HUserIdCard").val(),
            dataType: 'json',
            extFilter: 'jpg;png;gif',
            onUploadSuccess: function (id, data) {
                $("#img_Pic").attr("src", data.url);
            },
            onUploadError: function (id, message) {
                alert("上传失败" + message);
            },
            onFileTypeError: function (file) {
                alert("所选文件格式不被支持" + file.name);
            },
            onFallbackMode: function (message) {
                alert('浏览器不支持' + message);
            }
        });
    </script>
    <script type="text/javascript">

        function AddWeike() {

            var weikePic = $("#img_Pic").attr("src");
            var weike = $("#weike").attr("alt");
            var CourceID = UrlDate.CourceID;
            var ChapterID = UrlDate.ChapterID;
            var IsVideo = UrlDate.IsVideo;
            $.ajax({
                url: "Uploade.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    func: "AddWeike", VidoeImag: weikePic, ResourcesID: weike, "CourceID": CourceID, "ChapterID": ChapterID, "IsVideo": IsVideo, "UserIdCard": $("#HUserIdCard").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        if (IsVideo == "1") {
                            parent.BindWeikeResource();
                        }
                        else {
                            parent.BindPutongResource();
                        }
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
</body>
</html>


