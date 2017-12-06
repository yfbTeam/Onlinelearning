<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourceAdd_CM.aspx.cs" Inherits="SSSWeb.CourseManage.CourceAdd_CM" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>创建课程</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/choosen/chosen.css" rel="stylesheet" />
    <link href="../css/choosen/prism.css" rel="stylesheet" />
    <link href="../css/choosen/style.css" rel="stylesheet" />
    <link href="../Scripts/Webuploader/css/webuploader.css" rel="stylesheet" />

    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=2.0"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js?v=0.101"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/CourseManage/Term.js"></script>
    <script src="../Scripts/choosen/chosen.jquery.js"></script>
    <script src="../Scripts/choosen/prism.js"></script>

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
         .course_form_img{width:258px;height:124px;border: 1px solid #1783c7;overflow: hidden;position:absolute;right:0px;top:0px;}
        .course_form_img .change_picture{/*width:90px;height: 24px;line-height: 24px;background: #40bb6b;*/
                                         text-align: center;display: block;font-size: 12px;position:absolute;right:0;top:0;color:#fff;z-index: 2;cursor: pointer;
                                         margin-top:0px;
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
                <div class="clearfix pr">
                    <div class="course_form_div">
                        <label for="">课程名称：</label>
                        <input type="text" placeholder="课程名称" class="text" id="CourceName" maxlength="20" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_select fl">
                        <label for="">课程分类：</label>

                        <select id="Catagory">
                            <option value="0">==课程分类==</option>
                            <option value="1">入职培训</option>
                            <option value="2">学习提升</option>
                            <option value="3">专业技能</option>
                        </select><i class="stars"></i>
                    </div>
                    <div style="clear: both"></div>
                    <div class="course_form_select fl">
                        <label for="">授课老师：</label>
                        <div class="fl" style="width: 191px;">
                            <select class="chosen-select" data-placeholder="授课老师" multiple="multiple" id="LecturerName">
                            </select>
                            <i class="stars" style="float: right;"></i>
                        </div>

                    </div>


                    <div class="course_form_img">
                        <img id="img_Pic" alt="" src="" />
                        <%--<img id="img_Pic" src="/images/mycourse_01.png" alt="" />--%>
                        <div class="change_picture">
                            <div id="filePicker">选择图片</div>
                            <%--<input type="file" id="uploadify" name="uploadify" />--%>
                        </div>
                        <%--<a href="#" onclick="$('#fimg_Asso').click();" class="change_picture">选择图片</a>--%>
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
                <div class="course_form_div fl" style="margin-top: 0;">
                    <label for="">上课地点：</label>
                    <input type="text" placeholder="上课地点" class="text" id="StudyPlace" style="width: 480px;" />
                </div>

                <div style="clear: both"></div>
                <div class="course_form_select">
                    <label for="">课程简介：</label>
                    <textarea name="" rows="" cols="" id="CourseIntro"></textarea>
                </div>


                <div class="course_form_div clearfix" style="text-align: center;">
                    <input type="button" class="course_btn confirm_btn" onclick="AddCource()" id="btnCreate" value="确定" style="border: none;" />
                </div>

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

            BindCourseCatagory();
            BindTeacher();
            var ID = GetUrlDate.ID;
            if (ID != undefined) {
                GetCourceByID(ID);
            }
            var config = {
                '.chosen-select': {},
                '.chosen-select-deselect': { allow_single_deselect: true },
                '.chosen-select-no-single': { disable_search_threshold: 10 },
                '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
                '.chosen-select-width': { width: "95%" }
            }
            for (var selector in config) {
                $(selector).chosen(config[selector]);
            }

        })
        function BindCourseCatagory() {
            $("#Catagory").html("<option value=''>==课程分类==</option>");
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,

                data: { PageName: "/CourseManage/Course_Catagory.ashx", Func: "GetData", },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var option = "<option value='" + this.ID + "'>" + this.Name + "</option>";
                            $("#Catagory").append(option);
                        });
                    }
                    else {
                        //$("#Catagory").html("暂无证书模板！");
                    }
                },
                error: function (errMsg) {
                    // $("#Certificate").html(errMsg);
                }
            });
        }
        
        function BindTeacher() {
            $("#LecturerName").html("");
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
                        $("#LecturerName").html(Option);
                        //$("#LecturerName").chosen({
                        //    allow_single_deselect: true,
                        //    disable_search_threshold: 10,
                        //    no_results_text: '未找到',
                        //    width: '178px'
                        //});

                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }

        //添加数据
        function AddCource() {

            var CreateUID = $("#HUserIdCard").val();
            var Name = $("#CourceName").val().trim();
            var CourceType = $("#Catagory").val();//.children('span').attr("value").trim();
            var CourseIntro = $("#CourseIntro").val();
            var CoursePic = $("#img_Pic").attr("src");
            var StudyPlace = $("#StudyPlace").val();
            var LecturerName = $("#LecturerName").val();
            var ID = "";
            if (GetUrlDate.ID != undefined) {
                ID = GetUrlDate.ID;
            }
            if (!Name.length || !LecturerName.length || !CourceType.length) {
                layer.msg("课程名称、负责讲师、课程类型！");
            }
            else {
                $.ajax({
                    url: "../Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "CourseManage/CourceManage.ashx",
                        func: "AddCource", Name: Name, CourceType: CourceType,
                        CourseIntro: CourseIntro, CoursePic: CoursePic, StudyPlace: StudyPlace,
                        LecturerName: LecturerName, ID: ID, CreateUID: CreateUID
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
        function GetCourceByID(ID) {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", PageIndex: 1, pageSize: 10, ID: ID, CourseType: "" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData.PagedData).each(function () {

                            $("#CourceName").val(this.Name);
                            $("#Catagory").val(this.CourceType);//.children('span').attr("value", this.CourceType)
                            //$("#LecturerName").val(this.LecturerName);
                            var TeaArry = this.LecturerName.toString().split(',');
                            for (var i = 0; i < TeaArry.length; i++) {
                                $("#LecturerName option[value='" + TeaArry[i] + "']").attr("selected", true);
                            }
                            $("#img_Pic").attr("src", this.ImageUrl);
                            $("#StudyPlace").val(this.StudyPlace);
                            $("#CourseIntro").val(this.CourseIntro);
                            $("#CerName").val(this.CerName);
                            $("#Model").val(this.CerModel);

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