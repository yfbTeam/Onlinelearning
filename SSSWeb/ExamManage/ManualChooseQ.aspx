<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManualChooseQ.aspx.cs" Inherits="SSSWeb.ExamManage.ManualChooseQ" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>选题组卷</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
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
</head>
<body>
    <form id="form1" runat="server">
        <%-- 学段--%>
        <input id="HPeriod" type="hidden" value="0" />
        <%-- 科目--%>
        <input id="HSubject" type="hidden" value="0" />
        <%-- 教材--%>
        <input id="HTextboox" type="hidden" value="0" />
        <%-- 目录--%>
        <input id="HChapterID" type="hidden" value="0" />

        <input id="bookVersion" type="hidden" value="0" />
        <!--难度-->
        <input id="Difficult" type="hidden" value="0" />
        <!--题型-->
        <input id="hf_TypeId" type="hidden" value="0" />
        <!--题型分类-->
        <input id="hf_Type" type="hidden" value="2" />
        <input id="Status" type="hidden" value="1" />
        <asp:HiddenField ID="HPeriodid" runat="server" />
        <asp:HiddenField ID="HSubjectid" runat="server" />
        <asp:HiddenField ID="HTextbooxid" runat="server" />
        <asp:HiddenField ID="bookVersionid" runat="server" />
        <asp:HiddenField ID="HChapterIDid" runat="server" />
        <div>

            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="../AppManage/Index.aspx">
                        <img src="../images/logo.png" /></a>
                    <div class="wenzi_tips fl">
                        <img src="../images/testsystem.png" />
                    </div>
                    <nav class="navbar menu_mid fl">
                        <ul id="Menu">
                            <li currentclass="active"><a href="ExamQManager.aspx?ParentID=19">题库管理</a></li>
                            <li class="active"><a href="ExamManager.aspx?ParentID=19">试卷管理</a></li>
                            <li currentclass="active"><a href="MyExam.aspx?ParentID=19">我的试卷</a></li>
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
                        <div class="stytem_items_list fl" id="Period">
                            <%-- <a href="javascript:;">学前教育</a>                           
                            <a href="javascript:;" class="on">学前教育</a>    --%>
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix a">
                        <div class="stytem_items_title fl">
                            科目
                        </div>
                        <div class="stytem_items_list fl" id="Subject">
                            <%--<a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>--%>
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix none" id="textbookv">
                        <div class="stytem_items_title fl">
                            版本
                        </div>
                        <div class="stytem_items_list fl" id="TextbookVersion">
                            <%--<a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>--%>
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix none" id="text">
                        <div class="stytem_items_title fl">
                            教材
                        </div>
                        <div class="stytem_items_list fl" id="Textbook">
                            <%-- <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>--%>
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                </div>
                <a href="javascript:;" class="moreoptions">
                    <span id="sput">更多选项</span><i id="icon-angle" class="icon icon-angle-down fr"></i>
                </a>
            </div>
            <div class="width clearfix testsystem_wrap  pt20 pr">
                <!--试题篮返回顶部-->
                <div class="testbask_backtop">
                    <div class="test_bask">
                        <span class="icon icon-shopping-cart"></span>
                        <i class="test_num" id="i_test_num">0
                        </i>
                        <div class="test_basket_wrap none">
                            <h1>试题篮
							<span class="fr">共计<span id="tcount">0</span>题</span>
                            </h1>
                            <div class="test_basklists">
                                <ul id="baskul">
                                </ul>
                                <div class="releasebtn">
                                    <a href="javascript:;" onclick="ClearTestbask();">清空全部</a>
                                    <a href="javascript:;" onclick="MakeExamPaper()">组卷</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="backTop mt10">
                        <span class="icon  icon-angle-up" title="返回顶部"></span>
                    </div>
                </div>
                <section class="menu fl">
                    <div class="grade pr">
                        <div class="item">
                            <span class="icon-th-list icon icon_list"></span>
                            <span class="title" id="textbook">全部</span>
                            <span class="icon icon-angle-right icon_right"></span>
                        </div>
                        <%--<ul class="contentbox">
                            <li>
                                <span class="text">上学去</span>
                            </li>
                            <li>
                                <span class="text">上学去</span>
                            </li>
                            <li>
                                <span class="text">上学去</span>
                            </li>
                        </ul>--%>
                    </div>
                    <div class="items" id="menuChapater">
                        <%--<div class="units">
                            <div class="item_title">
                                <span class="text">汉语拼音</span>
                                <span class="icon icon-angle-down"></span>
                            </div>
                            <ul class="contentbox" style="display: block;">
                                <li class="active">
                                    <span class="text">上学去</span>
                                </li>
                                <li>
                                    <span class="text">上学去</span>
                                </li>
                                <li>
                                    <span class="text">上学去</span>
                                </li>
                            </ul>
                        </div>--%>
                    </div>
                </section>
                <div class="onlinetest_right bordshadrad">

                    <!---->
                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <a href="javascript:;" class="on">手动组卷</a>
                            <a href="javascript:;" onclick="MakeExamPaperintelligent()">智能组卷</a>
                        </div>
                        <div class="stytem_select_right fr">
                            <a href="ExamManager.aspx">
                                <i class="icon icon-reply"></i>
                                <span>试卷管理</span>
                            </a>
                        </div>
                    </div>
                    <div class="selectionwrap">
                        <div class="select_nav clearfix pr">
                            <div class="select_nav_left fl">
                                题型:
                            </div>
                            <ul class="select_nav_right clearfix" id="qtypeul">
                                <%--<li class="on">
								<a href="javascript:;">全部</a>
							</li>
							<li>
								<a href="javascript:;">单选题</a>
							</li>
							<li>
								<a href="javascript:;">多选题</a>
							</li>
							<li>
								<a href="javascript:;">判断题</a>
							</li>
							<li>
								<a href="javascript:;">计算题</a>
							</li>
							<li>
								<a href="javascript:;">简答题</a>
							</li>
							<li>
								<a href="javascript:;">操作题</a>
							</li>
							<li>
								<a href="javascript:;">阅读题</a>
							</li>--%>
                            </ul>
                        </div>
                        <div class="select_nav clearfix pr">
                            <div class="select_nav_left fl">
                                难度
                            </div>
                            <ul class="select_nav_right">
                                <li class="on">
                                    <a href="javascript:void(0);" onclick="SelectDifficult(0);">不限</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="SelectDifficult(1);">简单</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="SelectDifficult(2);">中等</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="SelectDifficult(3);">较难</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="testbasket_top clearix">
                        <div class="test_total fl">
                            总计<span id="Qcount">0</span>道试题
                        </div>
                        <div class="test_tips fl">
                            提示：单击题面可显示答案和解析 
                        </div>
                        <div class="testbasket_topright fr cleafix">
                            <div class="labelcheck fl pr">
                                <input type="checkbox" name="" id="checkAll" />
                                <label for="checkAll">显示答案与解析</label>
                            </div>

                        </div>
                    </div>
                    <!--试题篮list-->
                    <div class="test_lists_basket">
                        <ul id="qDiv">
                        </ul>
                    </div>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>

                    </div>
                    <!--fenye-->
                </div>

            </div>
            <script src="../js/common.js"></script>
            <script>
                $(function () {
                    //menu显示隐藏
                    $('.grade').find('.item').click(function () {
                        clickTab($('.grade'), '.icon_right');
                    });

                   GetSameLiveMenu("ExamManage/ExamManager.aspx", '<%=UserInfo.UniqueNo%>', '');
                    
                })
                //点击checkbox显示隐藏答案
                $('.labelcheck').click(function () {
                    var $check = $(this).find('input[type=checkbox]');
                    var $hidden = $('.test_lists_basket').find('.ques_answer');
                    if ($check.is(':checked')) {
                        $hidden.show();
                    } else {
                        $hidden.hide();
                    }
                })
                //试题库总数，右边显示 隐藏
                $('.test_bask').click(function () {
                    var $hidden = $(this).find('.test_basket_wrap');
                    if ($hidden.is(':hidden')) {
                        $hidden.show();
                    } else {
                        $hidden.hide();
                    }
                })
                //返回顶部
                backTop($('.backTop'), 400);
                //
                onscroll($('.testsystem_wrap>.menu'));
            </script>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">

    function MakeExamPaper() {
        var Count = $("#tcount").html();
        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        var bookVersion = $("#bookVersion").val();
        var Textboox = $("#HTextboox").val();
        var Chapter = $("#HChapterID").val();
        if (Count == "0") {
            layer.msg("未选择试题");
        }
        else {
            var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&Chapter=" + Chapter + "&url=ManualChooseQ.aspx") : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&url=ManualChooseQ.aspx")) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&url=ManualChooseQ.aspx")) : ("?Period=" + Period + "&Subject=" + Subject + "&url=ManualChooseQ.aspx")) : "?Period=" + Period + "&url=ManualChooseQ.aspx") : "?url=ManualChooseQ.aspx";
            location.href = "MarkExamPaper.aspx" + parm;
        }
    }
    function MakeExamPaperintelligent() {
        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        var bookVersion = $("#bookVersion").val();
        var Textboox = $("#HTextboox").val();
        var Chapter = $("#HChapterID").val();
        var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&Chapter=" + Chapter) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox)) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion)) : ("?Period=" + Period + "&Subject=" + Subject)) : "?Period=" + Period) : "";
        location.href = "IntelligenceChooseQ.aspx" + parm;
    }

    var book = "";
    var HPeriodid = $("#HPeriodid").val();
    var HSubjectid = $("#HSubjectid").val();
    var HTextbooxid = $("#HTextbooxid").val();
    var bookVersionid = $("#bookVersionid").val();
    var HChapterIDid = $("#HChapterIDid").val();
    if (HSubjectid != "0") {
        $("#sput").html("收起");
    }
    $(function () {
        book = "" + HPeriodid + "|" + HSubjectid + "|" + bookVersionid + "|" + HTextbooxid + "";
        $("#HPeriod").val(HPeriodid);
        $("#HSubject").val(HSubjectid);
        $("#bookVersion").val(bookVersionid);
        $("#HTextboox").val(HTextbooxid);
        $("#HChapterID").val(HChapterIDid);
        BindCatagory();
        //Chapator();
        getBaskTypedata();
        getBaskdata();
        getType();
        getData(1, 10);
    });
    var idcss = "";
    var BasketQuestion = [];
    /*
    function AddTextBasketbal(obj, id, typeid, Qtype, Score) {

        $(obj).removeClass("ques_addbtn").addClass("ques_removebtn").html("移除试题");
        $(obj).attr("onclick", "DelqTextBasketbal(this," + id + ", " + typeid + ", " + Qtype + "," + Score + ")");
        //BasketQuestion += "{" + id + ", " + typeid + ", " + Qtype + "," + Score + "},";
        var QuestionTypeLi = "QuestionType" + typeid;
        var Span = $("#" + QuestionTypeLi + ">span")[1];
        var SpanHtml = $("#" + QuestionTypeLi + ">span")[1].innerHTML
        var obj = {
            id: id,
            typeid: typeid,
            Qtype: Qtype,
            Score: Score
        }
        BasketQuestion.push(obj);

        localStorage.setItem('BasketQuestion', JSON.stringify(BasketQuestion));
        var Count = SpanHtml.toString().substr(0, SpanHtml.length - 2);
        Span.innerHTML = (parseInt(Count) + 1) + " 题";
        var AllCount = $("#i_test_num").html();
        $("#i_test_num").html(parseInt(AllCount) + 1);
        //console.log(localStorage.getItem('BasketQuestion'));


    }*/
    function AddTextBasketbal(obj, id, typeid, Qtype, Score) {

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "AddQToTesstBasket", "ID": id, "Type": typeid, "QType": Qtype, "Score": Score, CreateUID: '<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                liveAddquesBtn();
                var html = "";
                var count = 0;
                if (json.result.errNum == 0) {

                    //$(obj).attr("disabled", "disabled");
                    $(obj).removeClass("ques_addbtn").addClass("ques_removebtn").html("移除试题");
                    $(obj).attr("onclick", "DelqTextBasketbal(this," + id + ", " + typeid + ", " + Qtype + "," + Score + ")");
                    idcss += id + ",";
                    getBaskTypedata();
                    getBaskdata();
                }

            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    var baskdatajson = "";
    function getBaskdata() {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "getTestBasket", CreateUID: '<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                baskdatajson = json;
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function getBaskTypedata() {

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "getTextBasketTypeQ", CreateUID: '<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                var html = "";
                var count = 0;
                $.each(json.result.retData, function () {
                    count = parseInt(this.Count) + parseInt(count);
                    var liID = 'QuestionType' + this.TypeID;
                    html += "<li id=" + liID + "><span>" + this.Type + "</span><span>" + this.Count + " 题</span><span><i class=\"icona icon-trash\" onclick=\"deletetype(" + this.TypeID + ",'" + this.Type + "')\"></i></span></li>";
                });
                $("#baskul").html(html);
                $("#tcount").html(count);
                $("#i_test_num").html(count);
                //setQCount();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function setQCount() {
        var QB = localStorage.getItem('BasketQuestion');
        if (QB != null) {

            $('#baskul').find('li').each(function () {
                var QuestionTypeLi = $(this).attr('id');
                var TypeID = QuestionTypeLi.toString().replace("QuestionType", "");
                var Count = 0;
                $.each(eval(QB), function (idx, obj) {
                    if (this.typeid.toString() == TypeID) {
                        Count++;
                    }
                });
                //var QuestionTypeLi = "QuestionType" + TypeID;
                var Span = $("#" + QuestionTypeLi + ">span")[1];
                var SpanHtml = $("#" + QuestionTypeLi + ">span")[1].innerHTML;
                //var CurCount = SpanHtml.toString().substr(0, SpanHtml.length - 2);
                Span.innerHTML = (parseInt(Count)) + " 题";
                //var AllCount = $("#i_test_num").html();
                $("#i_test_num").html(eval(QB).length);


            })
        }
    }
    function ClearTestbask() {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "DelTestBasket", CreateUID: '<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                idcss = "";
                getBaskdata()
                getBaskTypedata();
                getData(1, 10);
                //var $btn = $('#qDiv li .ques_releasemes a');

                //if ($btn.hasClass('ques_removebtn')) {
                //    $btn.addClass('ques_addbtn').removeClass('ques_removebtn').html('加入试题');
                //    $btn.attr("onclick", $btn.attr("onclick").replace("Delq", "Add"));

                //}
                //getBaskdata();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }

    function getType() {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/ExamManage/QuestionHander.ashx", "action": "GetQuestionTypeList" },
            success: function (json) {
                var html = "";
                var count = 0;
                $.each(json.result.retData, function () {
                    count = 1 + parseInt(count);
                    if (count == 1) {
                        html += "<li class='on'><a href=\"javascript:void(0);\" onclick='typesearch(" + this.ID + "," + this.QType + ")'>" + this.Name + "</a></li>";
                        $("#hf_TypeId").val(this.ID);
                        typesearch(this.ID, this.QType);
                    } else {
                        html += "<li><a href=\"javascript:void(0);\" onclick='typesearch(" + this.ID + "," + this.QType + ")'>" + this.Name + "</a></li>";
                    }
                });
                $("#qtypeul").html(html);
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //获取数据
    function getData(startIndex, pageSize) {
        //if (HPeriodid == 0) { book = ""; }
        var Period = $("#HPeriod").val();
        if (Period == "0") {
            book = "";
        }
        var Subject = $("#HSubject").val();
        var MajorID = book;
        var bookVersion = $("#bookVersion").val();
        var boox = $("#HTextboox").val();
        var Chapter = $("#HChapterID").val();
        var Status = $("#Status").attr("value");
        var TypeId = $("#hf_TypeId").val();
        var Difficult = $("#Difficult").val();
        var Title = $("#Title").val();
        var qtype = $("#hf_Type").val();
        var action = "GetExamObjQList";
        if (qtype == 2) {
            action = "GetExamSubQList";
        }
        //初始化序号 
        pageNum = (startIndex - 1) * 8 + 1;
        //name = name || '';
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": action, PageIndex: startIndex, pageSize: pageSize,
                "KlpointID": Chapter, "Status": Status, "Type": TypeId, "Title": Title, "Difficult": Difficult, "MajorID": MajorID
            },
            success: OnSuccess,
            error: function (json) {
                $("#Qcount").text(0);
                $("#qDiv").html(json.result.errMsg.toString());
            }
        });
    }
    function OnSuccess(json) {
        if (json.result.errNum.toString() == "0") {
            $('.page').show();
            var PagedData = json.result.retData.PagedData;
            var html = "";
            var count = 0;
            $.each(PagedData, function () {
                count++;
                html += "<li><div class=\"quesdiv\"><div class=\"ques_body\">";
                html += "<h1 class=\"ques_title\">";
                html += "	<em>" + this.Content + "</em>";
                html += "	<span class=\"test_type\">" + this.Type + "</span>";
                if (this.Difficulty == 1) {
                    html += "<span class=\"test_easy\">" + this.DifficultyShow + "</span>"
                } else if (this.Difficulty == 2) {
                    html += "<span class=\"test_normal\">" + this.DifficultyShow + "</span>"
                } else if (this.Difficulty == 3) {
                    html += "<span class=\"test_trouble\">" + this.DifficultyShow + "</span>"
                }
                html += "	</h1><div class=\"ques_detail\">";
                if (this.QType == 1) {
                    if (this.OptionA != "") {
                        var OptionA = "";
                        OptionA = "" + this.OptionA + "";
                        OptionA = OptionA.substr(OptionA.lastIndexOf("."), OptionA.length);
                        if (OptionA == ".png" || OptionA == ".jpeg" || OptionA == ".jpg") {
                            html += "A.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionA + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>A：" + this.OptionA + "</p>"; }

                    }
                    if (this.OptionB != "") {
                        var OptionB = "";
                        OptionB = "" + this.OptionB + "";
                        OptionB = OptionB.substr(OptionB.lastIndexOf("."), OptionB.length);
                        if (OptionB == ".png" || OptionB == ".jpeg" || OptionB == ".jpg") {
                            html += "B.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionB + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>B：" + this.OptionB + "</p>"; }

                    }
                    if (this.OptionC != "") {
                        var OptionC = "";
                        OptionC = "" + this.OptionC + "";
                        OptionC = OptionC.substr(OptionC.lastIndexOf("."), OptionC.length);
                        if (OptionC == ".png" || OptionC == ".jpeg" || OptionC == ".jpg") {
                            html += "C.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionC + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>C：" + this.OptionC + "</p>"; }

                    }
                    if (this.OptionD != "") {
                        var OptionD = "";
                        OptionD = "" + this.OptionD + "";
                        OptionD = OptionD.substr(OptionD.lastIndexOf("."), OptionD.length);
                        if (OptionD == ".png" || OptionD == ".jpeg" || OptionD == ".jpg") {
                            html += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionD + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>D：" + this.OptionD + "</p>"; }

                    }
                    if (this.OptionE != "") {
                        var OptionE = "";
                        OptionE = "" + this.OptionE + "";
                        OptionE = OptionE.substr(OptionE.lastIndexOf("."), OptionE.length);
                        if (OptionE == ".png" || OptionE == ".jpeg" || OptionE == ".jpg") {
                            html += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionE + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>E：" + this.OptionE + "</p>"; }

                    }
                    if (this.OptionF != "") {
                        var OptionF = "";
                        OptionF = "" + this.OptionF + "";
                        OptionF = OptionF.substr(OptionF.lastIndexOf("."), OptionF.length);
                        if (OptionF == ".png" || OptionF == ".jpeg" || OptionF == ".jpg") {
                            html += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionF + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>F：" + this.OptionF + "</p>"; }

                    }
                }
                html += "</div></div>";
                html += "<div class=\"ques_answer none\">";
                if (this.QType == 1) {
                    html += "	<p>答案：</p>";
                } else { html += "	<p>参考答案：</p>"; }
                html += "	" + this.Answer + "";
                html += "	</div>";
                html += "	</div>";
                html += "<div class=\"ques_releasemes\">";
                html += "	<span class=\"ques_releasename fl\">添加人：" + this.CreateName + " </span>";
                html += "	<span class=\"ques_releasetime fl\">发布时间：" + this.CreateTime + "</span>";
                var isadd = false;
                var typeid = this.TypeID;
                var qid = this.ID;
                if (baskdatajson != "0" && baskdatajson != undefined) {
                    if (baskdatajson.result.errNum.toString() == "0") {
                        var baskjson = baskdatajson.result.retData;
                        $(baskjson).each(function () {
                            if (this.Type == typeid && this.ID == qid) {
                                isadd = true;
                            }
                        });
                    }
                }
                //var currentLocalStorage = localStorage.getItem('BasketQuestion');
                //var Istrue=(',' + idcss + ',').indexOf(',' + this.ID + ',') > 0;
                //var Istrue=false;
                //if (currentLocalStorage != null && currentLocalStorage != undefined && currentLocalStorage!="") {
                //    // Istrue = currentLocalStorage.toString().indexOf('"id"' + ":" + this.ID) > 0;//    
                //    Istrue=(',' + idcss + ',').indexOf(',' + this.ID + ',') > 0;
                //}
                if (isadd) {
                    html += "	<a href=\"javascript:;\" class=\"ques_removebtn fr\"  onclick=\"DelqTextBasketbal(this," + this.ID + "," + this.TypeID + "," + this.QType + "," + this.Score + ")\">移除试卷</a>";

                } else {
                    html += "	<a href=\"javascript:;\" class=\"ques_addbtn fr\"  onclick=\"AddTextBasketbal(this," + this.ID + "," + this.TypeID + "," + this.QType + "," + this.Score + ")\">加入试卷</a>";

                }
                html += "</div>";
                html += "</li>";
            });
            if (html == "") { html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>' }
            $("#Qcount").text(json.result.retData.RowCount);
            $("#qDiv").html(html);
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
            makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
            //试题篮 添加移除试题动画调用


        } else {
            $("#Qcount").text(0);
            $("#qDiv").html('<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>');
            $('.page').hide();
        }
        //试题答案隐藏显示
        $('.test_lists_basket ul li').find('.quesdiv').click(function () {
            var $hidden = $(this).children('.ques_answer');
            if ($hidden.is(':hidden')) {
                $hidden.show();
            } else {
                $hidden.hide();
            }
        });
        liveAddquesBtn();
        liveDelquesBtn();
    }
    //添加到试题篮动画
    function liveAddquesBtn() {
        $('.test_lists_basket ul li').on('click', '.ques_addbtn', function () {
            console.log(1)
            var ques = $(this).parents('li').find('.ques_body');
            var ttop = ques.offset().top, tleft = ques.offset().left, width = ques.offset().width
            twidth = ques.width(), theight = ques.height();
            //得到试题篮的位置
            var cart = $(".test_bask");
            var top = cart.offset().top, left = cart.offset().left;

            var cloneQues = ques.clone().appendTo('body');
            cloneQues.css("position", "absolute")
            .css('top', top)
            .css('left', left)
            .css('background-color', '#F2F2F2')
            .css('border', '1px solid #00A2E6')
            .css('width', cart.width())
            .css('overflow', 'hidden')
            .css('height', cart.height());

            cloneQues.animate({
                left: (tleft) + "px", top: ttop + "px", opacity: "1",
                width: twidth, height: theight
            }, 800,
            function () {
                //将clone删除掉
                cloneQues.remove();
            });
        })
    }
    //移出试题篮动画
    function liveDelquesBtn() {
        //移除试题
        $('.test_lists_basket ul li').on("click", '.ques_removebtn', function () {
            console.log(2)
            var ques = $(this).parents('li').find('.ques_body');
            var top = ques.offset().top, left = ques.offset().left,
                    width = ques.width(), height = ques.height();
            var cart = $('.test_bask');
            var ttop = cart.offset().top, tleft = cart.offset().left,
                    twidth = cart.width(), theight = cart.height();
            var cloneQues = ques.clone().appendTo('body');
            cloneQues.css("position", "absolute")
            .css('top', top + (height - 80))
            .css('left', left)
            .css('border', '1px solid #00A2E6')
            .css('background-color', '#F2F2F2')
            .css('width', width)
            .css('overflow', 'hidden')
            .css('height', height);
            cloneQues.animate({
                left: (tleft) + "px", top: ttop + "px", opacity: "0",
                width: twidth, height: theight
            },
                    800,
                    function () {
                        //将clone删除掉
                        cloneQues.remove();
                    });
        });
    }
    function typesearch(id, QType) {
        $("#hf_TypeId").val(id);
        $("#hf_Type").val(QType);
        if (QType == "") {
            $("#hf_Type").val(2);
            getData(1, 10);
            $("#hf_Type").val(1);
        } getData(1, 10);
        siblingSelect();
    }
    function SelectDifficult(difficult) {
        $("#Difficult").val(difficult);
        getData(1, 10);
        siblingSelect();

    }
    function siblingSelect() {
        $('.select_nav_right li').on('click', function () {
            $(this).addClass('on').siblings().removeClass('on');
        })
    }
    function LookQuestion(Id, Qtype) {
        OpenIFrameWindow('查看试题', 'LookQuestion.aspx?Id=' + Id + "&type=" + Qtype, '450px', '70%');
    }
    function ChangQstatus(obj, Id, Qtype) {
        var status = 1;
        if ($(this).hasClass("active")) { status = 2; }
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "ChangeQuestionStatus", DelID: ids, "Qtype": Qtype, "Status": status
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    if ($(this).hasClass("active")) { $(this).removeClass("active"); }
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }

    function deletetype(typeid, Name) {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "DelTestBasket", "Type": typeid, "TypeName": Name, CreateUID: '<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                getBaskdata();
                getData(1, 10);
                //var $btn = $('#qDiv li .ques_releasemes a');

                //if ($btn.hasClass('ques_removebtn')) {
                //    $btn.addClass('ques_addbtn').removeClass('ques_removebtn').html('加入试题');
                //    $btn.attr("onclick", $btn.attr("onclick").replace("Delq", "Add"));

                //}
                getBaskTypedata();

            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function DelqTextBasketbal(obj, id, typeid, Qtype, Score) {
        var isadd = $(obj).attr("disabled");

        //if (isadd != "disabled") {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "DelTestBasket", "ID": id, "Type": typeid, "QType": Qtype, "Score": Score, CreateUID: '<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                var html = "";
                liveDelquesBtn();
                var count = 0;
                if (json.result.errNum == 0) {

                    // $(obj).attr("disabled", "disabled");
                    //$(obj).removeClass("ques_removebtn");
                    $(obj).addClass("ques_addbtn").removeClass("ques_removebtn").html("加入试题");
                    //$(obj).html("加入试题");
                    $(obj).attr("onclick", "AddTextBasketbal(this," + id + ", " + typeid + ", " + Qtype + "," + Score + ")");
                    getBaskTypedata();
                    getBaskdata();
                }

            },
            // error: OnError
        });
        //}
    }

    $(function () {
        if ($("#HChapterID").val() != "0" && $("#HChapterID").val() != undefined) {
            getData(1, 10);
        }
    });
    function changeMenu(id) {
        $("#HChapterID").val(id);
        getData(1, 10);
    }
    function menuSel()//menu折叠展开 选中切换
    {
        $('.items').find('.units').each(function () {
            var oLi = $('.items').find('li')
            oLi.click(function () {
                oLi.removeClass('active');
                $(this).addClass('active');
            });
            $(this).find('.item_title').click(function () {
                var $next = $(this).next();
                var $icon = $(this).find('.icon');
                $icon.toggleClass('active');
                $next.stop().slideToggle();
                $('.items').find('.contentbox').not($next).slideUp();
                $('.items').find('.icon').not($icon).removeClass('active');
            })
        })
    }
</script>
<script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
