<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyCerty.aspx.cs" Inherits="SSSWeb.PersonalSpace.ApplyCerty" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>在线学习</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <!--证书-->
    <link rel="stylesheet" href="../css/certificate.css">
    <link rel="stylesheet" href="../css/certificateT.css">
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <script src="Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../js/jquery.jqprint.js"></script>
    <script src="../js/jquery-migrate-1.1.0.js"></script>
    <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>
    <script id="tr_Certificate" type="text/x-jquery-tmpl">
        <tr>
            <td>${Identifier}</td>
            <td>${cName}</td>
            <td>${IssuingUnit}</td>
            <td>${DateTimeConvert(CompleteTime, 'yyyy-MM-dd')}</td>
            <td>${IssuedWebSite}</td>
            <td>{{if Status==1}}<span>审核通过</span>{{else}}{{if Status==2}}<span>审核未通过</span>{{else}}<span>待审核</span>{{/if}}{{/if}}
            </td>
            <td>{{if Status==1}}<a onclick="ShowCertificate(${ID})" style="cursor: pointer;">预览</a>{{/if}}</td>
        </tr>
    </script>

    <script type="text/x-jquery-tmpl" id="tr_CertImg">
        <li><a onclick="ShowCertificate(${ID})">{{if Attachment==""}}<img src="/Attatchment/Certificates/默认证书.png">
            {{else}}<img src="${Attachment}">
            {{/if}}
        </a></li>
    </script>


</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo%>" />
    <input type="hidden" id="PhotoName" value="<%=UserInfo.AbsHeadPic%>" />
    <input type="hidden" id="LoginName" value="<%=UserInfo.LoginName %>" />
    <input type="hidden" id="HUserName" value="<%=UserInfo.Name %>" />
    <input type="hidden" id="IsFirstLogin" value="<%=UserInfo.IsFirstLogin%>" />

    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/PersonalSpace/CourseManIndex.aspx">
                <img src="../images/logo.png" /></a>
            <div class="wenzi_tips fl">
                <img src="../images/zaixianxuexi.png" />
            </div>
            <nav class="navbar menu_mid fl" id="navlists">
                <ul>
                    <li><a href="../PersonalSpace/CourseManIndex.aspx">课程首页</a></li>
                    <li><a href="../PersonalSpace/PersonalSpace_Student.aspx#course-2">在学课程</a></li>
                    <li><a href="../PersonalSpace/PersonalSpace_Student.aspx#course-3">我负责的课程</a></li>
                    <li class="active"><a href="#" style="cursor: pointer;">证书申请</a></li>
                    <li><a href="../ExamManage/Exam_Stu.aspx">在线考试</a></li>

                </ul>
            </nav>
            <div class="search_account fr clearfix">
                <ul class="account_area fl">
                    <li>
                        <a class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=UserInfo.AbsHeadPic%>" />
                            </div>
                            <h2><%=UserInfo.Name%></h2>
                        </a>
                    </li>
                </ul>

                <div class="settings fl pr">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="onlinetest_item width pt90">
        <div class="myexam bordshadrad">
            <div class="course_sort" id="course-1">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on" id="spaceitem1" onclick="SpaceChange(this,1)">证书申请</a>
                        <a href="javascript:;" id="spaceitem2" onclick="SpaceChange(this,2)">我的证书</a>
                    </div>
                    <div class="stytem_select_right fr clearfix">
                        <%--<div class="search_exam fl pr">
                            <input type="text" name="" id="CourseName_all" value="" placeholder="请输入课程名称">
                            <i class="icon  icon-search" onclick="geCoursetData(1,10,'')"></i>
                        </div>--%>
                    </div>
                </div>

                <ul class="allcourses clearfix">
                    <div id="CerTemplate" class="certificate" style="margin-left: 20px;">
                        <div id="CertificateApply" class="certificate_list">
                            <div class="wrap">
                                <table>
                                    <thead>
                                        <th>证书名称</th>
                                        <th>包含课程</th>
                                        <th>创建时间</th>
                                        <th>申请状态</th>
                                        <th>操作</th>
                                    </thead>
                                    <tbody id="tbApply">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="page">
                            <span id="pageBar"></span>
                        </div>
                    </div>
                    <div id="GrantCer" style="display: none; margin-left: 20px;">
                        <div id="NCertificateList" class="certificate_list">
                            <div class="newcourse_select clearfix" id="CourseSel">
                                <div class="stytem_select_right fr">
                                    <a href="javascript:;" class="newcourse" onclick="UploadAttach()" id="icon-plus">上传附件
                                    </a>
                                </div>
                            </div>
                            <div class="wrap">
                                <table>
                                    <thead>
                                        <th>证书编号</th>
                                        <th>证书名称</th>
                                        <th>发证单位</th>
                                        <th>结束时间</th>
                                        <th>查询网址</th>
                                        <th>状态</th>
                                        <th>操作</th>
                                    </thead>
                                    <tbody id="tbCertificate">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </ul>
            </div>
        </div>
    </div>

    <footer id="footer"></footer>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript">

        $(function () {
            $('#footer').load('../footer.html');
            BindCertificate(1, 10);
            Certificate();
        })
        //平台证书
        function BindCertificate(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetPlatCertificate",
                    StuNo: $("#HUserIdCard").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize,
                },
                success: function (json) {
                    var tr = "";
                    var ExamName = "";
                    var CourseName = "";

                    if (json.CertificateManage.errNum.toString() == "0") {
                        $("#page").show();
                        $("#tbApply").html('');
                        //$("#tr_Certificates").tmpl(json.CertificateManage.retData.PagedData).appendTo("#tbCertificates");
                        $.each(json.CertificateManage.retData.PagedData, function (n, value) {
                            var CertificateID = this.ID;
                            ExamName = "";
                            CourseName = "";
                            //课程
                            $.each(json.Course.retData, function (n, value) {
                                if (this.CertificateID == CertificateID) {
                                    CourseName += "[" + this.CourseName + "]";
                                }
                            });
                            var StatusName = "";
                            var a = "";
                            if (this.SelStatus == null || this.SelStatus == "") {
                                StatusName = "未申请";
                                a = "<a onclick=\"Apply(" + this.ID + ")\" style='cursor:pointer;'>申请</a>";
                            }
                            else if (this.SelStatus == "0") {
                                StatusName = "申请成功待审核";
                                a = "审核中"
                            }
                            else if (this.SelStatus == "1") {
                                StatusName = "审核通过";
                                a = "审核通过";
                            }
                            else if (this.SelStatus == "2") {
                                StatusName = "审核未通过";
                                a = "<a onclick=\"Apply(" + this.ID + ")\" style='cursor:pointer;'>申请</a>";
                            }
                            tr += "<tr> <td>" + this.Name + "</td><td>" + CourseName.trim('-') + "</td><td>" + DateTimeConvert(this.CreateTime, 'yyyy-MM-dd') + "</td><td>" + StatusName + "</td><td>"
                            + a + "</td>";
                        })

                        $("#tbApply").html(tr);
                        makePageBar(BindCertificate, document.getElementById("pageBar"), json.CertificateManage.retData.PageIndex, json.CertificateManage.retData.PageCount, pageSize, json.CertificateManage.retData.RowCount);
                    }
                    else {
                        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        $("#page").hide();
                        $("#tbApply").html(html);
                    }
                },
                error: function (errMsg) {
                    $("#page").hide();
                    layer.msg(errMsg);
                }
            });
        }
        //证书申请
        function Apply(ID) {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "ApplyCert",
                    StuNo: $("#HUserIdCard").val(),
                    CertificateID: ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("申请成功");
                        BindCertificate(1, 10);
                        Certificate();
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

        function bzCertificateGet(em) {

            var src = $(em).attr('src');
            src = src.replace('_s.jpg', '.jpg');
            $("#Modole_show").attr("src", src);
        }
        function SpaceChange(em, Type) {
            if (Type == 1) {
                $("#spaceitem1").addClass("on");
                $("#spaceitem2").removeClass("on");

                $("#GrantCer").hide();
                $("#CerTemplate").show();
            }
            else {
                $("#spaceitem1").removeClass("on");
                $("#spaceitem2").addClass("on");

                $("#GrantCer").show();
                $("#CerTemplate").hide();
            }
            $(em).addClass("action").siblings().removeClass("action");
        }
        //证书模板
        function bindModol() {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetModolList",
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#Certificate").html('');
                        $("#li_Modol").tmpl(json.result.retData).appendTo("#Certificate");
                    }
                    else {
                        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';

                        //var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';

                        $("#Certificate").html(html);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //证书
        function Certificate() {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetCertificates",
                    Ispage: false,
                    IDCard: $("#HUserIdCard").val(),
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#tbCertificate").html('');
                        $("#tr_Certificate").tmpl(json.result.retData).appendTo("#tbCertificate");
                        //$("#tr_CertImg").tmpl(json.result.retData).appendTo("#CertImg");
                        //.append(" <li><a><img src=\"" + this.Attachment + "\"></a></li>")

                    }
                    else {
                        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';

                        //var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';

                        $("#tbCertificate").html(html);
                    }
                    $(".qualifications_slide").slide({ mainCell: ".sides", titCell: ".num ul", effect: "leftLoop", autoPlay: true, delayTime: 700, autoPage: true });
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

        function ShowCertificate(ID) {
            OpenIFrameWindow('证书预览', 'CertificateShow.aspx?ID=' + ID + "&Type=2", '480px', '480px');
        }

        function UploadAttach() {
            OpenIFrameWindow('上传附件', 'CertificateAttach.aspx?Type=1', '320px', '300px');
        }
        function CalculatePercent(perinfo) {
            var allwidth = 0;
            var oneArray = perinfo.split(',');
            for (var i = 0; i < oneArray.length; i++) {
                var twoArray = oneArray[i].split('|');
                if (twoArray[2].toString() != "0") {
                    allwidth += Math.round((twoArray[3] / twoArray[2]) * (twoArray[1] / 100) * 10000) / 100.00;
                }
            }
            return allwidth + "%";
        }
    </script>
</body>
</html>
