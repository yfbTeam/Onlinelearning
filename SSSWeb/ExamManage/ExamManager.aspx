<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamManager.aspx.cs" Inherits="SSSWeb.ExamManage.ExamManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>试卷管理</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="CatagoryCommon.js"></script>
    <%--<script src="/CourseMenu.js"></script>--%>
    <script id="li_Paper" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="exam_img fl">
                <img src="../images/exam_img.png" />
            </div>
            <div class="test_description exam_description fl">
                <h2><a href='#' onclick="LookQuestion(${Id});">${Title}</a></h2>
                <p>
                    <span class="test_type">${TypeShow}</span>
                    <span class="{{if Difficulty==1}}test_easy{{else Difficulty==2}}test_normal{{else Difficulty==3}}test_trouble{{else}}{{/if}}">${DifficultyShow}</span>
                </p>
            </div>
            <div class="test_lists_right fr clearfix">
                <div class="public_name fl">创建人：${CreateName}</div>
                <div class="dates_a dates_b fr">
                    <div class="seedeletion none">
                        <i class="icon icon-eye-open" onclick="LookQuestion(${Id});"></i>
                        <i class="${Status!= 1?'icon icon-ok-circle':'icon icon-ban-circle'}" onclick="ChangPaperStatus(this,${Id},${Status});"></i>
                        {{if IsRelease==2}}<i class="releate" onclick="ReleasePaper(${Id},${Type},'${Title}');"></i>{{/if}}       
                    </div>
                    <div class="data">创建时间：${CreateTime_Format}</div>
                </div>
            </div>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo %>" />
        <%-- 学年--%>
        <input id="HPeriod" type="hidden" value="0" />
        <%-- 科目--%>
        <input id="HSubject" type="hidden" value="0" />
        <%-- 教材--%>
        <input id="HTextboox" type="hidden" value="0" />
        <%-- 目录--%>
        <input id="HChapterID" type="hidden" value="0" />
        <%-- 版本--%>
        <input id="bookVersion" type="hidden" value="0" />
        <%-- 试卷发布状态--%>
        <input id="HIsRelease" type="hidden" value="1" />
        <input id="hName" type="hidden" runat="server" />
        <div>
            <!--header-->
            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="../AppManage/Index.aspx">
                        <img src="../images/logo.png" /></a>
                    <div class="wenzi_tips fl">
                        <img src="../images/testsystem.png" />
                    </div>
                    <nav class="navbar menu_mid fl">
                        <ul id="Menu">
                            <li><a href="../StatisticalAnalysis/Status_ClassStu.aspx">班级人员</a></li>
                            <li><a href="../StatisticalAnalysis/Status_ClassCourse.aspx">班级课程</a></li>
                            <li><a href="ExamQManager.aspx">题库管理</a></li>
                            <li class="active"><a href="ExamManager.aspx">试卷管理</a></li>
                            <li><a href="MyExam.aspx">考试管理</a></li>
                            <li><a href="ExamAnalisy.aspx">考试分析</a></li>
                        </ul>
                    </nav>
                    <div class="search_account fr clearfix">
                        <ul class="account_area fl">
                            <li>
                                <a href="javascript:;" class="login_area clearfix">
                                    <div class="avatar">
                                        <img src="<%=UserInfo.AbsHeadPic%>" />
                                    </div>
                                    <h2><%=UserInfo.Name%></h2>
                                </a>
                            </li>
                        </ul>
                        <div class="settings fl pr ">
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
            <div class="onlinetest_item width pt90 pr">
                <div class="stytem_items">
                    <div class="stytem_item clearfix a">
                        <div class="stytem_items_title fl">
                            学年
                        </div>
                        <div class="stytem_items_list fl" id="Period"></div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix a">
                        <div class="stytem_items_title fl">
                            科目
                        </div>
                        <div class="stytem_items_list fl" id="Subject"></div>
                        <a href="javascript:;" class="stytem_items_more fr">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix none" id="textbookv">
                        <div class="stytem_items_title fl">
                            版本
                        </div>
                        <div class="stytem_items_list fl" id="TextbookVersion"></div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix none" id="text">
                        <div class="stytem_items_title fl">
                            教材
                        </div>
                        <div class="stytem_items_list fl" id="Textbook"></div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                </div>
                <a href="javascript:;" class="moreoptions">
                    <span id="sput">更多选项</span><i id="angle-down" class="icon icon-angle-down fr"></i>
                </a>
            </div>
            <div class="width clearfix testsystem_wrap  pt20">
                <section class="menu fl">
                    <div class="grade pr">
                        <div class="item">
                            <span class="icon-th-list icon icon_list"></span>
                            <span class="title" id="textbook">全部</span>
                            <span class="icon icon-angle-right icon_right"></span>
                        </div>
                    </div>
                    <div class="items" id="menuChapater">
                    </div>
                </section>
                <div class="onlinetest_right bordshadrad pr">
                    <!---->

                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <a href="javascript:;" class="on" onclick="ChangeRelease(1);">已发布试卷</a>
                            <a href="javascript:;" onclick="ChangeRelease(2);">未发布试卷</a>
                        </div>
                        <div class="stytem_select_right fr">
                            <div class="search_exam fl pr">
                                <input type="text" name="Title" id="Title" value="" onblur="getData(1, 10);" placeholder="试卷" />
                                <i class="icon  icon-search"></i>
                            </div>
                            <span class="enable">
                                <span value="1" id="Status">启用 </span><i class="icon icon-angle-down"></i>
                                <div class="enable_wrap none">
                                    <span value="1" class="active" onclick="selectstatus(1)">启用</span>
                                    <span value="2" onclick="selectstatus(2)">禁用</span>
                                </div>
                            </span>
                            <span class="enable" style="width: 75px;">
                                <span value="1" id="sel_Type">考试</span><i class="icon icon-angle-down"></i>
                                <div class="enable_wrap none">
                                    <span value="1" class="active" onclick="ChangePaperType(1)">考试</span>
                                    <span value="2" onclick="ChangePaperType(2)">测试</span>
                                    <span value="3" onclick="ChangePaperType(3)">作业</span>
                                    <span value="4" onclick="ChangePaperType(4)">问卷调查</span>
                                </div>
                            </span>
                            <a href="javascript:;" class="newtest" onclick="MakeExamPaper()">
                                <i class="icon icon-plus"></i>新建试卷
							<%--<div class="addtest_wrap none">
								<em>新建试卷</em>
								<em>上传文档</em>
							</div>--%>
                            </a>
                        </div>
                    </div>
                    <div class="test_norelase">
                        <ul class="test_lists exam_lists" id="ul_Paper">
                            <div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>
                        </ul>
                    </div>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                    <!--预览试卷-->
                </div>
                <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
                <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
                <script>
                    $(function () {
                        //menu显示隐藏
                        $('.grade').find('.item').click(function () {
                            clickTab($('.grade'), '.icon_right');
                        });
                        //预览试卷 手风琴
                        $('.paper_numer h1').find('.icon').click(function () {
                            var $next = $(this).parents('h1').next();
                            $next.stop().slideToggle();
                            $('.paper_numer').find('.paper_number_mes').not($next).slideUp();
                        });
                    })
                </script>
            </div>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    //function accountManagement() {
    //    window.location.href = "/Gopay/Gopay.aspx";
    //}
    //function Mycenter() {
    //    window.open("/PersonalSpace/PersonalSpace_Student.aspx", "_blank")
    //}
    var book = "";
    //var HanderServiceUrl = "/ExamManage/";
    $(function () {
        GetSameLiveMenu(location.href, '<%=UserInfo.UniqueNo%>', '');
       
        BindCatagory();
        $("#Title").attr("value", "");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        getData(1, 10);
    });
    function ChangeRelease(relvalue) {
        $("#HIsRelease").val(relvalue);
        getData(1, 10);
    }
    function ChangePaperType(type) {
        $("#sel_Type").attr("value", type);
        getData(1, 10);
    }
    function selectstatus(status) {
        $("#Status").attr("value", status);
        getData(1, 10);
    }
    //var pTitle = $("#Title").val().trim();
    //function SearchCondition() {
    //    pTitle = $("#Title").val().trim();
    //    getData(1, 10);
    //}
    //获取数据
    function getData(startIndex, pageSize) {
        var Chapter = $("#HChapterID").val();
        var Status = $("#Status").attr("value");
        var TypeId = $("#sel_Type").attr("value");
        var IsRelease = $("#HIsRelease").val();
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/PaperHandler.ashx",
                action: "GetExamPaperDataPage",
                PageIndex: startIndex,
                pageSize: pageSize,
                KlpointID: Chapter,
                Status: Status,
                Type: TypeId,
                Title: $("#Title").val().trim(),
                IsRelease: IsRelease,
                Book: book,
            },
            success: function (json) {
                var IsRelease = $("#HIsRelease").val();
                if (json.result.errNum.toString() == "0") {
                    $("#ul_Paper").html('');
                    $("#li_Paper").tmpl(json.result.retData.PagedData).appendTo("#ul_Paper");
                    $("#pageBar").show();
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    HoverPaper();
                    //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                } else {
                    $("#pageBar").hide();
                    $("#ul_Paper").html('<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>');
                }
            },
            //error: OnError
        });
    }
    function HoverPaper() {
        //试卷管理
        $('.test_lists li').hover(function () {
            $(this).find('.seedeletion').show();
            //发步图标划过文字显示
            $(this).find('.release').hover(function () {
                $(this).find('em').slideDown();
            }, function () {
                $(this).find('em').slideUp();
            })
        }, function () {
            $(this).find('.seedeletion').hide();
        })
    }
    function ChangPaperStatus(obj, Id, Qtype) {
        var status = 2;
        if ($(obj).hasClass("icon-ok-circle")) { status = 1; }
        var str = status == 1 ? "启" : "禁";
        layer.msg("确定要" + str + "用该试卷?", {
            time: 0 //不自动关闭
           , btn: ['确定', '取消']
           , yes: function (index) {
               layer.close(index);
               $.ajax({
                   url: "../Common.ashx",
                   type: "post",
                   async: false,
                   dataType: "json",
                   data: {
                       PageName: "/ExamManage/PaperHandler.ashx",
                       "action": "ChangPaperStatus", "PaperId": Id, "Status": status
                   },
                   success: function (json) {
                       if (json.result.errNum.toString() == "0") {
                           //if (status == 1) {
                           //    alert('启用成功');
                           //} else {
                           //    alert('禁用成功');
                           //}
                           getData(1, 10);
                       }
                   },
                   error: function (errMsg) {

                   }
               });
           }
        });
    }
    function LookQuestion(id) {
        OpenIFrameWindow('预览试卷', 'ExamPaperDetail.aspx?id=' + id, '900px', '70%');
    }
    function ReleasePaper(Id, qtype, Name) {
        OpenIFrameWindow('发布试卷', 'ReleaseExam.aspx?Id=' + Id + '&name=' + Name + '&qtype=' + qtype, '780px', '70%');
    }
    function MakeExamPaper() {
        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        //var MajorID = Period.trim() == "" ? "" : (Subject.trim() == "" ? Period : (Period + "|" + Subject));
        var bookVersion = $("#bookVersion").val();
        var Textboox = $("#HTextboox").val();
        //MajorID = bookVersion.trim() == "" ? MajorID : (Textbook.trim() == "" ? MajorID + "&" + bookVersion : (MajorID + "&" + bookVersion + "|" + TextBook));
        var Chapter = $("#HChapterID").val();
        var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&Textboox=" + Textboox + "&bookVersion=" + bookVersion + "&Chapter=" + Chapter) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox)) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion)) : ("?Period=" + Period + "&Subject=" + Subject)) : "?Period=" + Period) : "";
        location.href = "ManualChooseQ.aspx" + parm;
    }
</script>
