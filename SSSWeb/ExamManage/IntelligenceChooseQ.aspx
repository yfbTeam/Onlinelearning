<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IntelligenceChooseQ.aspx.cs" Inherits="SSSWeb.ExamManage.IntelligenceChooseQ" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>智能组卷</title>
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
        <%--<input id="Difficult" type="hidden" value="0" />--%>
        <!--题型-->
        <input id="Type" type="hidden" value="0" />
        <!--题型分类-->
        <input id="hf_Type" type="hidden" value="2" />
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
                        <ul>
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
                            学年
                        </div>
                        <div class="stytem_items_list fl" id="Period">
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
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix  none" id="textbookv">
                        <div class="stytem_items_title fl">
                            版本
                        </div>
                        <div class="stytem_items_list fl" id="TextbookVersion">
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
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                </div>
                <a href="javascript:;" class="moreoptions">
                    <span id="sput">更多选项</span><i class="icon icon-angle-down fr"></i>
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
                <div class="onlinetest_right fr bordshadrad pr">
                    <!---->
                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <a href="javascript:;" onclick="MakeExamPaperintelligent()">手动组卷</a>
                            <a href="javascript:;" class="on">智能组卷</a>
                        </div>
                        <div class="stytem_select_right fr">
                            <a href="ExamManager.aspx?ParentID=19">
                                <i class="icon icon-reply"></i>
                                <span>试卷管理</span>
                            </a>
                        </div>
                    </div>
                    <div class="testassem">
                        <!--智能组卷-->
                        <div class="autotest">
                            <div class="autotest_steps">
                                <p class="autotest_step">
                                    第 <span>1 </span>步 题型难度设置
                                </p>
                                <div class="autotest_setting">
                                    <div class="clearfix">
                                        <label for="">题型难易程度：</label>
                                        <span class="select">
                                            <span value="0" id="Difficult">请选择</span><i class="icon icon-angle-down"></i>
                                            <div class="enable_wrap none">
                                                <span value="" class="active" onclick="GetQSelNum(null)">请选择</span>
                                                <span value="1" onclick="GetQSelNum(1)">简单</span>
                                                <span value="2" onclick="GetQSelNum(2)">中等</span>
                                                <span value="3" onclick="GetQSelNum(3)">困难</span>
                                            </div>
                                        </span>
                                        <i class="star"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="autotest_steps">
                                <p class="autotest_step">
                                    第 <span>2 </span>步 题型数量设置
                                </p>
                                <div class="autotest_setting">
                                    <p class="test_number">
                                        题型数量：<span>已设置<span id="Number">0</span>道题</span>
                                    </p>
                                    <div class="test_setting clearfix">
                                        <span id="testqdiv"></span>
                                        <span id="testqdiv1"></span>
                                    </div>
                                </div>
                            </div>
                            <a href="javascript:;" onclick="MakeExamPaper()">
                                <input type="button" name="" class="btn" value="开始组卷" style="cursor:pointer"/></a>
                            <%--<input type="text" onblur="importevent(this.value,'nhaom')" class="btn" value="0" />--%>
                        </div>
                    </div>
                </div>

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
                                <div class="releasebtn" id="ssss">
                                    <a href="javascript:;" onclick="ClearTestbask();">清空全部</a>
                                    <a href="javascript:;" onclick="MakeExamPaper()">组卷</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="backTop mt10">
                        <span class="icon  icon-angle-up"></span>
                    </div>
                </div>
            </div>
            <script type="text/javascript" src="../js/common.js" charset="utf-8"></script>
            <script type="text/javascript" src="../js/system.js" charset="utf-8"></script>
            <%--<script type="text/javascript" src="../js/addreduce.js"></script>--%>
            <script>

                $(function () {
                    //menu显示隐藏
                    $('.grade').find('.item').click(function () {
                        clickTab($('.grade'), '.icon_right');
                    });
                })
                //试题答案隐藏显示
                $('.test_lists_basket ul li').find('.quesdiv').click(function () {
                    var $hidden = $(this).children('.ques_answer');
                    if ($hidden.is(':hidden')) {
                        $hidden.show();
                    } else {
                        $hidden.hide();
                    }
                });
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
    function getData(startIndex, pageSize) {
    }
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
            var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&Chapter=" + Chapter + "&url=IntelligenceChooseQ.aspx") : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&url=IntelligenceChooseQ.aspx")) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&url=IntelligenceChooseQ.aspx")) : ("?Period=" + Period + "&Subject=" + Subject + "&url=IntelligenceChooseQ.aspx")) : "?Period=" + Period + "&url=IntelligenceChooseQ.aspx") : "?url=IntelligenceChooseQ.aspx";
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
        location.href = "ManualChooseQ.aspx" + parm;
    }
    var book = "";
    var HPeriodid = $("#HPeriodid").val();
    var HSubjectid = $("#HSubjectid").val();
    var HTextbooxid = $("#HTextbooxid").val();
    var bookVersionid = $("#bookVersionid").val();
    var HChapterIDid = $("#HChapterIDid").val();
    $(function () {
        $("#HPeriod").val(HPeriodid);
        $("#HSubject").val(HSubjectid);
        $("#bookVersion").val(bookVersionid);
        $("#HTextboox").val(HTextbooxid);
        $("#HChapterID").val(HChapterIDid);
        getBaskTypedata();
        BindCatagory();
    });
    //获取各种题型选择的题目数量
    function GetQSelNum(Difficulty) {
        GetObjQusetionByDif(Difficulty);
        GetSubQusetionByDif(Difficulty);
    }
    function GetObjQusetionByDif(Difficulty) {
        var Klpoint = $("#HChapterID").val();
        var FuncName = "GetExamObjQList";
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "GetObjQusetionByDif", "Difficulty": Difficulty, "Klpoint": Klpoint
            },
            success: function (json) {
                var html = "";
                $.each(json.result.retData, function () {
                    html += "<div class=\"clearfix\">"
                                        + "<label for=\"\">" + this.Name + "</label>"
                                        + "<span onclick=\"addrandom('" + this.Name + "','" + FuncName + "',this,'Exam_ObjQuestion'," + this.sum+ ")\">+</span>"
                                        + "<input type=\"text\" onblur=\"importevent(this.value,'" + this.Name + "','" + FuncName + "')\" value=\"0\" />"
                                        + "<span onclick=\"delrandom('" + FuncName + "')\">-</span>"
                                        + "<em>共设置<i>0</i>道题</em>"
                                    + "</div>";

                });
                $("#testqdiv").html(html);
            }
        });
    }
    function GetSubQusetionByDif(Difficulty) {
        var Klpoint = $("#HChapterID").val();
        // var actionzhu = "GetSubQNum";
        var actionzhu = "GetExamSubQList";

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "GetSubQusetionByDif", "Difficulty": Difficulty, "Klpoint": Klpoint
            },
            success: function (json) {
                var html = "";
                //var count = 0;
                $.each(json.result.retData, function () {
                    //count = parseInt(this.Count) + parseInt(count);
                    html += "<div class=\"clearfix\">"
                                        + "<label for=\"\" >" + this.Name + "</label>"
                                        + "<span onclick=\"addrandom('" + this.Name + "','" + actionzhu + "',this,'Exam_SubQuestion',"+this.sum+")\">+</span>"
                                        + "<input type=\"text\" onblur=\"importevent(this.value,'" + this.Name + "','" + actionzhu + "')\" value=\"0\" />"
                                        + "<span onclick=\"delrandom('" + actionzhu + "')\">-</span>"
                                        + "<em>共设置<i>0</i>道题</em>"
                                    + "</div>";
                });
                $("#testqdiv1").html(html);
                var totalText = $('.test_number').find('#Number');
                $('.test_setting>span>div').each(function () {
                    var $curInput = $(this).find('input');
                    var $add = $(this).find('span:eq(0)');
                    var $reduce = $(this).find('span:eq(1)');
                    var $curNumber = $(this).find('em').children('i');
                    $add.click(function () {
                        var n = Number($curInput.val()) + 1;
                        $curInput.val(n);
                        $curNumber.text(n);
                        totalText.text(sum());
                    })
                    $reduce.click(function () {
                        var n = Number($curInput.val()) - 1;
                        if (n < 0) {
                            return;
                        };
                        $curInput.val(n);
                        $curNumber.text(n);
                        totalText.text(sum());
                    })
                    $curInput.blur(function () {
                        var $val = Number($(this).val());
                        $curNumber.text($val);
                        totalText.text(sum());
                    })
                })
                function sum() {
                    var sum = 0;
                    $('.test_setting').find('em').children('i').each(function (i, elem) {

                        sum += Number($(elem).text());
                    })
                    return sum;
                }
            }
        });
    }

    function delQNum() { }
    var arrke = [];
    var arrzhu = [];
   
    function AddTextBasketbal(Title, TableName) {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "AddBasketOfRandom", "Type": Title, "TableName": TableName,CreateUID:'<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                if (json.result.errNum == 0) {
                    getBaskTypedata();
                }

            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function addrandom(Title, action, em, TableName,sum) {
        AddTextBasketbal(Title,TableName);
        var totalText = $('.test_number').find('#Number');
        var $curInput = $(em).parent().find('input');
        var $curNumber = $(this).find('em').children('i');
        var n = Number($curInput.val());
        if (n>sum) {
            $curInput.val(n - 1);
            $curNumber.text(n - 1);
            var totalNum = Number(totalText.text()) - 1;
            totalText.text(totalNum);
            layer.msg("题库试题不足");
        }



        /*var arrray = [];
        var json = {};
        var id = 0;
        //var actionke = "checkrandomIDke";
        var actionke = "GetExamObjQList";
        // var actionzhu = "checkrandomIDzhu";
        var actionzhu = "GetExamSubQList";

        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/ExamManage/QuestionHander.ashx", "action": action, "QTypeName": Title, "IsPage": "false" },
            success: function (json) {
                var totalText = $('.test_number').find('#Number');
                var $curInput = $(em).parent().find('input');
                var $curNumber = $(this).find('em').children('i');
                var n = Number($curInput.val());

                if (json.result.errNum == "0") {

                    
                    //新添加到购物车
                    $.each(json.result.retData, function () {
                        arrray.push(this.ID);
                    })
                    if (action == "GetExamObjQList") {
                        id = arrray[Math.floor(Math.random() * arrray.length)];
                        if (!json[id]) {
                            json[id] = 1;
                            arrke.push(id);
                            checkrandom(id, actionke);
                        }
                    }
                    else if (action == "GetExamSubQList") {
                        id = arrray[Math.floor(Math.random() * arrray.length)];
                        if (!json[id]) {
                            json[id] = 1;
                            arrzhu.push(id);
                            checkrandom(id, actionzhu);
                        }
                    }

                }
                else {
                    $curInput.val(n - 1);
                    $curNumber.text(n - 1);
                    var totalNum = Number(totalText.text()) - 1;
                    totalText.text(totalNum);
                    layer.msg("题库没有符合条件的试题");
                }

            }
        });*/
    }
    function delrandom(action) {
        var id = 0;
        //var actionke = "checkrandomIDke";
        var actionke = "GetExamObjQList";
        //var actionzhu = "checkrandomIDzhu";
        var actionzhu = "GetExamSubQList";
        if (action == "GetExamObjQList") {
            id = arrke[Math.floor(Math.random() * arrke.length)];
            arrke.splice($.inArray(id, arrke), 1);
            checkrandomdel(id, actionke);
        } else if (action == "GetExamSubQList") {
            id = arrzhu[Math.floor(Math.random() * arrzhu.length)];
            arrzhu.splice($.inArray(id, arrzhu), 1);
            checkrandomdel(id, actionzhu);
        }

    }
    function checkrandomdel(id, action) {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/ExamNationHander.ashx",
                "action": action, "ID": id
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    DelqTextBasketbal(this, this.ID, this.Type, this.QType, this.Score);
                })
            }
        });
    }
    function checkrandom(id, action) {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": action, "ID": id, "IsPage": "false"
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    AddTextBasketbal(this, this.ID, this.Type, this.QType, this.Score);
                })
            }
        });
    }

    function CheckNumber(obj, id, type) {
        if ($(obj).val().length > 0) {
            if (isNaN($(obj).val())) {
                alert("请正确输入！");
                $(obj).val($(obj).next().val());
                return;
            }
            if ($(obj).val().indexOf('.') >= 0 || $(obj).val() < 0) {
                alert("请输入正数！");
                $(obj).val($(obj).next().val());
                return;
            }
        } else {
            alert("请输入数量!");
            $(obj).val($(obj).next().val());
            return;
        }
        if ($(obj).val() == $(obj).next().val()) {
            return;
        }
        if (parseInt($(obj).val()) > parseInt($(obj).next().next().val())) {
            alert("请输入不超过总题数的数字!");
            $(obj).val($(obj).next().val());
            return;
        }
        var diff = $('#Difficult').attr('value');
        var num = $(obj).val();
        var oldnum = $(obj).next().val();
        if (id != null && id != "" && type != null && type != "" && num != null && num != "") {
            jQuery.ajax({
                url: "../Common.ashx",   // 提交的页面
                type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
                data: {
                    PageName: "/ExamManage/QuestionHander.ashx",
                    "action": "ChangeNum",
                    "id": id, "type": type, "oldnum": oldnum, "num": num, "diff": diff
                },
                beforeSend: function ()          // 设置表单提交前方法
                {
                },
                error: function (request) {      // 设置表单提交出错

                },
                success: function (result) {
                    if (result.result.errNum == 0) {
                        //修改显示（数量/金额）
                        if (parseInt($('#Number').html()) + parseInt(result.result.retData) >= 0) {
                            $('#Number').html(parseInt($('#Number').html()) + parseInt(json.result.retData));
                        }
                        $(obj).val(parseInt($(obj).next().val()) + parseInt(json.result.retData));
                        $(obj).next().val(parseInt($(obj).next().val()) + parseInt(json.result.retData));
                    } else {
                        $(obj).val($(obj).next().val());
                    }
                }

            });
        }
    }
   
    function DelqTextBasketbal(obj, id, typeid, Qtype, Score) {
        var isadd = $(obj).attr("disabled");
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
                var count = 0;
                if (json.result.errNum == 0) {
                    $(obj).removeClass("ques_removebtn");
                    $(obj).addClass("ques_addbtn");
                    $(obj).html("加入试题");
                    $(obj).attr("onclick", "AddTextBasketbal(this," + id + ", " + typeid + ", " + Qtype + "," + Score + ")");
                    getBaskTypedata();
                }

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
                "action": "getTextBasketTypeQ", "Type": "Random", CreateUID: '<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                var html = "";
                var count = 0;
                $.each(json.result.retData, function () {
                    count = parseInt(this.Count) + parseInt(count);
                    html += "<li><span>" + this.Type + "</span><span>" + this.Count + " 题 </span><span><i class=\"icona icon-trash\" onclick=\"deletetype(" + this.TypeID + ",'" + this.Type + "')\"></i></span></li>";


                });
                $("#baskul").html(html);
                $("#tcount").html(count);
                $("#i_test_num").html(count);
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function ClearTestbask() {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "DelTestBasket", Type: "Radom", CreateUID: '<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                getBaskTypedata();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function deletetype(typeid, TypeName) {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/ExamManage/QuestionHander.ashx",
                "action": "DelTestBasket", "Type": typeid, TypeName: TypeName, Type: "Radom", CreateUID: '<%=UserInfo.UniqueNo %>'
            },
            success: function (json) {
                getBaskTypedata();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function AddNum(obj, Id, typeid) {
        var prevobj = $(obj).next();
        var diff = $('#Difficult').attr('value');
        jQuery.ajax({
            url: "../Common.ashx",   // 提交的页面
            type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
            data: {
                PageName: "/ExamManage/ExamManage.ashx",
                "action": "AddNum",
                "id": Id, "type": typeid, "diff": diff
            },
            beforeSend: function ()          // 设置表单提交前方法
            {
            },
            error: function (request) {      // 设置表单提交出错
            },
            success: function (result) {
                if (result.result.errNum == 0) {
                    //修改显示（数量/金额）
                    var nownum = parseInt($(prevobj).val()) + parseInt(json.result.retData);
                    $(prevobj).val(nownum);

                    $('#Number').html(parseInt($('#Number').html()) + parseInt(json.result.retData));
                    $(prevobj).next().val(nownum);

                } else { $(prevobj).val($(prevobj).next().val()); }
            }

        });
    }
    //function ReduceNum(obj, Id, typeid) {
    //    var nextvobj = $(obj).parent().find("[id$='txtNumber']");
    //    var newcount = parseInt($(nextvobj).val()) + parseInt(-1);
    //    var diff = $('#Difficult').attr('value');
    //    if (parseInt(newcount) >= 0) {
    //        jQuery.ajax({
    //            url: "../Common.ashx",   // 提交的页面
    //            type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
    //            data: {
    //                PageName: "/Exam/ExamHandler.ashx",
    //                "action": "ReduceNum",
    //                "id": Id, "type": typeid, "diff": diff
    //            },
    //            beforeSend: function ()          // 设置表单提交前方法
    //            {

    //            },
    //            error: function (request) {      // 设置表单提交出错
    //            },
    //            success: function (result) {
    //                if (result.result.errNum == 0) {
    //                    //修改显示（数量）
    //                    $(nextvobj).val(parseInt($(nextvobj).val()) + parseInt(-1));
    //                    $('#Number').html(parseInt($('#Number').html()) + parseInt(-1));
    //                    $(nextvobj).next().val($(nextvobj).val());
    //                } else { $(nextvobj).val($(nextvobj).next().val()); }
    //            }

    //        });
    //    }
    //}


    function changeMenu(id) {
        $("#HChapterID").val(id);
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


