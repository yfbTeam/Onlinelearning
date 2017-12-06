<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HtmlUploder.aspx.cs" Inherits="SSSWeb.ResourceManage.HtmlUploder" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>文件上传</title>
    <link href="../Scripts/Webuploader/css/webuploader.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js"></script>
    <link href="style.css" rel="stylesheet" />
     
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo%>" />

    <div id="wrapper">
        <div id="container">
            <!--头部，相册选择和格式选择-->

            <div id="uploader">
                <div class="queueList">
                    <div id="dndArea" class="placeholder">
                        <div id="filePicker"></div>
                        <p>或将文件拖到这里，单次上传个数<20个，单文件大小<200M，所有文件大小<500M</p>
                    </div>
                </div>
                <div class="statusBar" style="display: none;">
                    <div class="progress">
                        <span class="text">0%</span>
                        <span class="percentage"></span>
                    </div>
                    <div class="info"></div>
                    <div class="btns">
                        <div id="filePicker2"></div>
                        <div class="uploadBtn">开始上传</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../Scripts/Webuploader/dist/webuploader.js"></script>
    <script src="../Scripts/Webuploader/upload.js?parm=1.01"></script>

</body>
</html>
