<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonInfo.aspx.cs" Inherits="SSSWeb.PersonalOffice.PersonInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>个人信息</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <link href="../Scripts/Webuploader/css/webuploader.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=2.0"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js?v=0.101"></script>
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

        /*.course_form_img {
            width: 270px;
            height: 114px;
            border: 1px solid #C7DFF7;
            overflow: hidden;
            position: relative;
            top: 10px;
        }*/

        .course_form_img .uploadify-button {
            font-size: 14px;
            color: #fff;
            border: none;
            background: #19c857;
        }

        .change_picture {
            position: absolute;
            right: 0;
            top: 0;
        }

        .radio {
            line-height: 30px;
            vertical-align: middle;
            font-size: 14px;
            color: #666;
        }        .course_form_img{width:258px;height:124px;border: 1px solid #1783c7;overflow: hidden;position:absolute;right:0px;top:0px;}
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
    <form id="registerform" name="registerform" class="registerform" runat="server">
        <input type="hidden" id="CreateUID" />
        <input type="hidden" id="RegisterOrg" value="1000" />
        <div style="background: #fff; width: 600px; margin: 0 auto">
            <div class="newcourse_dialog_detail">

                <div class="clearfix pr">
                    <div class="course_form_div">
                        <label for="">用户账号：</label>
                        <label for="" id="LoginName">用户账号：</label>
                    </div>
                    <div class="course_form_div fl">
                        <label for="">用户姓名：</label>
                        <input type="text" placeholder="用户姓名" class="text" id="Name" />
                        <i class="stars"></i>
                    </div>
                    <div style="clear: both"></div>
                    <div class="course_form_div fl">
                        <label for="">用户昵称：</label>
                        <div class="fl" style="width: 193px;">
                            <input type="text" placeholder="用户昵称" class="text" id="Nickname" />
                            <i class="stars" style="float: right;"></i>
                        </div>

                    </div>
                    <div class="course_form_img">
                        <img id="img_Pic1" alt="" src="" />
                        <img id="img_Pic" alt="" src="" style="display: none" />
                        <div class="change_picture">
                            <input type="file" id="uploadify" name="uploadify" />
                        </div>
                    </div>
                    <%--<div class="course_form_img">
                        <img id="img_Pic" alt="" src="" />
                        <div class="change_picture">
                            <div id="filePicker">选择图片</div>
                        </div>
                    </div>--%>
                    <style>
                        .course_form_img .uplo y-button {
                            font-size: 14px;
                            color: #fff;
                            border: none;
                            background: #19c857;
                        }
                    </style>

                </div>

                <div class="course_form_div fl" style="margin-top: 0;">
                    <label for="">出生日期：</label>
                    <input type="text" placeholder="出生日期" class="text" id="Birthday" onclick="WdatePicker({ skin: 'whyGreen', dateFmt: 'yyyy-MM-dd' });" />
                    <i class="stars"></i>
                </div>

                <div class="course_form_div fr" style="margin-top: 0;">
                    <label for="">联系电话：</label>
                    <input type="text" placeholder="联系电话" class="text" id="Phone" />
                </div>


                <div class="course_form_select clearfix fl">
                    <label for="" class="row_label fl">用户性别：</label>
                    <select id="Sex">
                        <option value="1">男</option>
                        <option value="0">女</option>
                    </select>
                    <%--<div class="radio">
                        <input type="radio" name="Sex" id="" value="1" />
                        <label for="">男</label>
                        <input type="radio" name="Sex" id="" value="0" checked="checked" />
                        <label for="">女</label>
                    </div>--%>
                </div>

                <div class="course_form_div clearfix fr">
                    <label for="" class="row_label fl">身份证号：</label>

                    <input type="text" placeholder="身份证号" class="text" id="IDCard" />

                </div>
                <div class="course_form_div clearfix fl">
                    <label for="" class="row_label fl">邮箱地址：</label>

                    <input type="text" placeholder="邮箱地址" class="text" id="Email" />

                </div>
                <div style="clear: both;"></div>
                <div class="course_form_div clearfix">
                    <label for="" class="row_label fl">用户住址：</label>

                    <input type="text" placeholder="用户住址" class="text" class="text" id="Address" style="width: 488px;" />

                </div>
                <div class="course_form_div clearfix">
                    <label for="" class="row_label fl">用户备注：</label>

                    <input type="text" placeholder="备注" class="text" id="Remarks" style="width: 488px;" />

                </div>
            </div>
            <div class="course_form_div clearfix" style="text-align: center;">
                <input type="button" class="course_btn confirm_btn" onclick="EditUser()" id="btnCreate" value="确定" style="border: none;" />
            </div>
        </div>
        <script src="../Scripts/Webuploader/dist/webuploader.js"></script>

    </form>
    <%--头像上传--%>
    <script type="text/javascript">

        $(function () {

            $("#uploadify").uploadify({
                'auto': true,                      //是否自动上传
                'swf': '../Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': 'http://222.35.226.155:7002/UserManage/Uploade.ashx',
                'formData': { Func: "UplodPhoto" }, //参数

                'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                'buttonText': '选择图片',//按钮文字
                // 'cancelimg': 'uploadify/uploadify-cancel.png',
                'width': 83,
                'height': 28,
                //最大文件数量'uploadLimit':
                'multi': false,//单选            
                'fileSizeLimit': '20MB',//最大文档限制
                'queueSizeLimit': 1,  //队列限制
                'removeCompleted': true, //上传完成自动清空
                'removeTimeout': 0, //清空时间间隔
                //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
                'onUploadSuccess': function (file, data, response) {
                    var json = $.parseJSON(data);
                    $("#img_Pic1").attr("src", "http://222.35.226.155:7002/" + json.url);
                    $("#img_Pic").attr("src", json.url);

                },
                //返回一个错误，选择文件的时候触发             
                'onUploadError': function (file, errorCode, errorMsg, errorString) {
                    alert('文件 ' + file.name + '上传失败: ' + errorString);
                },
                //检测FLASH失败调用              
                'onFallback': function () {
                    alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");
                },
                'onAllComplete': function (event, data) {
                    alert(data.filesUploaded + '个图片上传成功');
                }
            });

        })
        //  WebUploader.create({
        //      pick: '#filePicker',
        //      formData: { Func: "Uplod" },
        //      accept: {
        //          title: 'Images',
        //          extensions: 'jpg,gif,png,jpeg',
        //          mimeTypes: 'image/!*'
        //      },
        //      auto: true,
        //      chunked: false,
        //      chunkSize: 512 * 1024,
        //      server: '/CourseManage/UploadHtml5.ashx',
        //      // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
        //      disableGlobalDnd: true,
        //      fileNumLimit: 1,
        //      fileSizeLimit: 200 * 1024 * 1024,    // 200 M
        //      fileSingleSizeLimit: 50 * 1024 * 1024    // 50 M
        //  })
        //.on('uploadSuccess', function (file, response) {

        //    var json = $.parseJSON(response._raw);
        //    $("#img_Pic").attr("src", json.result.retData);

        //}).onError = function (code) {
        //    switch (code) {
        //        case 'exceed_size':
        //            alert('文件大小超出');
        //            break;

        //        case 'interrupt':
        //            alert('上传暂停');
        //            break;

        //        default:
        //            alert('错误: ' + code);
        //            break;
        //    }
        //};

    </script>
    <%--数据操作--%>
    <script type="text/javascript">
        $(function () {
            BindUser();
        })
        function BindUser() {
            $.ajax({
                url: "../SystemSettings/CommonInfo.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    func: "GetUserInfoData", "UniqueNos": '<%=UserInfo.UniqueNo %>', "parm": new Date().getTime()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        $(json.result.retData).each(function () {
                            var Bir = this.Birthday;

                            $("#UserType").val(this.UserType);
                            $("#Name").val(this.Name);
                            $("#Nickname").val(this.Nickname);
                            $("#Sex").val(this.Sex);
                            //$("input[name='Sex'][value=" + this.Sex + "]").attr("checked", true);
                            $("#Birthday").val(DateTimeConvert(Bir, "yyyy-MM-dd"));
                            $("#Phone").val(this.Phone);
                            $("#LoginName").html(this.LoginName);
                            $("#IDCard").val(this.IDCard);
                            if (this.HeadPic == "") {
                                $("#img_Pic1").attr("src", "../images/Ci27jlb8o1yAAVzUAAAXXN3q5BM579.jpg");
                            }
                            else {
                                $("#img_Pic1").attr("src", this.AbsHeadPic);
                            }
                            $("#img_Pic").attr("src", this.HeadPic);

                            $("#AuthenType").val(this.AuthenType);
                            $("#Address").val(this.Address);
                            $("#Remarks").val(this.Remarks);
                            $("#Email").val(this.Email);


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

       <%-- function BindUser() {
            var Bir = '<%=UserInfo.Birthday%>';

            $("#UserType").val('<%=UserInfo.UserType%>');
            $("#Name").val('<%=UserInfo.Name%>');
            $("#Nickname").val('<%=UserInfo.Nickname%>');
            $("input[name='Sex'][value=" + '<%=UserInfo.Sex%>' + "]").attr("checked", true);
            $("#Birthday").val(DateTimeConvert(Bir, "yyyy-MM-dd"));
            $("#Phone").val('<%=UserInfo.Phone%>');
            $("#LoginName").html('<%=UserInfo.LoginName%>');
            $("#IDCard").val('<%=UserInfo.IDCard%>');
            $("#img_Pic").attr("src", '<%=UserInfo.AbsHeadPic%>');
            $("#AuthenType").val('<%=UserInfo.AuthenType%>');
            $("#Address").val('<%=UserInfo.Address%>');
            $("#Remarks").val('<%=UserInfo.Remarks%>');
            $("#Email").val('');
        }--%>
        function EditUser() {
            var ID = '<%=UserInfo.Id %>';
            var Name = $("#Name").val();
            var Nickname = $("#Nickname").val();
            var Birthday = $("#Birthday").val();
            var Phone = $("#Phone").val();
            var IDCard = $("#IDCard").val();
            var HeadPic = $("#img_Pic").attr("src");
            if (HeadPic == "../images/Ci27jlb8o1yAAVzUAAAXXN3q5BM579.jpg") {
                HeadPic = "";
            }
            var Address = $("#Address").val();
            var Remarks = $("#Remarks").val();
            var Sex = $("input[name='Sex']:checked").val();
            var Email = $("#Email").val();
            $.ajax({
                url: "../SystemSettings/CommonInfo.ashx",
                type: "post",
                dataType: "json",
                data: {
                    func: "EditUser", Name: encodeURI(Name), Nickname: encodeURI(Nickname), UserType: '<%=UserInfo.UserType%>'
                    , Sex: Sex, Birthday: Birthday, Phone: Phone, IDCard: IDCard, ID: ID, LoginName: $("#LoginName").html()
                    , HeadPic: HeadPic.trim(), Address: Address, Remarks: Remarks, Email: Email
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('修改成功!');
                        //location.reload();
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

    </script>
</body>
</html>
