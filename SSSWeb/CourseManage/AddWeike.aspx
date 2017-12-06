<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddWeike.aspx.cs" Inherits="SSSWeb.CourseManage.AddWeike" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>上传视频</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <%--<link href="../css/simple-demo.css" rel="stylesheet" />--%>
    <link href="../Scripts/Webuploader/css/webuploader.css" rel="stylesheet" />
    <link href="../ResourceManage/style.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../js/jquery-migrate-1.1.0.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=2.0"></script>
    <style>
        .progress {
            height: 10px;
            border-radius: 5px;
            overflow: hidden;
            width: 150px;
            margin: auto;
        }

        .progress-bar {
            height: 10px;
            background: #007cdb;
        }
    </style>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />

    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <%--<div style="background: #fff; height: 100%; padding-bottom: 20px;">
            <div id="drag-and-drop-zone" class="uploader">
                <div>拖动封面到这里</div>
                <img id="img_Pic" alt="" src="" style="height:40px;"/>
            </div>
            <div id="drag-and-drop-zone1" class="uploader">
                <div><a id="weike" class="or" style="color: #92aab0;" target="_blank">拖动微课视频到这里</a></div>

            </div>
            <div style="margin-top: 20px; text-align: center">
                <input id="Button1" type="button" value="确定" onclick="AddWeike()" style="border-radius: 3px; text-decoration: none; font-size: 14px; background-color: #0DA6EC; color: white; border: 0px; padding: 6px 15px; cursor: pointer;" />
            </div>
        </div>--%>
        <div id="wrapper">
            <div id="container">
                <!--头部，相册选择和格式选择-->
                <div style="margin-top: 20px; margin-left: 20px; text-align: left;">
                    <input id="Button1" type="button" value="确定" onclick="AddWeike()" style="border-radius: 3px; text-decoration: none; font-size: 14px; background-color: #0DA6EC; color: white; border: 0px; padding: 6px 15px; cursor: pointer;" />
                </div>
                <div id="uploader">
                    <div class="queueList">
                        <div id="dndArea" class="placeholder" style="min-height: 150px; background: url(/ResourceManage/image.png) center 13px no-repeat; padding-top: 75px;">
                            <div id="filePicker"></div>
                            <p>或将封面图片文件拖到这里</p>
                        </div>
                        <div style="max-height: 150px; text-align: center; display: block; border: 1px #dcdcdc solid; padding: 20px; display: none;" id="ShowImage">
                            <img id="img_Pic" alt="" src="" style="max-height: 150px; display: none;" />
                        </div>

                    </div>

                    <div class="queueList">
                        <div id="dndArea1" class="placeholder" style="min-height: 150px; background: url(/ResourceManage/image.png) center 13px no-repeat; padding-top: 75px;">
                            <div id="filePicker1"></div>
                            <p>或将视频文件拖到这里</p>
                        </div>
                    </div>
                    <div style="max-height: 150px; text-align: center; max-height: 150px; text-align: center; display: block; border: 1px #dcdcdc solid; margin: 20px; padding: 20px; display: none;" id="ShowImage1">
                        <%--<a id="weike" class="or" style="color: #ffffff; display: none;" target="_blank">点击查看视频</a>--%>
                    </div>
                    <div class="queueList none" id="ShowVideo">
                        <div class="placeholder webuploader-container" style='background: url("/image.png") no-repeat center 13px; padding-top: 75px; min-height: 150px;'>
                            <div class="webuploader-container">
                                <div class="webuploader-pick"><a id="weike" class="or" style="color: #ffffff;" target="_blank">点击查看视频</a></div>
                            </div>
                        </div>
                    </div>

                    <%--<div class="statusBar" style="display: none;">
                        <div class="progress">
                            <span class="text">0%</span>
                            <span class="percentage"></span>
                        </div>
                        <div class="info"></div>
                        <div class="btns">
                            <div id="filePicker2"></div>
                            <div class="uploadBtn">开始上传</div>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
        <script src="../Scripts/Webuploader/dist/webuploader.js"></script>
        <%--<script src="../Scripts/Webuploader/upload.js"></script>--%>
    </form>
    <script src="../js/common.js"></script>
    <%--<script src="../js/dmuploader.js"></script>--%>


    <script type="text/javascript">
        $(function () {
            uploader = WebUploader.create({
                //pick: {
                //    id: '#filePicker',
                //    label: '点击选择图片'
                //},
                pick: '#filePicker',
                auto: true,
                formData: {
                    Func: "UplodWeik", 'Type': 1, "UserIdCard": $("#HUserIdCard").val()
                },
                accept: {
                    title: 'Images',
                    extensions: 'jpg,gif,png,jpeg,mp4,mp3',
                    mimeTypes: 'image/!*'
                },
                //chunkSize: 512 * 1024,
                server: 'UploadHtml5.ashx',
                dnd: '#dndArea',
                // paste: '#uploader',

                // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
                disableGlobalDnd: true,
                //fileNumLimit: 1,
                //fileSizeLimit: 200 * 1024 * 1024,    // 500 M
                //fileSingleSizeLimit: 50 * 1024 * 1024    // 200 M
            }).on('dndAccept', function (items) {
                var denied = false,
                    len = items.length,
                    i = 0,
                    // 修改js类型
                    unAllowed = 'text/plain;application/javascript ';

                for (; i < len; i++) {
                    // 如果在列表里面
                    if (~unAllowed.indexOf(items[i].type)) {
                        denied = true;
                        break;
                    }
                }

                return !denied;
            });


            uploader.on('uploadSuccess', function (file, response) {

                var json = $.parseJSON(response._raw);
                var retD = json.result.retData;
                $("#img_Pic").attr("src", retD.toString().split('-')[1]);
            });
            uploader.onError = function (code) {
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

            $list = $("#ShowImage"),
            // 优化retina, 在retina下这个值是2
            ratio = window.devicePixelRatio || 1,

            // 缩略图大小
            thumbnailWidth = 120 * ratio,
            thumbnailHeight = 120 * ratio,

            // 当有文件添加进来的时候
            uploader.on('fileQueued', function (file) {
                $("#dndArea").hide();
                $("#ShowImage").show();
                var $li = $(
                  '<div id="' + file.id + '" class="file-item thumbnail">' +
                   '<img>' +
                   '<div class="info">' + file.name + '</div>' +
                  '</div>'
                  ),
                 $img = $li.find('img');


                // $list为容器jQuery实例
                $list.append($li);

                // 创建缩略图
                // 如果为非图片文件，可以不用调用此方法。
                // thumbnailWidth x thumbnailHeight 为 100 x 100
                uploader.makeThumb(file, function (error, src) {
                    if (error) {
                        //$img.replaceWith('<span>不能预览</span>');
                        $img.attr('src', '/images/art.png');
                        return;
                    }

                    $img.attr('src', src);
                }, thumbnailWidth, thumbnailHeight);
            });

            uploader.on('uploadProgress', function (file, percentage) {
                var $li = $('#' + file.id),
                 $percent = $li.find('.progress .progress-bar');

                // 避免重复创建
                if (!$percent.length) {
                    $percent = $('<div class="progress progress-striped active">' +
                     '<div class="progress-bar" role="progressbar" style="width: 0%">' +
                     '</div>' +
                    '</div>').appendTo($li).find('.progress-bar');
                }

                $li.find('p.state').text('上传中');

                $percent.css('width', percentage * 100 + '%');
            });

            uploader.on('uploadSuccess', function (file) {
                $('#' + file.id).find('p.state').text('已上传');
            });

            uploader.on('uploadError', function (file) {
                $('#' + file.id).find('p.state').text('上传出错');
            });

            uploader.on('uploadComplete', function (file) {
                //$('#' + file.id).find('.progress').fadeOut();
            });


            //===============================================================视频=================================================
            uploader1 = WebUploader.create({
                //pick: {
                //    id: '#filePicker1',
                //    label: '点击选择视频'
                //},
                pick: '#filePicker1',
                auto: true,
                formData: {
                    Func: "UplodWeik", 'Type': 2, "UserIdCard": $("#HUserIdCard").val(), "TableName": "ResourcesInfo"
                },
                accept: {
                    title: 'Video',
                    extensions: 'mp4,ogg,webm,flv,ogv,wmv,avi,wma,rmvb,rm,mp3,mid,3gp',
                    mimeTypes: 'image/!*'
                },
                chunkSize: 512 * 1024,
                server: 'UploadHtml5.ashx',
                dnd: '#dndArea1',
                // paste: '#uploader',

                // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
                disableGlobalDnd: true,
                //fileNumLimit: 1,
                fileSizeLimit: 1024 * 1024 * 1024,    // 500 M
                fileSingleSizeLimit: 1024 * 1024 * 1024    // 200 M
            }).on('dndAccept', function (items) {
                var denied = false,
                    len = items.length,
                    i = 0,
                    // 修改js类型
                    unAllowed = 'text/plain;application/javascript ';

                for (; i < len; i++) {
                    // 如果在列表里面
                    if (~unAllowed.indexOf(items[i].type)) {
                        denied = true;
                        break;
                    }
                }

                return !denied;
            });


            uploader1.on('uploadSuccess', function (file, response) {

                var json = $.parseJSON(response._raw);
                if (json.result.errNum == "0") {
                    var retD = json.result.retData;
                    $("#weike").attr("href", retD.toString().split('-')[1]);
                    $("#weike").attr("alt", retD.toString().split('-')[0]);
                }
                else {
                    layer.msg(json.result.errMsg);
                }
            });
            uploader1.onError = function (code) {
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

            $list1 = $("#ShowImage1"),
            // 优化retina, 在retina下这个值是2
            ratio = window.devicePixelRatio || 1,

            // 缩略图大小
            thumbnailWidth = 120 * ratio,
            thumbnailHeight = 120 * ratio,

            // 当有文件添加进来的时候
            uploader1.on('fileQueued', function (file) {
                if (file.name.indexOf(" ") == -1) {
                    $("#dndArea1").hide();
                    $("#ShowImage1").show();
                    var $li = $(
                      '<div id="' + file.id + '" class="file-item thumbnail">' +
                       '<img style="width:120px;height:120px;">' +
                       '<div class="info">' + file.name + '</div>' +
                      '</div>'
                      ),
                     $img = $li.find('img');


                    // $list为容器jQuery实例
                    $list1.append($li);

                    // 创建缩略图
                    // 如果为非图片文件，可以不用调用此方法。
                    // thumbnailWidth x thumbnailHeight 为 100 x 100
                    uploader1.makeThumb(file, function (error, src) {
                        if (error) {
                            $img.attr('src', '../images/video.png');
                            //$img.replaceWith('<span>不能预览</span>');
                            return;
                        }

                        $img.attr('src', src);
                    }, thumbnailWidth, thumbnailHeight);
                }
                else {
                    layer.msg("文件名称中含有非法字符");
                }
            });

            uploader1.on('uploadProgress', function (file, percentage) {
                var $li = $('#' + file.id),
                 $percent = $li.find('.progress .progress-bar');

                // 避免重复创建
                if (!$percent.length) {
                    $percent = $('<div class="progress progress-striped active">' +
                     '<div class="progress-bar" role="progressbar" style="width: 0%">' +
                     '</div>' +
                    '</div>').appendTo($li).find('.progress-bar');
                }

                $li.find('p.state').text('上传中');

                $percent.css('width', percentage * 100 + '%');
            });

            uploader1.on('uploadSuccess', function (file) {
                $('#' + file.id).find('p.state').text('已上传');
            });

            uploader1.on('uploadError', function (file) {
                $('#' + file.id).find('p.state').text('上传出错');
            });

            uploader1.on('uploadComplete', function (file) {
                //$('#' + file.id).find('.progress').fadeOut();
                //$("#ShowImage1").hide();
                //$("#ShowVideo").show();
            });
            uploader.addButton({
                id: '#filePicker',
                innerHTML: '点击选择封面'
            });
            uploader1.addButton({
                id: '#filePicker1',
                innerHTML: '点击选择视频'
            });
        });
    </script>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();

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

    <%--<script type="text/javascript">
        var UrlDate = new GetUrlDate();

        $('#drag-and-drop-zone1').dmUploader({
            url: 'Uploade.ashx?Func=UplodWeik&Type=2&UserIdCard=' + $("#HUserIdCard").val(),
            //data: { Func: "UplodWeik", Type: 2, UserIdCard: GetUrlDate.UserIdCard },
            dataType: 'json',
            //allowedTypes: '*',
            extFilter: 'mp4;ogg;webm;',

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
                alert('文件 \'' + file.name + '\' 格式错误,支持格式（.mp4,.ogg;.webm)');
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
                $("#img_Pic").attr("src", decodeURIComponent(data.url));
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
    </script>--%>
    <%--<script type="text/javascript">
        $(function () {
            var $wrap = $('#uploader'),

                // 文件容器
                //$queue = $('<ul class="filelist"></ul>')
                //    .appendTo($wrap.find('.queueList')),

                // 状态栏，包括进度和控制按钮
                //$statusBar = $wrap.find('.statusBar'),

                // 文件总体选择信息。
                //$info = $statusBar.find('.info'),

                // 上传按钮
               // $upload = $wrap.find('.uploadBtn'),

                // 没选择文件之前的内容。
                //$placeHolder = $wrap.find('.placeholder'),

                //$progress = $statusBar.find('.progress').hide(),

                // 添加的文件数量
                //fileCount = 0,

                // 添加的文件总大小
                //fileSize = 0,

                // 优化retina, 在retina下这个值是2
                //ratio = window.devicePixelRatio || 1,

                // 缩略图大小
                //thumbnailWidth = 110 * ratio,
                //thumbnailHeight = 110 * ratio,

                // 可能有pedding, ready, uploading, confirm, done.
                //state = 'pedding',

                // 所有文件的进度信息，key为file id
               // percentages = {},
                // 判断浏览器是否支持图片的base64
                //isSupportBase64 = (function () {
                //    var data = new Image();
                //    var support = true;
                //    data.onload = data.onerror = function () {
                //        if (this.width != 1 || this.height != 1) {
                //            support = false;
                //        }
                //    }
                //    data.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
                //    return support;
                //})(),
                //supportTransition = (function () {
                //    var s = document.createElement('p').style,
                //        r = 'transition' in s ||
                //                'WebkitTransition' in s ||
                //                'MozTransition' in s ||
                //                'msTransition' in s ||
                //                'OTransition' in s;
                //    s = null;
                //    return r;
                //})(),

                // WebUploader实例
                uploader;

            // 实例化
            uploader = WebUploader.create({
                pick: {
                    id: '#filePicker',
                    label: '点击选择图片'
                },
                auto: true,
                formData: {
                    Func: "UplodWeik", 'Type': 1, "UserIdCard": $("#HUserIdCard").val()
                },
                accept: {
                    title: 'Images',
                    extensions: 'jpg,gif,png,jpeg',
                    mimeTypes: 'image/!*'
                },
                dnd: '#dndArea',
                paste: '#uploader',
                //swf: '/Scripts/Webuploader/dist/Uploader.swf',
                //chunked: false,
                chunkSize: 512 * 1024,
                server: '/CourseManage/UploadHtml5.ashx',

                // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
                disableGlobalDnd: true,
                fileNumLimit: 20,
                fileSizeLimit: 200 * 1024 * 1024,    // 500 M
                fileSingleSizeLimit: 50 * 1024 * 1024    // 200 M
            });
            uploader.on('uploadSuccess', function (file, response) {

                var json = $.parseJSON(response._raw);
                var retD = json.result.retData;
                $("#dndArea").hide();
                $("#ShowImage").show();
                $("#img_Pic").attr("src", retD.toString().split('-')[1]);

            });
            // 拖拽时不接受 js, txt 文件。
            uploader.on('dndAccept', function (items) {
                var denied = false,
                    len = items.length,
                    i = 0,
                    // 修改js类型
                    unAllowed = 'text/plain;application/javascript ';

                for (; i < len; i++) {
                    // 如果在列表里面
                    if (~unAllowed.indexOf(items[i].type)) {
                        denied = true;
                        break;
                    }
                }

                return !denied;
            });
            /*
             //添加“添加文件”的按钮，
            uploader.addButton({
                id: '#filePicker2',
                label: '继续添加'
            });

            uploader.on('ready', function () {
                window.uploader = uploader;
            });

            // 当有文件添加进来时执行，负责view的创建
            function addFile(file) {
                var $li = $('<li id="' + file.id + '">' +
                        '<p class="title">' + file.name + '</p>' +
                        '<p class="imgWrap"></p>' +
                        '<p class="progress"><span></span></p>' +
                        '</li>'),

                    $btns = $('<div class="file-panel">' +
                        '<span class="cancel">删除</span>' +
                        '<span class="rotateRight">向右旋转</span>' +
                        '<span class="rotateLeft">向左旋转</span></div>').appendTo($li),
                    $prgress = $li.find('p.progress span'),
                    $wrap = $li.find('p.imgWrap'),
                    //$info = $('<p class="error"></p>'),

                    showError = function (code) {
                        switch (code) {
                            case 'exceed_size':
                                text = '文件大小超出';
                                break;

                            case 'interrupt':
                                text = '上传暂停';
                                break;

                            default:
                                text = '上传失败，请重试';
                                break;
                        }

                        //$info.text(text).appendTo($li);
                    };

                if (file.getStatus() === 'invalid') {
                    showError(file.statusText);
                } else {
                    // @todo lazyload
                    $wrap.text('预览中');
                    uploader.makeThumb(file, function (error, src) {
                        var img;

                        if (error) {
                            $wrap.text('不能预览');
                            return;
                        }

                        if (isSupportBase64) {
                            img = $('<img src="' + src + '">');
                            $wrap.empty().append(img);
                        } else {
                            $.ajax('../../server/preview.php', {
                                method: 'POST',
                                data: src,
                                dataType: 'json'
                            }).done(function (response) {
                                if (response.result) {
                                    img = $('<img src="' + response.result + '">');
                                    $wrap.empty().append(img);
                                } else {
                                    $wrap.text("预览出错");
                                }
                            });
                        }
                    }, thumbnailWidth, thumbnailHeight);

                    percentages[file.id] = [file.size, 0];
                    file.rotation = 0;
                }

                file.on('statuschange', function (cur, prev) {
                    if (prev === 'progress') {
                        $prgress.hide().width(0);
                    } else if (prev === 'queued') {
                        $li.off('mouseenter mouseleave');
                        $btns.remove();
                    }

                    // 成功
                    if (cur === 'error' || cur === 'invalid') {
                        console.log(file.statusText);
                        showError(file.statusText);
                        percentages[file.id][1] = 1;
                    } else if (cur === 'interrupt') {
                        showError('interrupt');
                    } else if (cur === 'queued') {
                        percentages[file.id][1] = 0;
                    } else if (cur === 'progress') {
                        //$info.remove();
                        $prgress.css('display', 'block');
                    } else if (cur === 'complete') {
                        $li.append('<span class="success"></span>');
                        parent.getData(1, 10);
                    }

                    $li.removeClass('state-' + prev).addClass('state-' + cur);
                });

                $li.on('mouseenter', function () {
                    $btns.stop().animate({ height: 30 });
                });

                $li.on('mouseleave', function () {
                    $btns.stop().animate({ height: 0 });
                });

                $btns.on('click', 'span', function () {
                    var index = $(this).index(),
                        deg;

                    switch (index) {
                        case 0:
                            uploader.removeFile(file);
                            return;

                        case 1:
                            file.rotation += 90;
                            break;

                        case 2:
                            file.rotation -= 90;
                            break;
                    }

                    if (supportTransition) {
                        deg = 'rotate(' + file.rotation + 'deg)';
                        $wrap.css({
                            '-webkit-transform': deg,
                            '-mos-transform': deg,
                            '-o-transform': deg,
                            'transform': deg
                        });
                    } else {
                        $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + (~~((file.rotation / 90) % 4 + 4) % 4) + ')');

                    }


                });

                $li.appendTo($queue);
            }

            // 负责view的销毁
            function removeFile(file) {
                var $li = $('#' + file.id);

                delete percentages[file.id];
                updateTotalProgress();
                $li.off().find('.file-panel').off().end().remove();
            }
            
                        function updateTotalProgress() {
                            var loaded = 0,
                                total = 0,
                                //spans = $progress.children(),
                                percent;
            
                            $.each(percentages, function (k, v) {
                                total += v[0];
                                loaded += v[0] * v[1];
                            });
            
                            percent = total ? loaded / total : 0;
            
            
                            //spans.eq(0).text(Math.round(percent * 100) + '%');
                            //spans.eq(1).css('width', Math.round(percent * 100) + '%');
                            //updateStatus();
                        }
                        
                        function updateStatus() {
                            var text = '', stats;
            
                            if (state === 'ready') {
                                text = '选中' + fileCount + '个文件，共' +
                                        WebUploader.formatSize(fileSize) + '。';
                            } else if (state === 'confirm') {
                                stats = uploader.getStats();
                                if (stats.uploadFailNum) {
                                    text = '已成功上传' + stats.successNum + '个文件，' +
                                        stats.uploadFailNum + '个文件上传失败，<a class="retry" href="#">重新上传</a>失败文件或<a class="ignore" href="#">忽略</a>'
                                }
            
                            } else {
                                stats = uploader.getStats();
                                text = '共' + fileCount + '个（' +
                                        WebUploader.formatSize(fileSize) +
                                        '），已上传' + stats.successNum + '个';
            
                                if (stats.uploadFailNum) {
                                    text += '，失败' + stats.uploadFailNum + '个';
                                }
                            }
            
                            $info.html(text);
                        }*/
            /*
            function setState(val) {
                var file, stats;

                if (val === state) {
                    return;
                }

                //$upload.removeClass('state-' + state);
                //$upload.addClass('state-' + val);
                state = val;

                switch (state) {
                    case 'pedding':
                        $placeHolder.removeClass('element-invisible');
                        $queue.hide();
                        $statusBar.addClass('element-invisible');
                        uploader.refresh();
                        break;

                    case 'ready':
                        $placeHolder.addClass('element-invisible');
                        $('#filePicker2').removeClass('element-invisible');
                        $queue.show();
                        $statusBar.removeClass('element-invisible');
                        uploader.refresh();
                        break;

                    case 'uploading':
                        $('#filePicker2').addClass('element-invisible');
                        //$progress.show();
                        //$upload.text('暂停上传');
                        break;

                    case 'paused':
                        //$progress.show();
                       // $upload.text('继续上传');
                        break;

                    case 'confirm':
                        //$progress.hide();
                        $('#filePicker2').removeClass('element-invisible');
                        //$upload.text('开始上传');

                        stats = uploader.getStats();
                        if (stats.successNum && !stats.uploadFailNum) {
                            setState('finish');
                            return;
                        }
                        break;
                    case 'finish':
                        stats = uploader.getStats();
                        if (stats.successNum) {
                            //parent.getData(1, 10);
                            alert('上传成功');
                        } else {
                            // 没有成功的图片，重设
                            state = 'done';
                            location.reload();
                        }
                        break;
                }

                updateStatus();
            }

            uploader.onUploadProgress = function (file, percentage) {
                var $li = $('#' + file.id),
                    $percent = $li.find('.progress span');

                $percent.css('width', percentage * 100 + '%');
                percentages[file.id][1] = percentage;
                updateTotalProgress();
            };

            uploader.onFileQueued = function (file) {
                fileCount++;
                fileSize += file.size;

                if (fileCount === 1) {
                    $placeHolder.addClass('element-invisible');
                    $statusBar.show();
                }

                addFile(file);
                setState('ready');
                updateTotalProgress();
            };

            uploader.onFileDequeued = function (file) {
                fileCount--;
                fileSize -= file.size;

                if (!fileCount) {
                    setState('pedding');
                }

                removeFile(file);
                updateTotalProgress();

            };

            uploader.on('all', function (type) {
                var stats;
                switch (type) {
                    case 'uploadFinished':
                        setState('confirm');
                        break;

                    case 'startUpload':
                        setState('uploading');
                        break;

                    case 'stopUpload':
                        setState('paused');
                        break;

                }
            });

            uploader.onError = function (code) {
                alert('Eroor: ' + code);
            };
            */
            /*$upload.on('click', function () {
                if ($(this).hasClass('disabled')) {
                    return false;
                }

                if (state === 'ready') {
                    uploader.upload();
                } else if (state === 'paused') {
                    uploader.upload();
                } else if (state === 'uploading') {
                    uploader.stop();
                }
            });

            $info.on('click', '.retry', function () {
                uploader.retry();
            });

            $info.on('click', '.ignore', function () {
                alert('todo');
            });

            $upload.addClass('state-' + state);*/
            //updateTotalProgress();
        });
    </script>--%>
</body>
</html>


