<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamQManager.aspx.cs" Inherits="SSSWeb.ExamManage.ExamQManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>题库管理</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script id="tr_Question" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="test_description fl">
                <h2>
                    <a style="width: 50px;" onclick="LookQuestion(${ID},${QType})" href="#">${Content}</a>
                    <span class="test_type">${Type}</span>
                    {{if Difficulty==1}}<span class="test_easy">${DifficultyShow}</span>
                    {{else}}{{if Status==2}}<span class="test_normal">${DifficultyShow}</span>
                    {{else}}<span class="test_trouble">${DifficultyShow}</span>
                    {{/if}}{{/if}}
                </h2>
                <p>${Content}</p>
            </div>
            <div class="test_lists_right fr clearfix">
                <div class="dates_a fr">
                    <div class="seedeletion none" style="display: none;">
                        <i title="查看" class="icon icon-eye-open" onclick="LookQuestion(${ID},${QType})"></i>
                        <i title="删除" class="icon  icon-trash" onclick="DelQuestion(${ID},${QType})"></i>
                        <i title="编辑" class="icon  icon-edit" onclick="EditQuestion(${ID},${TypeID},${QType})"></i>
                        {{if Status==2}}
                        <i title="启用" class="icon icon-ok-circle" onclick="ChangQstatus(this,${ID},${QType})"></i>
                        {{else}}<i title="禁用" class="icon  icon-ban-circle" onclick="ChangQstatus(this,${ID},${QType})"></i>
                        {{/if}}
                    </div>
                    <div class="data">${CreateTime}</div>
                </div>
            </div>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo %>" />

        <%-- 学段--%>
        <input id="HPeriod" type="hidden" value="0" />
        <%-- 科目--%>
        <input id="HSubject" type="hidden" value="0" />
        <%-- 教材--%>
        <input id="HTextboox" type="hidden" value="0" />
        <%-- 目录--%>
        <input id="HChapterID" type="hidden" value="0" />
        <input id="HChapterPid" type="hidden" value="0" />
        <%-- 版本--%>
        <input id="bookVersion" type="hidden" value="0" />
        <%--试题小类--%>
        <input id="hf_TypeId" type="hidden" />
        <%--试题大类--%>
        <input id="hf_Type" type="hidden" />
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
                            <li class="active"><a href="ExamQManager.aspx">题库管理</a></li>
                            <li currentclass="active"><a href="ExamManager.aspx">试卷管理</a></li>
                            <li currentclass="active"><a href="MyExam.aspx">考试管理</a></li>
                            <li currentclass="active"><a href="ExamAnalisy.aspx">考试分析</a></li>
                        </ul>
                    </nav>
                    <div class="search_account fr clearfix">
                        <ul class="account_area fl">

                            <li>
                                <a href="javascript:;" class="login_area clearfix">
                                    <div class="avatar">
                                        <img src="<%=UserInfo.AbsHeadPic %>" />
                                    </div>
                                    <h2><%=UserInfo.Name %></h2>
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
                            专业
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
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
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
                        <div class="stytem_select_left fl" id="qTypediv"></div>
                        <div class="stytem_select_right fr">
                            <span class="enable">
                                <select id="Status" onchange="getData(1, 10)" style="height: 28px;">
                                    <option value="1" selected="selected">启用</option>
                                    <option value="2">禁用</option>
                                </select>

                            </span>
                            <div class="search_exam fl pr">
                                <input type="text" name="Title" id="Title" value="" placeholder="试题" />
                                <i class="icon  icon-search" onclick="getData(1, 10)"></i>
                            </div>
                            <a href="javascript:;" class="addtest"><i class="icon icon-plus"></i>添加试题
							<div class="addtest_wrap none">
                                <em onclick="AddQuestion();">新增试题</em>
                                <%--<em onclick="ImportQuestion();">导入试题</em>--%>
                            </div>
                            </a>
                        </div>
                    </div>
                    <div class="test_norelase">
                        <ul class="test_lists" id="ExamQdiv"></ul>
                    </div>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
            <input id="hf_Book" type="hidden" /><input id="hf_Klpoint" type="hidden" />
            <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
            <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
            <script>
                $(function () {
                    //menu显示隐藏
                    $('.grade').find('.item').click(function () {
                        clickTab($('.grade'), '.icon_right');
                    });
                })
            </script>
        </div>
    </form>
    <script src="CatagoryCommon.js"></script>

</body>
</html>
<script type="text/javascript">

    $(function () {
        GetSameLiveMenu(location.href, '<%=UserInfo.UniqueNo%>', '');
        GetType();
        BindCatagory();
        getData(1, 10);
    });
    //试题类型
    function GetType() {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/ExamManage/QuestionHander.ashx", "action": "GetQuestionTypeList" },
            success: function (json) {
                var html = "";
                var i = 0;
                $.each(json.result.retData, function () {
                    if (i == 0) {
                        html += "<a href=\"javascript:void(0);\" class=\"on\"  onclick='SelQuestionByType(" + this.ID + "," + this.QType + ")'>" + this.Name + "</a>";
                        $("#hf_TypeId").val(this.ID);//单选、多选、简答、选择
                        $("#hf_Type").val(this.QType);//主管、客观
                        i++;
                    } else {
                        html += "<a href=\"javascript:void(0);\" onclick='SelQuestionByType(" + this.ID + "," + this.QType + ")'>" + this.Name + "</a>";
                        i++;
                    }
                });
                $("#qTypediv").html(html);
                $('.stytem_select_left a').click(function () {
                    $(this).addClass('on').siblings().removeClass('on');
                });
            },
            error: function (json) {
                $("#qTypediv").html(json.result.errMsg.toString());
            }
        });
    }
    //根据试题类型筛选（单选、多选、简答、选择）
    function SelQuestionByType(id, qtype) {
        $("#hf_TypeId").val(id);
        $("#hf_Type").val(qtype);
        getData(1, 10);
    }

    //新增试题
    function AddQuestion() {
        var HPeriod = $("#HPeriod").val().trim();
        var HSubject = $("#HSubject").val().trim();
        var HTextboox = $("#HTextboox").val().trim();
        var bookVersion = $("#bookVersion").val().trim();
        var HChapterID = $("#HChapterID").val().trim();
        var HChapterPid = $("#HChapterPid").val().trim();
        var parm = "?HPeriod=" + HPeriod + "&HSubject=" + HSubject + "&bookVersion=" + bookVersion + "&HTextboox=" + HTextboox + "&HChapterID=" + HChapterID + "&HChapterPid=" + HChapterPid.trim();

        if (HPeriod == "" || HSubject == "" || HTextboox == "" || bookVersion == "" || HChapterID == "") {
            layer.msg("请选择目录结构");
        }
        else {
            OpenIFrameWindow('新增试题', 'AddQuestion.aspx' + parm, '800px', '70%');
        }
    }
    //修改试题
    function EditQuestion(Id, type, QType) {
        OpenIFrameWindow('编辑试题', 'EditQuestion.aspx?Id=' + Id + "&type=" + QType + "&TypeID=" + type, '830px', '70%');
    }
    //启用、禁用试题
    function ChangQstatus(obj, Id, Qtype) {
        var status = 2;
        if ($(obj).hasClass("icon-ok-circle")) { status = 1; }
        var str = status == 1 ? "启用" : "禁用";

        layer.msg("确定要" + str + "该试题?", {
            time: 0, //不自动关闭
            btn: ['确定', '取消'],
            yes: function (index) {
                layer.close(index);
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { PageName: "/ExamManage/QuestionHander.ashx", "action": "ChangeQuestionStatus", QuesID: Id, "Qtype": Qtype, "Status": status },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            getData(1, 10);
                        }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }
        });
    }
    //查看试题
    function LookQuestion(Id, Qtype) {
        OpenIFrameWindow('查看试题', 'LookQuestion.aspx?Id=' + Id + "&type=" + Qtype, '780px', '70%');
    }
    //删除试题
    function DelQuestion(Id, Qtype) {
        layer.msg("确定要删除该试题?", {
            time: 0 //不自动关闭
           , btn: ['确定', '取消']
           , yes: function (index) {
               layer.close(index);
               $.ajax({
                   url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                   type: "post",
                   async: false,
                   dataType: "json",
                   data: {
                       PageName: "/ExamManage/QuestionHander.ashx",
                       "action": "DelQuestion", DelID: Id, "Qtype": Qtype
                   },
                   success: function (json) {
                       if (json.result.errNum.toString() == "0") {
                           layer.msg("删除成功");
                           getData(1, 10);
                       }
                       else { layer.msg('删除失败！'); }
                   },
                   error: function (errMsg) {
                       layer.msg('删除失败！');
                   }
               });
           }
        });
    }
    var book = "";
    //获取试题数据
    function getData(startIndex, pageSize) {
        var Period = $("#HPeriod").val() == "0" ? "0" : $("#HPeriod").val();
        var Subject = $("#HSubject").val() == "0" ? "0" : $("#HSubject").val();
        var bookVersion = $("#bookVersion").val() == "0" ? "0" : $("#bookVersion").val();
        var hidTextboox = $("#HTextboox").val() == "0" ? "0" : $("#HTextboox").val();
        var MajorID = book;
        var Chapter = $("#HChapterID").val();
        var Status = $("#Status").val();
        var TypeId = $("#hf_TypeId").val();
        var Title = $("#Title").val();
        var qtype = $("#hf_Type").val();
        var action = "GetExamSubQList";
        if (qtype != 2) {
            action = "GetExamObjQList";
        }
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": action, PageIndex: startIndex, pageSize: pageSize,
                "KlpointID": Chapter, "Status": Status, "Type": TypeId, "Title": Title, "MajorID": MajorID
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(".page").show();
                    $("#ExamQdiv").html('');
                    $("#tr_Question").tmpl(json.result.retData.PagedData).appendTo("#ExamQdiv");
                    $("#ExamQdiv").html(html);
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
                    //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                    HoverQuestion();
                } else {
                    $(".page").hide();
                    var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
                    $("#ExamQdiv").html(html);
                }
            },
            error: function (Msg) {
                layer.msg(Msg);
            }
        });
    }
    function HoverQuestion() {
        //题库管理
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

</script>
