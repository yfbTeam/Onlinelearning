<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditQuestion.aspx.cs" Inherits="SSSWeb.ExamManage.EditQuestion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>编辑试题</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link type="text/css" href="../css/common.css" rel="stylesheet" />
    <link type="text/css" href="../css/repository.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.js"></script>
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/KindUeditor/kindeditor-min.js"></script>
    <script src="../Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="../Scripts/KindUeditor/lang/zh_CN.js"></script>
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
        <input type="hidden" id="SubJectId" />
        <input type="hidden" id="VersionId" />
        <input type="hidden" id="ChapterId" />
        <div>
            <!--添加试卷dialog-->
            <div class="dialog_detail">
                <h1 class="clearfix">
                    <div class="select_left fl">
                        当前选择：
                    </div>
                    <div class="select_right fl clearfix">

                        <div class="clearfix fl">
                            <label for="">学科：</label>
                            <select name="xueke" class="select" id="se_subject" onchange="SubjectChange(this.value)">
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">教材：</label>
                            <select name="jiaocai" class="select" id="se_book" onchange="TextbookChange(this.value)">
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">章：</label>
                            <select name="" class="select" id="a_chapter" onchange="ChapatorChange(this.value)">
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">节：</label>
                            <select name="" class="select" id="a_part">
                            </select>
                            <i class="star"></i>
                        </div>

                    </div>
                </h1>
                <div class="row clearfix mt10">
                    <div class="clearfix">
                        <div class="clearfix fl">
                            <label for="">题型：</label>
                            <select name="" class="select" id="a_type" onchange="ChangeQType(this.value)">
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">难易程度：</label>
                            <select name="" class="select" id="as_difficult">
                                <option value="1">简单</option>
                                <option value="2">中等</option>
                                <option value="3">困难</option>
                            </select>
                            <i class="star"></i>
                        </div>
                        <div class="clearfix fl">
                            <label for="">状态：</label>
                            <select name="" class="select" id="a_status">
                                <option value="1" class="active">启用</option>
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
                            <img id="img_PicOptionC" />
                            <input type="file" id="uploadifyOptionC" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionD" name="answer" type="radio" value="D" /><input id="OptionD" type="text" name="OptionD" placeholder="请输入D选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionD" />
                            <input type="file" id="uploadifyOptionD" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionE" name="answer" type="radio" value="E" /><input id="OptionE" type="text" name="OptionE" placeholder="请输入E选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionE" />
                            <input type="file" id="uploadifyOptionE" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOptionF" name="answer" type="radio" value="F" /><input id="OptionF" type="text" name="OptionF" placeholder="请输入F选项内容" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicOptionF" />
                            <input type="file" id="uploadifyOptionF" name="uploadify" />
                        </div>
                    </p>
                </div>
                <div class="row clearfix mt10 judge none">
                    <p class="clearfix">
                        <input id="rdoOpA" name="panswer" type="radio" value="A" /><label for="">正确</label>
                    </p>
                    <p class="clearfix">
                        <input id="rdoOpB" name="panswer" type="radio" value="B" /><label for="">错误</label>
                    </p>
                </div>
                <div class="row clearfix mt10 checkbox none">

                    <p class="clearfix">
                        <input id="cbOptionA" name="danswer" type="checkbox" value="A" /><input id="ckOptionA" type="text" name="OptionA" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionA" />
                            <input type="file" id="uploadifyckOptionA" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionB" name="danswer" type="checkbox" value="B" /><input id="ckOptionB" type="text" name="OptionB" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionB" />
                            <input type="file" id="uploadifyckOptionB" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionC" name="danswer" type="checkbox" value="C" /><input id="ckOptionC" type="text" name="OptionC" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionC" />
                            <input type="file" id="uploadifyckOptionC" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionD" name="danswer" type="checkbox" value="D" /><input id="ckOptionD" type="text" name="OptionD" placeholder="请输入选项" class="txt" />

                        <div class="upload_imga">
                            <img id="img_PicckOptionD" />
                            <input type="file" id="uploadifyckOptionD" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionE" name="danswer" type="checkbox" value="E" /><input id="ckOptionE" type="text" name="OptionE" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionE" />
                            <input type="file" id="uploadifyckOptionE" name="uploadify" />
                        </div>
                    </p>
                    <p class="clearfix">
                        <input id="cbOptionF" name="danswer" type="checkbox" value="F" /><input id="ckOptionF" type="text" name="OptionF" placeholder="请输入选项" class="txt" />
                        <div class="upload_imga">
                            <img id="img_PicckOptionF" />
                            <input type="file" id="uploadifyckOptionF" name="uploadify" />
                        </div>
                    </p>
                </div>
                <div id="answerdiv" class="row clearfix canswer mt10">
                    <label for="">答案：</label>
                    <div class="froala">
                        <textarea id="canswer" name="canswer" class="Analysisarea" placeholder="请输入参考答案"></textarea>

                    </div>
                </div>

                <div class="row clearfix">
                    <label for="">解析：</label>
                    <input type="radio" id="rdoisshowY" name="isshowanalysis" value="1" /><label for="">显示</label><input type="radio" id="rdoisshowN" name="isshowanalysis" value="2" /><label for="">不显示</label>
                    <div class="clear"></div>
                    <div class="froala">
                        <textarea id="Analysis" name="Analysis" class="Analysisarea" placeholder="请输入解析"></textarea>

                    </div>

                </div>
                <div class="row clearfix">
                    <input type="button" value="确认修改" class="btn  " onclick="SaveEdit()" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    var UrlDate = new GetUrlDate();
    var Questioneditor;
    var Analysiseditor;
    var Answereditor;
    $(function () {
        var srcc = "OptionA,OptionB,OptionC,OptionD,OptionE,OptionF,ckOptionA,ckOptionB,ckOptionC,ckOptionD,ckOptionE,ckOptionF"//,canswer,Analysis";
        srcc = srcc.split(",");
        for (var i = 0; i < srcc.length; i++) {
            src(srcc[i]);
        }
        KindEditor.ready(function (K) {
            Questioneditor = K.create('#Question', {
                uploadJson: 'ExamHandler.ashx?action=Upload_json',
                //fileManagerJson: HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
                //allowFileManager: true,

                Width: '785px',
                items: [
                            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                            'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                            'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
                afterBlur: function () { this.sync(); }
            });
            Analysiseditor = K.create('#Analysis', {
                uploadJson: 'ExamHandler.ashx?action=Upload_json',
                //fileManagerJson:HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
                //allowFileManager: true,
                width: '694px',
                items: [
                          'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                          'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                          'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
                afterBlur: function () { this.sync(); }
            });
            Answereditor = K.create('#canswer', {
                uploadJson: 'ExamHandler.ashx?action=Upload_json',
                //fileManagerJson:HanderServiceUrl + '/SVDigitalCampus/ExamSystemHander/ExamSystemDataHander.aspx?action=FileManager',
                //allowFileManager: true,
                width: '650px',
                items: [
                          'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                          'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                          'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
                afterBlur: function () { this.sync(); }
            });
            BindQuestion();
            BindCatagory();
        });
    });
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
                var imgpic = json.result.retData;
                $("#img_Pic" + srcc + "").attr("src", json.result.retData);
                $("#" + srcc + "").attr("value", json.result.retData);

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

    function BindCatagory() {

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "InitialDataHandler.ashx", "Func": "GetPSTVData" },
            success: function (json) {
                CatagoryJson = json;
                BindSubject();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //科目
    function BindSubject() {
        $('#se_subject').html("");
        var SubJectId = $("#SubJectId").val();
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            $(CatagoryJson.GradeOfSubject.retData).each(function () {
                var Id = this.GradeID + "|" + this.SubjectID
                if (Id == SubJectId) {
                    $('#se_subject').append("<option value=\"" + Id + "\" selected='selected'>(" + this.GradeName + ")" + this.SubjectName + "</option>");
                    Textbook(this.GradeID, this.SubjectID);
                }
                else {
                    $('#se_subject').append("<option value=\"" + Id + "\">(" + this.GradeName + ")" + this.SubjectName + "</option>");
                }
            });
        }
        else {
            layer.msg(CatagoryJson.GradeOfSubject.errMsg);
        }
    }
    function SubjectChange(SubJectId) {
        $("#SubJectId").val(""); $("#VersionId").val(""); $("#ChapterId").val(""); $("#ChapterPId").val("");
        $("#se_book").html(""); $("#a_chapter").html(""); $("#a_part").html("");
        //var persubArray = idvalue.split("|");
        //var currentPeriod = persubArray[0];
        //var currentSubjectID = persubArray[1];
        Textbook(SubJectId.split("|")[0], SubJectId.split("|")[1]);
        //if ($("#se_book").val() != null) {
        //    var tChapatorid = $("#se_book").val();
        //    var tpersubArray = tChapatorid.split("|");
        //    var tcurrentPeriod = tpersubArray[0];
        //    var tcurrentSubjectID = tpersubArray[1];
        //    Chapator(tcurrentSubjectID, "");
        //}
        //else {
        //    Chapator(0, "");
        //}
        //var Partd = $("#a_chapter").val();
        //Part(Partd);
    }
    //教材
    function Textbook(GradeID, SubjectID) {
        var ooption = "";
        var VersionId = $("#VersionId").val();

        if (CatagoryJson.Textbook.errNum.toString() == "0") {
            var i = 0;
            $(CatagoryJson.Textbook.retData).each(function () {
                if (this.GradeID == GradeID && this.SubjectID == SubjectID) {
                    if (VersionId == "") {
                        if (i == 0) {
                            ooption += "<option value='" + this.VersionID + "|" + this.Id + "' selected='selected'>" + this.Name + "(" + this.VersionName + ")" + "</option>";
                            Chapator(this.Id);
                            i++;
                        }
                        else {
                            ooption += "<option value='" + this.VersionID + "|" + this.Id + "'>" + this.Name + "(" + this.VersionName + ")" + "</option>";
                            i++;
                        }
                    }
                    else {
                        if (this.VersionID + "|" + this.Id == VersionId) {
                            ooption += "<option value='" + this.VersionID + "|" + this.Id + "' selected='selected'>" + this.Name + "(" + this.VersionName + ")" + "</option>";
                            Chapator(this.Id);
                        }
                        else {
                            ooption += "<option value='" + this.VersionID + "|" + this.Id + "'>" + this.Name + "(" + this.VersionName + ")" + "</option>";
                        }
                    }
                }

            });
        }
        else {
            layer.msg(CatagoryJson.Textbook.errMsg);
        }
        $("#se_book").html(ooption);

    }
    function TextbookChange(VerSionId) {
        Chapator(VerSionId.split("|")[1]);
        //var Partd = $("#a_chapter").val();
        //Part(Partd);
    }
    var chapterjson = "";
    function Chapator(TextbooxID) {
        var ChapterId = $("#ChapterId").val();
        var ChapterPID = "";
        $("#a_chapter").html("");
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "TextbookCatalogHandler.ashx", "Func": "GetTextbookCatalogData" },
            success: function (json) {
                chapterjson = json.result.retData;
                if (json.result.errNum.toString() == "0") {
                    if (ChapterId != "") {

                        $(json.result.retData).each(function () {
                            if (this.Id == ChapterId) {
                                ChapterPID = this.PID;
                            }
                        });
                        $(json.result.retData).each(function () {
                            if (this.TextbooxID == TextbooxID && this.PID == "0") {
                                if (this.Id == ChapterPID) {
                                    $("#a_chapter").append("<option value='" + this.Id + "' selected='selected'>" + this.Name + "</option>");
                                    Part(this.Id);
                                }
                                else {
                                    $("#a_chapter").append("<option value='" + this.Id + "'>" + this.Name + "</option>");
                                }
                            }
                        });
                    }
                    else {
                        var j = 0;
                        $(json.result.retData).each(function () {
                            if (this.TextbooxID == TextbooxID && this.PID == "0") {
                                if (j == 0) {
                                    $("#a_chapter").append("<option value='" + this.Id + "' selected='selected'>" + this.Name + "</option>");
                                    Part(this.Id);
                                    j++;
                                }
                                else {
                                    $("#a_chapter").append("<option value='" + this.Id + "'>" + this.Name + "</option>");
                                    j++;
                                }
                            }
                        });
                    }
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
    function ChapatorChange(idvalue) {
        Part(idvalue);
    }
    function Part(idvalue) {
        var ChapterId = $("#ChapterId").val();
        $("#a_part").html("");
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "TextbookCatalogHandler.ashx", "Func": "GetTextbookCatalogData" },

            success: function (json) {
                $(json.result.retData).each(function () {
                    if (this.PID == idvalue) {
                        if (this.Id == ChapterId) {
                            $("#a_part").append("<option value='" + this.Id + "' selected='selected'>" + this.Name + "</option>");
                        }
                        else {
                            $("#a_part").append("<option value='" + this.Id + "'>" + this.Name + "</option>");
                        }
                    }
                });
            }
        })
    }

    function BindQuestion() {
        //根据不同题型调取不同的方法
        var FuncName = "";
        var QBigType = UrlDate.type;
        if (QBigType == "1")//客观题
        {
            FuncName = "GetExamObjQList";
        }
        else {
            FuncName = "GetExamSubQList";
        }
        var books = "";
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "ExamManage/QuestionHander.ashx", "action": FuncName, "ID": UrlDate.Id,"IsPage":"false"
            },
            success: function (json) {
                if (json.result.errNum == "0") {
                    var Data = json.result.retData[0];
                    var ArryCat = Data.Catagory.split("|");
                    var pid = 0;
                    var SubjectValue = ArryCat[0] + "|" + ArryCat[1];
                    var bookVersion = ArryCat[2] + "|" + ArryCat[3];
                    var Klpoint = Data.Klpoint;
                    $("#SubJectId").val(SubjectValue);
                    $("#VersionId").val(bookVersion);
                    $("#ChapterId").val(Klpoint);
                    BindType(Data.QType);
                    $("#as_difficult").val(Data.Difficulty);
                    $("#a_type").val(Data.TypeID);
                    $("#a_status").val(Data.Status);
                    if (Data.IsShowAnalysis == "1") {
                        $('#rdoisshowY').attr("checked", "checked");
                    } else {
                        $('#rdoisshowN').attr("checked", "checked");
                    }
                    $("#a_score").val(Data.Score);
                    Questioneditor.html(Data.Content);
                    Analysiseditor.html(Data.Analysis);
                    Answereditor.html(Data.Answer);

                    BindAnserByType(Data);
                }
                else {
                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                layer.msg('试题信息获取失败！');
            }
        });
    }
    //根据不同的试题类型绑定试题内容，控制不同形式内容显示
    function BindAnserByType(Data) {

        if (Data.TypeID == "1") {//单选

            $(".radio").show();
            $(".checkbox").hide();
            $(".canswer").hide();
            $(".judge").hide();

            //绑定选项
            var OptionA = Data.OptionA;
            var OptionB = Data.OptionB
            var OptionC = Data.OptionC
            var OptionD = Data.OptionD
            var OptionE = Data.OptionE
            var OptionF = Data.OptionF
            if (OptionA.indexOf('/') == 0) {
                $("#img_PicOptionA").attr("src", OptionA);
            } if (OptionB.indexOf('/') == 0) {
                $("#img_PicOptionB").attr("src", OptionB);
            }
            if (OptionC.indexOf('/') == 0) {
                $("#img_PicOptionC").attr("src", OptionC);
            }
            if (OptionD.indexOf('/') == 0) {
                $("#img_PicOptionD").attr("src", OptionD);
            }
            if (OptionE.indexOf('/') == 0) {
                $("#img_PicOptionE").attr("src", OptionE);
            }
            if (OptionF.indexOf('/') == 0) {
                $("#img_PicOptionF").attr("src", OptionF);
            }
            $("input[id='OptionA']").val(OptionA);
            $("input[id='OptionB']").val(OptionB);
            $("input[id='OptionC']").val(OptionC);
            $("input[id='OptionD']").val(OptionD);
            $("input[id='OptionE']").val(OptionE);
            $("input[id='OptionF']").val(OptionF);
            //绑定答案
            $(".radio input[name$='answer']").each(function () {
                if ($(this).val() == Data.Answer) {
                    this.checked = true;
                }
            });

        } else if (Data.TypeID == "2") {//多选

            $(".checkbox").show();
            $(".radio").hide();
            $(".canswer").hide();
            $(".judge").hide();
            //绑定选项
            $("#img_PicckOptionA").attr("src", Data.OptionA);
            $("#img_PicckOptionB").attr("src", Data.OptionB);
            $("#img_PicckOptionC").attr("src", Data.OptionC);
            $("#img_PicckOptionD").attr("src", Data.OptionD);
            $("#img_PicckOptionE").attr("src", Data.OptionE);
            $("#img_PicckOptionF").attr("src", Data.OptionF);
            $("input[id='ckOptionA']").val(Data.OptionA);
            $("input[id='ckOptionB']").val(Data.OptionB);
            $("input[id='ckOptionC']").val(Data.OptionC);
            $("input[id='ckOptionD']").val(Data.OptionD);
            $("input[id='ckOptionE']").val(Data.OptionE);
            $("input[id='ckOptionF']").val(Data.OptionF);
            //绑定答案
            var answers = Data.Answer.split("&");
            for (var i = 0; i < answers.length; i++) {
                $("input[name$='danswer']").each(function () {
                    if ($(this).val() == answers[i]) {
                        this.checked = true;
                    }
                });
            }
            //icochange();
        }
        else if (Data.TypeID == "3")//判断
        {
            $(".judge").show();
            $(".canswer").hide();
            $(".checkbox").hide();
            $(".radio").hide();
            //绑定答案
            if (Data.Answer.trim() == "A") {
                $("input[id='rdoOpA']").attr("checked", true);
            }
            else if (Data[0].Answer.trim() == "B") {
                $("input[id='rdoOpB']").attr("checked", true);
            }
        }
        else if (Data.TypeID == "4") {//文本
            $(".canswer").show();
            $(".checkbox").hide();
            $(".radio").hide();
            $(".judge").hide();
            //绑定答案
            $("#img_Piccanswer").attr("src", Data.Answer);
            $("#canswer").val(Data.Answer);
        }
    }

    function SaveEdit() {
        var Qid = UrlDate.Id;
        var qldtype = UrlDate.TypeID;
        var Analysis = Analysiseditor.text();
        var Question = Questioneditor.text();
        var Type = $('#a_type').val();
        var Difficulty = $('#as_difficult').val();
        var OptionA = "";
        var OptionB = "";
        var OptionC = "";
        var OptionD = "";
        var OptionE = "";
        var OptionF = "";
        var Answer = "";
        var isshowanalysis = $('input[name="isshowanalysis"]:checked').val();
        var CAnswer = Answereditor.text();
        var Status = $('#a_status').val();
        var score = $('#a_score').val();
        var Catagory = $('#se_subject').val() + '|' + $("#se_book").val();
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

        if (CheckNull()) {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "ExamManage/QuestionHander.ashx",
                    "action": "EditExamQuestion",
                    "QID": Qid,
                    "Type": Type,
                    "oldtype": qldtype,
                    "Question": Question,
                    "Answer": Answer,
                    "OptionA": OptionA,
                    "OptionB": OptionB,
                    "OptionC": OptionC,
                    "OptionD": OptionD,
                    "OptionE": OptionE,
                    "OptionF": OptionF,
                    "Difficulty": Difficulty,
                    "Catagory": Catagory,
                    "Status": Status,
                    "Analysis": Analysis,
                    "isshowanalysis": isshowanalysis,
                    "Title": Question,
                    "Score": score,
                    Klpoint: $("#a_part").val()
                },
                success: function (data) {
                    if (data.result.errNum.toString() == "0") {
                        parent.layer.msg('修改成功!');
                        parent.getData(1, 10);
                        parent.CloseIFrameWindow();
                    }
                    else {
                        parent.layer.msg('修改失败!');
                    }
                },
                error: function (errMsg) {

                    layer.msg('试题信息获取失败！');
                },
            });
        }
    }
    //根据主观题、客观题绑定试题类型
    function BindType(id) {

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "ExamManage/QuestionHander.ashx",
                "action": "GetQuestionTypeList"
            },
            success: function (json) {
                var httpl = "";
                $.each(json.result.retData, function () {
                    if (this.QType == id) {
                        httpl += "<option value=\"" + this.ID + "\">" + this.Name + "</option>";
                    }
                });
                $("#a_type").html(httpl);
            },
            error: function (ErrMsg) {
                layer.msg(ErrMsg);
            }
        });
    }
    function ChangeQType(did) {
        //题型判断
        $(".judge").hide();
        $(".radio").hide();
        $(".checkbox").hide();
        $(".canswer").hide();
        if (did != "0") {
            if (did == "2") {
                $(".checkbox").show();
            } else if (did == "6") {
                $(".judge").show();
            } else if (did == "1") {
                $(".radio").show();
            } else {
                $(".canswer").show();
            }
        }
    }

</script>
