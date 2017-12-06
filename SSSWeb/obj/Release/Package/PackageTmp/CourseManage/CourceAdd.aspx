<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourceAdd.aspx.cs" Inherits="SSSWeb.CourseManage.CourceAdd" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>创建课程</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js?v=0.101"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/CourseManage/Term.js"></script>
    <script type="text/javascript">

        var GetUrlDate = new GetUrlDate();

        $(function () {
            //GetTermAndTime();
            //BindCatagory();
            //GetGrade();
            // GetClass();

            var ID = GetUrlDate.ID;
            if (ID != undefined) {
                $("#btnCreate").val("修改课程");
                GetCourceByID(ID);
            }
            else {
                $("#btnCreate").val("创建课程");
            }
        })
        function GradSelChange() {
            BindClass();
        }

        function BindCatagory() {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",

                data: { "Func": "Period" },
                success: function (json) {
                    CatagoryJson = json;
                    //科目
                    BindSubject();
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

        //科目
        function BindSubject() {
            var option = "";
            if (CatagoryJson.PeriodOfSubject.errNum.toString() == "0") {
                $(CatagoryJson.PeriodOfSubject.retData).each(function () {
                    var ID = this.PeriodID + "|" + this.SubjectID;
                    option += "<option value='" + ID + "'>" + this.SubjectName + "(" + this.PeriodName + ")</option>";
                })
                $("#Subject").append(option);
            }
            else {
                layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
            }
        }


        //年级
        function GetGrade() {
            //$("#Grade").html("");
            var option = "";// "<span value=\"0\">请选择年级</span><i class=\"icon icon-angle-down\"></i><div class=\"enable_wrap none\"><span value=\"0\" class=\"active\">请选择年级</span>";

            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { Func: "GetGrade" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            option += "<option value='" + this.Id + "'>" + this.GradeName + "</option>";
                        })
                        //option += "</div>";
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                    $("#Grade").append(option);
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        jsonClass = "";
        //班级
        function GetClass() {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { Func: "GetClass" },
                success: function (json) {
                    jsonClass = json;
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function BindClass() {
            var option = "";

            $("#Class").html("");
            if (jsonClass.result.errNum.toString() == "0") {
                var GradeID = $("#Grade").val();//.children('span').attr("value").trim()

                $(jsonClass.result.retData).each(function () {
                    if (this.GradeID == GradeID) {
                        option += "<input type=\"checkbox\" name=\"Ckclass\" id=\"\" value=\"" + this.Id
                            + "\" checked=\"checked\" /><label>" + this.ClassName + "</label>";
                    }
                });
                $("#Class").html(option);

            }
            else {
                layer.msg(json.result.errMsg);
            }
        }
        /*function ShowImage(file) { //展示图片        
            var prevImg = $("#img_Pic");
            if (file.files && file.files[0]) {
                var reader = new FileReader();
                reader.onload = function (evt) {
                    prevImg.attr("src", evt.target.result)
                    prevImg.src = evt.target.result;
                }
                reader.readAsDataURL(file.files[0]);
            }
            else {
                prevImg.style.display = "none";
                var divImg = document.getElementById('divImg');
                divImg.style.display = "block";
                divImg.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = file.value;
            }
        }*/
    </script>
    <script type="text/javascript">
        $(function () {

            $("#uploadify").uploadify({
                'auto': true,                      //是否自动上传
                'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': 'Uploade.ashx',
                'formData': { Func: "Uplod" }, //参数
                //'fileTypeDesc': '',
                'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                'buttonText': '选择图片',//按钮文字
                // 'cancelimg': 'uploadify/uploadify-cancel.png',
                'width': '100%',
                'height': 24,
                //最大文件数量'uploadLimit':
                'multi': false,//单选            
                'fileSizeLimit': '20MB',//最大文档限制
                'queueSizeLimit': 1,  //队列限制
                'removeCompleted': true, //上传完成自动清空
                'removeTimeout': 0, //清空时间间隔
                //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
                'onUploadSuccess': function (file, data, response) {
                    var json = $.parseJSON(data);
                    $("#img_Pic").attr("src", json.result.retData);

                    //$("#img_Pic").val(data);
                },
                //检测FLASH失败调用              
                'onFallback': function () {
                    alert("您未安装FLASH控件，无法上传课程封面图片！请安装FLASH控件后再试。");
                },
            });
        });

    </script>
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
                        <input type="text" placeholder="课程名称" class="text" id="CourceName" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div fl">
                        <label for="">开始时间：</label>
                        <input type="text" placeholder="开始时间" class="text" id="StartTime" onclick="javascript: WdatePicker({ maxDate: '#F{$dp.$D(\'EndTime\')}' });" /><i class="stars"></i>
                    </div>
                    <div style="clear: both"></div>
                    <div class="course_form_div fl">
                        <label for="">结束时间：</label>
                        <input type="text" placeholder="结束时间" class="text" id="EndTime" onclick="javascript: WdatePicker({ minDate: '#F{$dp.$D(\'StartTime\')}' });" /><i class="stars"></i>
                    </div>

                    <div class="course_form_img">
                        <img id="img_Pic" alt="" src="" />
                        <%--<img id="img_Pic" src="/images/mycourse_01.png" alt="" />--%>
                        <div class="change_picture">
                            <input type="file" id="uploadify" name="uploadify" />
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
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div fl">
                            <label for="">授课老师：</label>
                            <input type="text" placeholder="授课老师" class="text" id="LecturerName" value="" />

                            <%--<input type="text" placeholder="人数限制" class="text" id="StuMaxCount" value="0" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />--%>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div fr">
                            <label for="">上课地点：</label>
                            <input type="text" placeholder="上课地点" class="text" id="StudyPlace" />
                        </div>

                        <div style="clear: both"></div>
                        <div class="course_form_select">
                            <label for="">课程简介：</label>
                            <textarea name="" rows="" cols="" id="CourseIntro"></textarea>
                        </div>


                        <div class="course_form_select clearfix">
                            <a class="course_btn confirm_btn" onclick="AddCource()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="/js/common.js"></script>
    <script>
        $(function () {
            ChangeRigist();
            ChargeChange();
        })
        function ChargeChange() {
            var Charge = $("input[name='ChargeRadio']:checked").val();
            if (Charge == "1") {
                $("#ChargeCourse").show();
            }
            else {
                $("#ChargeCourse").hide();
            }
        }
        function ChangeRigist() {
            var RigistType = $("input[name='RigistRadio']:checked").val();
            if (RigistType == "1") {
                $("#Course_SecurityCode").show();
            }
            else {
                $("#Course_SecurityCode").hide();
            }
        }

        //添加数据
        function AddCource() {

            var CreateUID = $("#HUserIdCard").val();
            var Name = $("#CourceName").val().trim();
            var CatagoryID = "0";
            var CourceType = $("#CourceType").val();//.children('span').attr("value").trim();
            var IsCharge = $("input[name='ChargeRadio']:checked").val();
            var CourseIntro = $("#CourseIntro").val();
            var CoursePrice = $("#CoursePrice").val();
            var CoursePic = $("#img_Pic").attr("src");
            var StudyPlace = $("#StudyPlace").val();
            var LecturerName = $("#LecturerName").val();
            var Grade = $("#Grade").val();//.children('span').attr("value").trim();
            var GradeName = $("#Grade").find("option:selected").text();//.children('span').html();
            var WeekName = $("#WeekName").find("option:selected").text();//.children('span').html();
            var TermName = $("#StudyTerm").find("option:selected").text();//.children('span').html();
            var StudyTerm = 0;
            var StartTime = $("#StartTime").val();
            var EndTime = $("#EndTime").val();
            var RigistType = $("input[name='RigistRadio']:checked").val();
            var SecurityCode = $("#SecurityCode").val();
            var AcademicDepart = $("#AcademicDepart").find("option:selected").text();
            var IsOpen = $("input[name='OpenRadio']:checked").val();
            var LessonPeriod = $("#LessonPeriod").val();
            var StuMaxCount = 0;// $("#StuMaxCount").val();
            var ID = "";
            if (GetUrlDate.ID != undefined) {
                ID = GetUrlDate.ID;
            }

            var Class = "";
            $("input[type=checkbox][name=Ckclass]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    Class += this.value + ",";
                }
            });

            if (!Name.length || !LecturerName.length || !StartTime.length || !EndTime.length) {
                layer.msg("请填写完整信息！");
            }
            else {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "CourseManage/CourceManage.ashx",
                        func: "AddCource", Name: Name, CatagoryID: CatagoryID, CourceType: CourceType, IsCharge: IsCharge,
                        CourseIntro: CourseIntro, CoursePrice: CoursePrice, CoursePic: CoursePic, StudyPlace: StudyPlace,
                        LecturerName: LecturerName, Grade: Grade, Class: Class, ID: ID, TermName: TermName, WeekName: WeekName,
                        GradeName: GradeName, StudyTerm: StudyTerm, StartTime: StartTime, EndTime: EndTime, CreateUID: CreateUID,
                        CourseType: AcademicDepart, IsOpen: IsOpen, LessonPeriod: LessonPeriod, RigistType: RigistType,
                        SecurityCode: SecurityCode, StuMaxCount: StuMaxCount, OldCourceType: $("#HCourceType").val(), OldStatus: $("#HStatus").val()
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            if (CourceType == "2") {
                                addSysNotice("课程审核", "新增课程【" + Name + "】待审核", 3, CreateUID, CreateUID, $("#HUserIdCard").val(), $("#HUserName").val(), $("#HUserName").val(), 0);
                            }
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
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", PageIndex: 1, pageSize: 10, ID: ID, CourseType: "" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData.PagedData).each(function () {

                            $("#CourceName").val(this.Name);

                            $("#CourceType").val(this.CourceType);//.children('span').attr("value", this.CourceType)
                            $("#HCourceType").val(this.CourceType);
                            $("#HStatus").val(this.Status);

                            $("input[name='ChargeRadio'][value=" + this.IsCharge + "]").attr("checked", true);
                            $("#CourseIntro").val(this.CourseIntro);
                            $("#LecturerName").val(this.LecturerName);
                            $("#CoursePrice").val(this.CoursePrice);
                            $("#img_Pic").attr("src", this.ImageUrl);
                            $("#StudyPlace").val(this.StudyPlace);
                            $("#Grade").val(this.Grade);
                            $("#StudyTerm option:contains('" + this.TermName + "')").attr("selected", "selected");
                            $("#StartTime").val(DateTimeConvert(this.StartTime, 'yyyy-MM-dd'));
                            $("#EndTime").val(DateTimeConvert(this.EndTime, 'yyyy-MM-dd'));
                            $("#StuMaxCount").val(this.StuMaxCount);
                            //BindClass();
                            $("#WeekName option:contains('" + this.WeekName + "')").attr("selected", true);
                            $("#AcademicDepart option:contains('" + this.CourseType + "')").attr("selected", true);
                            $("input[name='OpenRadio'][value=" + this.IsOpen + "]").attr("checked", true);
                            $("#LessonPeriod").val(this.LessonPeriod);
                            $("#SecurityCode").val(this.SecurityCode);
                            $("input[name='RigistRadio'][value=" + this.RigistType + "]").attr("checked", true);
                            var url = window.location.href.substring(0, window.location.href.indexOf("CourceAdd.aspx")) + "CourseDetail.aspx?itemid=" + this.ID;
                            $("#CourseUrl").val(url);
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
