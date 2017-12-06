<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_WorkLook.aspx.cs" Inherits="SSSWeb.OnlineLearning.Course_WorkLook" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>作业详情</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="TopicAndComment.js"></script>
</head>
<body style="background:white;">
    <input type="hidden" id="HUserIdCard" runat="server"/>
    <input type="hidden" id="HUserName" runat="server"/>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">                    
                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">作业标题：</label>
                            <input type="text" placeholder="" class="text" id="txt_Name" readonly="readonly"/>                          
                        </div>
                        <div style="clear: both"></div>
                        <div class="course_form_select">
                            <label for="">作业要求：</label>
                            <textarea name="" rows="" cols="" id="area_Requirement" style="width:350px;" readonly="readonly"></textarea>
                        </div>
                        <div class="course_form_div">
                            <label for="">起止时间：</label>
                            <input type="text" class="text" style="width:166px;" readonly="true" id="da_StartTime"/>
                            <label for="">至</label>
                            <input type="text" class="text" style="width:166px;" readonly="true" id="da_EndTime"/>
                        </div>                       
                        <div class="course_form_div">
                            <label for="">作业附件：</label>
                            <a id="a_Attachment" href="javascript:;" style="cursor:pointer;"></a>   
                           <%-- <div class="course_form_select clearfix">--%>
                             <span id="btn_download" class="course_btn confirm_btn" style="cursor:pointer;display:none;">下载附件</span>
                           <%-- </div>    --%>                     
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
    </form>    
    <script src="../js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            GetWorkById(UrlDate.itemid);
        });
        //绑定数据
        function GetWorkById(itemid) {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/WorkHandler.ashx",
                    Func: "GetWorkById",
                    ItemId: itemid
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var model = json.result.retData;
                        $("#txt_Name").val(model.Name);
                        $("#area_Requirement").val(model.Requirement);
                        $("#da_StartTime").val(DateTimeConvert(model.StartTime));
                        $("#da_EndTime").val(DateTimeConvert(model.EndTime));
                        var $a_Attachment = $("#a_Attachment"), $btn_download = $("#btn_download");
                        if (model.Attachment.length) {
                            $a_Attachment.html(CutFileName(model.Attachment, 25));
                            $a_Attachment.attr("title", model.Attachment);
                            $a_Attachment.click(function () {
                                DownLoad_Work(model.Attachment);
                            });
                            $btn_download.show();
                            $btn_download.click(function () {
                                DownLoad_Work(model.Attachment);
                            });
                        } else {
                            $a_Attachment.html("无附件！");
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
        //下载作业
        function DownLoad_Work(filepath) {            
            $.ajax({
                url: "../OnlineLearning/DownLoadHandler.ashx",
                type: "post",
                async: false,
                dataType: "text",
                data: {
                    filepath: filepath,
                    UserIdCard: $("#HUserIdCard").val()
                },
                success: function (result) {
                    if (result == "-1") {
                        layer.msg('文件不存在!');
                        return;
                    }
                    window.open("/OnlineLearning/DownLoadHandler.ashx?filepath=" + filepath + "&UserIdCard=" + $("#HUserIdCard").val() + "&time=" + new Date());
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg('文件不存在!');
                }
            });
        }
    </script>
</body>
</html>

