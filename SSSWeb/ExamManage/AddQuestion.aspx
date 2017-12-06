<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddQuestion.aspx.cs" Inherits="SSSWeb.ExamManage.AddQuestion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>添加试题</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.js"></script>
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/KindUeditor/kindeditor-min.js"></script>
    <script src="../Script/KindUeditor/plugins/code/prettify.js"></script>
    <script src="../Script/KindUeditor/lang/zh_CN.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../js/common.js"></script>
    <script src="CatagoryCommon.js"></script>
    <style>
        .upload_imga {
            margin-left: 70px;
            width: 100px;
        }

            .upload_imga img {
                max-width: 100px;
                height: auto;
            }

            .upload_imga .uploadify-button {
                font-size: 16px;
                border: none;
                background: #5493D7;
                color: #fff;
            }
    </style>
</head>
<body style="background: #fff;">
    <form id="form1" runat="server">
        <div>
            <asp:HiddenField ID="hIDCard" runat="server" />
            <asp:HiddenField ID="HSchoolID" runat="server" Value="1" />
            <asp:HiddenField ID="HPeriod" runat="server" />
            <asp:HiddenField ID="HSubject" runat="server" Value="1" />
            <asp:HiddenField ID="bookVersion" runat="server" />
            <asp:HiddenField ID="HTextboox" runat="server" Value="1" />
            <asp:HiddenField ID="HChapterID" runat="server" />
            <!--添加试题dialog-->
            <div class="dialog_detail">
                <h1 class="clearfix">
                    <div class="select_left fl">
                        当前选择：
                    </div>
                    <div class="select_right fl clearfix">

                        <div class="clearfix fl">
                            <i class="star"></i>
                            <label for="">学科：</label>
                            <select name="" class="select" id="se_subject" onchange="SubjectChange(this.value)">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">教材：</label>
                            <select name="" class="select" id="se_book" onchange="TextbookChange(this.value)">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">章：</label>
                            <select name="" class="select" id="se_chapter" onchange="ChapatorChange(this.value)">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">节：</label>
                            <select name="" class="select" id="se_part">
                                <%--<option value=""></option>--%>
                            </select>
                            <i class="star"></i>
                        </div>

                    </div>
                </h1>
                <div class="row clearfix mt10">
                    <div class="clearfix">
                        <div class="clearfix fl">
                            <label for="">题型：</label>
                            <select name="" class="select" id="a_type" onchange="ChangeQType()">
                            </select>

                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">难易程度：</label>
                            <select class="select" id="as_difficult">
                                <option value="0" selected="selected">请选择</option>
                                <option value="1">简单</option>
                                <option value="2">中等</option>
                                <option value="2">困难</option>
                            </select>

                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">状态：</label>
                            <select class="select" id="as_status">
                                <option value="1" selected="selected">启用</option>
                                <option value="2">禁用</option>
                            </select>

                            <i class="star"></i>
                        </div>
                    </div>
                </div>
                <div class="row clearfix mt10">
                    <label for="">题干：</label>
                    <div class="froala">
                        <textarea id="Question" name="Question" class="questionarea" placeholder="请输入备注"></textarea>
                    </div>
                </div>
                <div class="row clearfix mt10">
                    <label for="">分数：</label>
                    <input type="text" class="txt" id="a_score" placeholder="请输入分数" />
                    <i class="star"></i>
                </div>
                <div class="row clearfix mt10 radio none">
                    <label for="">选项：</label>
                    <p class="clearfix">
                        <input id="rdoOptionA" name="answer" type="radio" value="A" /><input id="OptionA" type="text" name="OptionA" placeholder="请输入A选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionA" alt="" />
                            <input type="file" id="uploadifyOptionA" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionB" name="answer" type="radio" value="B" /><input id="OptionB" type="text" name="OptionB" placeholder="请输入B选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionB" alt="" />
                            <input type="file" id="uploadifyOptionB" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionC" name="answer" type="radio" value="C" /><input id="OptionC" type="text" name="OptionC" placeholder="请输入C选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionC" alt="" />
                            <input type="file" id="uploadifyOptionC" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionD" name="answer" type="radio" value="D" /><input id="OptionD" type="text" name="OptionD" placeholder="请输入D选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionD" alt="" />
                            <input type="file" id="uploadifyOptionD" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionE" name="answer" type="radio" value="E" /><input id="OptionE" type="text" name="OptionE" placeholder="请输入E选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionE" alt="" />
                            <input type="file" id="uploadifyOptionE" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionF" name="answer" type="radio" value="F" /><input id="OptionF" type="text" name="OptionF" placeholder="请输入F选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionF" alt="" />
                            <input type="file" id="uploadifyOptionF" name="uploadify" />
                        </div>
                    </p>
                </div>
                <div class="row clearfix mt10 judge none">

                    <label for="">选项：</label>
                    <p class="clearfix">
                        <input id="rdoOpA" name="panswer" type="radio" value="A" /><label for="">正确</label>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOpB" name="panswer" type="radio" value="B" /><label for="">错误</label>
                    </p>
                </div>
                <div class="row clearfix mt10 checkbox none">

                    <p class="clearfix">
                        <input id="cbOptionA" name="danswer" type="checkbox" value="A" /><input id="ckOptionA" type="text" name="OptionA" placeholder="请输入A选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionA" alt="" />
                            <input type="file" id="uploadifyckOptionA" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionB" name="danswer" type="checkbox" value="B" /><input id="ckOptionB" type="text" name="OptionB" placeholder="请输入B选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionB" alt="" />
                            <input type="file" id="uploadifyckOptionB" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionC" name="danswer" type="checkbox" value="C" /><input id="ckOptionC" type="text" name="OptionC" placeholder="请输入C选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionC" alt="" />
                            <input type="file" id="uploadifyckOptionC" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionD" name="danswer" type="checkbox" value="D" /><input id="ckOptionD" type="text" name="OptionD" placeholder="请输入D选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionD" alt="" />
                            <input type="file" id="uploadifyckOptionD" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionE" name="danswer" type="checkbox" value="E" /><input id="ckOptionE" type="text" name="OptionE" placeholder="请输入E选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionE" alt="" />
                            <input type="file" id="uploadifyckOptionE" name="uploadify" />
                        </div>
                    </p>
                    <p class="row clearfix">
                        <input id="cbOptionF" name="danswer" type="checkbox" value="F" /><input id="ckOptionF" type="text" name="OptionF" placeholder="请输入F选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionF" alt="" />
                            <input type="file" id="uploadifyckOptionF" name="uploadify" />
                        </div>
                    </p>
                </div>
                <div id="answerdiv" class="row clearfix canswer mt10 none">
                    <label for="">答案：</label>
                    <div class="froala">
                        <textarea id="canswer" name="canswer" class="Analysisarea" placeholder="请输入答案"></textarea>
                    </div>
                </div>
                <div class="row clearfix">
                    <label for="">解析（可为空）：</label>
                    <input type="radio" id="rdoisshowY" name="isshowanalysis" value="1" /><label for="">显示</label><input type="radio" id="rdoisshowN" name="isshowanalysis" value="2" checked="checked" /><label for="">不显示</label>
                    <div class="clear"></div>
                    <div class="froala">
                        <textarea id="Analysis" name="Analysis" class="Analysisarea" placeholder="请输入解析，可以为空"></textarea>
                    </div>
                </div>
                <div class="row clearfix">
                    <div class="row clearfix">
                        <input type="button" value="确定添加" onclick="Save()" class="btn" />
                    </div>
                </div>
    </form>
</body>
</html>
<script type="text/javascript">
    var UrlDate = new GetUrlDate();
    $(function () {
        BindCatagory();

        var srcc = "OptionA,OptionB,OptionC,OptionD,OptionE,OptionF,ckOptionA,ckOptionB,ckOptionC,ckOptionD,ckOptionE,ckOptionF"//,canswer";
        srcc = srcc.split(",");
        BindType();
        for (var i = 0; i < srcc.length; i++) {
            src(srcc[i]);
        }
    });

    //绑定试题类型
    function BindType() {
        var html = '<option value="0">请选择</option>';
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名"
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "GetQuestionTypeList"
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    html += "<option value=\"" + this.ID + "\">" + this.Name + "</option>";
                });
                $("#a_type").html(html);
            },
            error: function (Msg) {
                layer.msg(Msg);
            }
        });
    }
    //根据所选不同类型试题，加载添加方式
    function ChangeQType() {
        $("#a_type").parents('.dialog_detail').find('.checkbox').hide();
        $("#a_type").parents('.dialog_detail').find('.radio').hide();
        $("#a_type").parents('.dialog_detail').find('.judge').hide();
        $("#a_type").parents('.dialog_detail').find('.canswer').hide();
        var QuestionTypeName = $("#a_type").find("option:selected").text();
        if (QuestionTypeName != "请选择") {
            if (QuestionTypeName == "多选题") {
                $("#a_type").parents('.dialog_detail').find('.checkbox').show();
            } else if (QuestionTypeName == "判断题") {
                $("#a_type").parents('.dialog_detail').find('.judge').show();
            } else if (QuestionTypeName == "单选题") {
                $("#a_type").parents('.dialog_detail').find('.radio').show();
            } else {
                $("#a_type").parents('.dialog_detail').find('.canswer').show();
            }
        }
    }

    function src(srcc) {
        $("#uploadify" + srcc + "").uploadify({
            'auto': true,                      //是否自动上传
            'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
            'uploader': '/CourseManage/Uploade.ashx',
            'formData': { Func: "SetImage" }, //参数
            'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
            'buttonText': '选择图片',//按钮文字
            'width': 100,
            'height': 30,
            'multi': false,//单选            
            'fileSizeLimit': '20MB',//最大文档限制
            'queueSizeLimit': 1,  //队列限制
            'removeCompleted': true, //上传完成自动清空
            'removeTimeout': 0, //清空时间间隔
            'onUploadSuccess': function (file, data, response) {
                var json = $.parseJSON(data);

                $("#img_Pic" + srcc + "").attr("src", json.result.retData);
                $("#" + srcc + "").attr("value", json.result.retData);

                //$("#img_Pic").val(data);
            },
            'onUploadError': function (file, errorCode, errorMsg, errorString) {
                alert('文件 ' + file.name + '上传失败: ' + errorString);
            },
            //检测FLASH失败调用              
            'onFallback': function () {
                alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");
            },

        });
    }
    var Analysiseditor;
    var Questioneditor;
    var Answereditor;

    KindEditor.ready(function (K) {
        Questioneditor = K.create('#Question', {
            uploadJson: 'ExamHandler.ashx?action=Upload_json',
            //fileManagerJson: HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
            //allowFileManager: true,
            width: '694px',
            minWidth: '600px',
            items: [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
            afterBlur: function () { this.sync(); }
        });
        Analysiseditor = K.create('#Analysis', {
            uploadJson: HanderServiceUrl + 'ExamHandler.ashx?action=Upload_json',
            //fileManagerJson:HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
            //allowFileManager: true,
            width: '600px',
            minWidth: '600px',
            items: [
                      'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                      'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                      'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
            afterBlur: function () { this.sync(); }
        });
        Answereditor = K.create('#canswer', {
            uploadJson: HanderServiceUrl + 'ExamHandler.ashx?action=Upload_json',
            //fileManagerJson:HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
            //allowFileManager: true,
            width: '600px',
            minWidth: '600px',
            items: [
                      'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                      'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                      'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
            afterBlur: function () { this.sync(); }
        });
    })
    function Save() {
        if ($('#se_subject').val() != "" && $("#se_book").val() != "" && $("#se_chapter").val() != "" && $("#se_part").val() != "") {
            var Analysis = Analysiseditor.text();
            var Question = Questioneditor.text();
            var Subject = $('#se_subject').val();
            var Major = $('#se_subject').val();
            var Book = $("#se_book").val();
            var Chapter = $('#se_part').val();
            var Part = $('#se_part').val();
            var Type = $('#a_type').val();
            var Difficulty = $('#as_difficult').val();
            var Status = $('#as_status').val();
            var Title = $('#Question').val();
            var CAnswer = Answereditor.text();//
            var OptionA = "";
            var OptionB = "";
            var OptionC = "";
            var OptionD = "";
            var OptionE = "";
            var OptionF = "";
            var Answer = "";
            var isshowanalysis = $('input[name="isshowanalysis"]:checked').val();
            //获取选项
            if ($(".radio").css("display") == "block") {
                OptionA = $("input[id='OptionA']").val();
                OptionB = $("input[id='OptionB']").val();
                OptionC = $("input[id='OptionC']").val();
                OptionD = $("input[id='OptionD']").val();
                OptionE = $("input[id='OptionE']").val();
                OptionF = $("input[id='OptionF']").val();
                Answer = $(".radio input[name='answer']:checked").val();
            } else if ($(".checkbox").css("display") == "block") {
                OptionA = $("input[id='ckOptionA']").val();
                OptionB = $("input[id='ckOptionB']").val();
                OptionC = $("input[id='ckOptionC']").val();
                OptionD = $("input[id='ckOptionD']").val();
                OptionE = $("input[id='ckOptionE']").val();
                OptionF = $("input[id='ckOptionF']").val();
                //拼接答案
                $("input[name$='danswer']:checked").each(function () {
                    if (Answer == "") {
                        Answer = $(this).val();
                    }
                    else {
                        Answer = Answer + "&" + $(this).val();
                    }
                });
            } else if ($(".judge").css("display") == "block")//判断
            {
                OptionA = "正确";
                OptionB = "错误";
                Answer = $("input[name='panswer']:checked").val();
            }
            var score = $("#a_score").val();
            var IDCard = $("#hIDCard").val();
            if (CheckNull()) {
                //obj.disabled = true;
                $.ajax({
                    url: "../Common.ashx",//?action=AddExamQuestion&" + Math.random(),   // 提交的页面
                    type: "post",                   // 设置请求类型为"POST"，默认为"GET"
                    //async: false,
                    dataType: "json",
                    data: {
                        PageName: "/ExamManage/QuestionHander.ashx",
                        "action": "AddExamQuestion",
                        "Content": Question,
                        "Subject": Subject,
                        "Major": Major,
                        "Book": Book,
                        "Chapter": Chapter,
                        "Part": Part,
                        "Type": Type,
                        "Difficulty": Difficulty,
                        "Status": Status,
                        "Question": Question,
                        "OptionA": OptionA,
                        "OptionB": OptionB,
                        "OptionC": OptionC,
                        "OptionD": OptionD,
                        "OptionE": OptionE,
                        "OptionF": OptionF,
                        "Answer": Answer,
                        "CAnswer": CAnswer,
                        "Analysis": Analysis,
                        "isshowanalysis": isshowanalysis,
                        "CreateUID": IDCard,
                        "Score": score
                    },
                    beforeSend: function ()          // 设置表单提交前方法
                    {
                        //layer.msg("准备提交数据");


                    },
                    error: function (request) {      // 设置表单提交出错
                        //layer.msg("表单提交出错，请稍候再试");
                        //rebool = false;
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            parent.layer.msg('新增成功!');
                            parent.getData(1, 10);
                            parent.CloseIFrameWindow();
                        } else {
                            layer.msg(json.result.errMsg);
                        }
                    }

                });
            }
        } else {
            layer.msg('必须选择年级教材章和小节');
        }
    }
   


</script>
<script>
    var UrlDate = new GetUrlDate();
    function BindCatagory() {
        $.ajax({
            url: "../SystemSettings/EduHander.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",

            data: { "PageName": "/InitialDataHandler.ashx", "Func": "GetPSTVData" },
            success: function (json) {
                CatagoryJson = json;
                //学段
                BindPeriod();
                //版本
                TextbookVersion();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
   /* function BindCatagory() {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",

            data: { "PageName": "InitialDataHandler.ashx", "Func": "GetPSTVData" },
            success: function (json) {
                CatagoryJson = json;
                //学段
                BindSubject();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }*/
    //科目
    function BindSubject() {
        var HPeriod = $("#HPeriod").val();
        var HSubject = $("#HSubject").val();
        var option = "";
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            $(CatagoryJson.GradeOfSubject.retData).each(function () {
                if ((this.GradeID + "|" + this.SubjectID) == (HPeriod + "|" + HSubject)) {
                    option += "<option selected = selected value=\"" + this.GradeID + "|" + this.SubjectID + "\">(" + this.Name + ")" + this.SubjectName + "</option>";
                } else {
                    var SelPeriod = this.GradeID;
                    var SubjectID = this.SubjectID;
                    var SubjectName = this.SubjectName;
                    option += "<option value=\"" + this.GradeID + "|" + SubjectID + "\">(" + this.Name + ")" + this.SubjectName + "</option>";
                }

            })
        }
        else {
            layer.msg(CatagoryJson.GradeOfSubject.errMsg);
        }
        $("#se_subject").html(option);
        SubjectChange(HPeriod + "|" + HSubject);
    }
    function SubjectChange(idvalue) {
        var kk = "<option value=\"0\">请选择</option>";
        $("#se_book").html(kk);
        $("#se_chapter").html(kk);
        $("#se_part").html(kk);
        $("#se_book").empty();
        $("#se_chapter").empty();
        $("#se_part").empty();
        Textbook();
    }
    function ChapatorChange(idvalue) {
        $("#se_part").empty();
        Part();
    }
    function TextbookChange(idvalue) {
        var kk = "<option value=\"0\">请选择</option>";
        $("#se_chapter").html(kk);
        $("#se_part").html(kk);
        $("#se_chapter").empty();
        $("#se_part").empty();
        Chapator();
    }
    //教材
    function Textbook() {
        $("#se_book").html("");
        var option = "";
        var perandsub = $("#se_subject").val();
        if (perandsub == "0") {
            return;
        }
        var persubArray = perandsub.split("|");
        var currentPeriod = persubArray[0];
        var currentSubjectID = persubArray[1];
        if (CatagoryJson.Textbook.errNum.toString() == "0") {

            $(CatagoryJson.Textbook.retData).each(function () {
                //if (currentPeriod == this.GradeID && this.SubjectID == currentSubjectID) {
                if (currentPeriod == this.MajorID && this.SubID == currentSubjectID) {
                    option += "<option value='" + this.VersionID + "|" + this.ID + "'>(" + this.VersionName + ")" + this.Name + "</option>";
                }

            })

        }
        else {
            layer.msg(CatagoryJson.Textbook.errMsg);
        }
        $("#se_book").html(option);
        Chapator();
    }
    var partjson = "";
    function Chapator() {
        var HChapterID = $("#HChapterID").val();
        var option = "";
        var curbook = $("#se_book").val();
        if (curbook == "0") {
            $("#se_chapter").html(option);
            return;
        }
        $.ajax({
            url: "../SystemSettings/EduHander.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            //data: { "PageName": "TextbookCatalogHandler.ashx", "Func": "GetTextbookCatalogData" },
            data: { "PageName": "TextbookCatalogHandler.ashx", "Func": "GetBookCatalog", "IsPage": "false" },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    div = "";
                    var chapterjson = json.result.retData;
                    partjson = chapterjson;
                    $(chapterjson).each(function () {
                        if (this.BookID == curbook.split("|")[1] && this.Pid == 0) {
                            if (this.ID == UrlDate.HChapterPid) {
                                option += "<option value='" + this.ID + "' selected='selected'>" + this.Name + "</option>";
                            }
                            else {
                                option += "<option value='" + this.ID + "'>" + this.Name + "</option>";
                            }
                        }
                    });
                }
                else {
                    layer.msg(json.result.errMsg);
                }
                $("#se_chapter").html(option);
                ChapatorChange($("#se_chapter").val());

            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function Part() {
        var option = "";
        var curchapator = $("#se_chapter").val();
        if (curchapator == "0") {
            $("#se_part").html(option);
            return;
        }
        $(partjson).each(function () {
            if (this.Pid == curchapator) {
                if (this.Id == UrlDate.HChapterID) {
                    option += "<option value='" + this.ID + "' selected='selected'>" + this.Name + "</option>";
                }
                else {
                    option += "<option value='" + this.ID + "'>" + this.Name + "</option>";
                }
            }
        })
        $("#se_part").html(option);
    }

</script>
