
/*试题分类*/
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
//学段
function BindPeriod() {
    $("#Period").children().remove();
    var option = "<a href=\"javascript:;\" id='0' onclick=' PeriodChangeall(0,this)' value=\"全部\">全部</a>";
    $("#Period").append(option);

    if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
        for (var i = 0, nm = CatagoryJson.GradeOfSubject.retData; i < nm.length; i++) {
            if (i == 0) {
                option = "<a href=\"javascript:;\" class=\"on\" id=\"gradename\" onclick=' PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].Name + "</a>";
                $("#Period").append(option);
                $("#HPeriod").val(nm[i].GradeID);
                BindSubject();
            }
            else if (nm[i].Name != nm[i - 1].Name) {
                option = "<a href=\"javascript:;\" id=\"gradename\"' onclick='PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].Name + "</a>";
                $("#Period").append(option);
            }

        }
    }
    else {
        layer.msg(CatagoryJson.Period.errMsg);
    }
}
var gradeid = 0;
var booo = "";
function PeriodChangeall(GradeID, em) {
    $("#textbook").html("全部");
    gradeid = GradeID;
    $("#HTextboox").val(0);
    $("#HPeriod").val(GradeID);
    BindSubject();
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    $("#Title").val("");
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#sel_Type").val("");
    book = "";
    booo = book;
    getData(1, 10);
}

function PeriodChange(GradeID, em) {
    $("#textbook").html("全部");
    gradeid = GradeID;
    book = "" + GradeID + "|%|%|%";
    $("#HTextboox").val(0);
    TopMenuNum = 0;
    $("#HPeriod").val(GradeID);
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    BindSubject();
    booo = book;
    getData(1, 10);
}
//科目
function BindSubject() {

    //var Period = $("#Period").val();
    //$("#HPeriod").val();
    $("#Subject").children().remove();
    var SelPeriod = $("#HPeriod").val();
    $("#HChapterID").val("");

    if (SelPeriod == "0") {
        option = "<a id='0'  class='on' onclick='SubjectChangeall(this)'>全部</a>";
        $("#Subject").append(option);
        $("#HChapterID").val("");
        //版本
        TextbookVersion();
        return;
    }

    option = "<a id='0' onclick='SubjectChangeall(this)'>全部</a>";
    $("#Subject").append(option);
    if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
        var j = 0;
        $(CatagoryJson.GradeOfSubject.retData).each(function () {

            var option = "";
            if (this.GradeID == SelPeriod) {
                if (j == 0) {

                    option = "<a  class='on' id='" + this.SubjectID + "'  onclick='SubjectChange(this," + this.GradeID + ")'>" + this.SubjectName + "</a>";
                    $("#HSubject").val(this.GradeID);
                  

                    book = "" + SelPeriod + "|" + this.SubjectID + "|%";
                    TopMenuNum = 0;
                    $("#HSubject").val(this.SubjectID);
                    $("#HChapterID").val("");
                    $("#HTextboox").val(0);
                    if ($("#HTextboox").val() == "0") {
                        Chapator();
                    }
                    //版本
                    TextbookVersion();
                    bok = book;
                    getData(1, 10);

                }
                else {
                    option = "<a id='" + this.SubjectID + "'onclick='SubjectChange(this," + this.GradeID + ")'> " + this.SubjectName + "</a>";
                }
                j++;
                $("#Subject").append(option);
            }

        })
    }
    else {
        layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
    }
}
var emid = 0;
var bok = "";
function SubjectChangeall(em) {
    $("#sput").html("收起");
    $("#textbookv").attr("style", "display: block;");
    $("#text").attr("style", "display: block;");
    $("#angle-down").attr("class", "icon fr icon-angle-up");
    $("#textbook").html("全部");
    emid = em.id;
    book = booo;
    $("#HSubject").val(em.id);
    TextbookVersion();
    $("#HTextboox").val(0);
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    //版本
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#sel_Type").val("");
    $("#Title").val("");
    bok = book;
    getData(1, 10);
}

function SubjectChange(em, GradeID) {
    $("#sput").html("收起");
    $("#textbookv").attr("style", "display: block;");
    $("#text").attr("style", "display: block;");
    $("#angle-down").attr("class", "icon fr icon-angle-up");
    $("#textbook").html("全部");
    emid = em.id;
    book = "" + GradeID + "|" + em.id + "|%|%";
    TopMenuNum = 0;
    $("#HSubject").val(em.id);
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#HTextboox").val(0);
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    //版本
    TextbookVersion();
    bok = book;
    getData(1, 10);
}
//版本
function TextbookVersion() {
    $("#TextbookVersion").children().remove();
    var currentPeriod = $("#HPeriod").val();
    var currentSubjectID = $("#HSubject").val();
    $("#HChapterID").val("");
    $("#HTextboox").val(0);
    if (currentPeriod == "0" || currentSubjectID == "0") {
        option = "<a id='0' class='on' onclick='VersionChangeall(this)'>全部</a>";
        $("#TextbookVersion").append(option);
        $("#HChapterID").val("");
        Textbook();
        return;
    }
    option = "<a id='0'  onclick='VersionChangeall(this)'>全部</a>";
    $("#TextbookVersion").append(option);
    if (CatagoryJson.TextbookVersion.errNum.toString() == "0") {
        var i = 0

        $(CatagoryJson.TextbookVersion.retData).each(function () {

            var option = "";
            if (i == 0) {

                option = "<a  class='on' id='" + this.ID + "'  onclick='VersionChange(this)'>" + this.Name + "</a>";
                $("#bookVersion").val(this.ID);
                Textbook();
            }
            else {
                option = "<a id='" + this.ID + "' onclick='VersionChange(this)'>" + this.Name + "</a>";
            }
            $("#TextbookVersion").append(option);
            i++;
        })
    }
    else {
        layer.msg(CatagoryJson.TextbookVersion.errMsg);
    }
}
var vcid = 0;
var bk = "";
function VersionChangeall(em) {
    $("#textbook").html("全部");
    vcid = em.id;
    book = bok;
    $("#bookVersion").val(em.id);
    Textbook();
    $("#HTextboox").val(0);
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    //版本
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#sel_Type").val("");
    $("#Title").val("");
    bk = book;
    getData(1, 10);
}

function VersionChange(em) {
    $("#textbook").html("全部");
    vcid = em.id;
    book = "" + gradeid + "|" + emid + "|" + vcid + "|%";
    i = 0;
    TopMenuNum = 0;
    $("#bookVersion").val(em.id);
    $(em).addClass("on").siblings().removeClass("on");
    $("#HTextboox").val(0);
    $("#HChapterID").val("");
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    Textbook();
    bk = book;
    getData(1, 10);
}
//教材
function Textbook() {
    $("#HTextboox").val(0);
    var currentPeriod = $("#HPeriod").val();
    var currentSubjectID = $("#HSubject").val();
    $("#Textbook").children().remove();
    var bookVersion = $("#bookVersion").val();
    if (currentPeriod == "0" || currentSubjectID == "0" || bookVersion == "0") {
        option = "<a id='0' onclick=' TextbookChangeall(this)'>全部</a>";
        $("#Textbook").append(option);
        $("#BookName").html("全部");
        $("#HTextboox").val("0");
        return;
    }
    option = "<a id='0' onclick=' TextbookChangeall(this)'>全部</a>";
    $("#Textbook").append(option);
    if (CatagoryJson.Textbook.errNum.toString() == "0") {

        var i = 0;
        $(CatagoryJson.Textbook.retData).each(function () {
            var option = "";
            if (bookVersion == this.VersionID && currentPeriod == this.MajorID && currentSubjectID == this.SubID) {

                if (i == 0) {
                    option = "<a  class='on' id='" + this.ID + "' onclick=' TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                    $("#BookName").html(this.Name);
                    $("#HTextboox").val(this.ID);
                    Chapator();
                }
                else {
                    option = "<a id='" + this.ID + "' onclick='TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                }
                $("#Textbook").append(option);
                i++;
            }

        })
    }
    else {
        layer.msg(CatagoryJson.Textbook.errMsg);
    }
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
}
var tbid = 0;
var btk = "";
function TextbookChangeall(em) {
    $("#textbook").html("全部");
    tbid = em.id;
    book = bk;
    $("#HTextboox").val(em.id);
    //版本
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#sel_Type").val("");
    $("#Title").val("");
    btk = book;
    Chapator();
    getData(1, 10);
}

function TextbookChange(em) {
    $("#textbook").html(em.name);
    tbid = em.id;
    book = "" + gradeid + "|" + emid + "|" + vcid + "|" + tbid + "";
    TopMenuNum = 0;
    $(em).addClass("on").siblings().removeClass("on");
    $("#BookName").html($("#Textbook").text());
    $("#HTextboox").val(em.id);
    $("#HChapterID").val("");
    Chapator();
    btk = book;
    getData(1, 10);
}
var chapterjson = "";
function Chapator() {
    $.ajax({
        url: "../SystemSettings/EduHander.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: { "PageName": "TextbookCatalogHandler.ashx", "Func": "GetBookCatalog", "IsPage": "false" },
        success: function (json) {
            chapterjson = json;
            //BindleftMenu(json);
            if (json.result.errNum.toString() == "0") {
                div = "";
                BindleftMenu(json.result.retData, 0);
                $("#menuChapater").html("");
                $("#menuChapater").append(div);
                menuSel();
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
var div = "";
var TopMenuNum = 0;
var chapter = "";
function BindleftMenu(data, id) {
    var i = 0;
    $(data).each(function () {
        if (this.BookID == $("#HTextboox").val()) {

            if (this.Pid == 0 && this.Pid == id) {
                div += "<div class=\"units\">";
                div += " <div class=\"item_title\"><span class=\"text\" onclick=\"chapter('" + this.Name + "')\">" + this.Name + "</span><span class=\"icon icon-angle-down\"></span></div>";
                BindleftMenu(data, this.ID);
                if (i > 0) {
                    div += "</ul>";
                }
                i = 0;
                div += "</div>";
                TopMenuNum++;
            }
            if (this.Pid != 0 && this.Pid == id) {
                if (TopMenuNum == 0 && i == 0) {
                    div += "<ul class=\"contentbox\" style=\"display: block;\"><li class=\"active\" onclick=\"changeMenu(" + this.ID + "," + this.Pid + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                    $("#HChapterID").val(this.ID);
                    $("#HChapterPid").val(this.Pid);

                    //getData(1, 10);
                }
                if (TopMenuNum > 0 && i == 0) {
                    div += "<ul class=\"contentbox\"><li onclick=\"changeMenu(" + this.ID + "," + this.Pid + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                }
                if (i > 0) {
                    div += "<li onclick=\"changeMenu(" + this.ID + "," + this.Pid + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                }
                i++;
            }
        }
    })
    if ($("#HChapterID").val() != "0" && $("#HChapterID").val() != undefined) {
        //getData(1, 10);
    }
}

function chapter(Name) {
    chapter = Name;
}
var joint = "";
function changeMenu(id, pid) {
    //joint = Name;
    $("#HChapterID").val(id);
    $("#HChapterPid").val(pid);

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
/*
function BindCatagory() {
    $.ajax({
        url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: { "PageName": "InitialDataHandler.ashx", "Func": "GetPSTVData" },
        success: function (json) {
            CatagoryJson = json;
            //学年
            BindPeriod();
        },
        error: function (errMsg) {
            layer.msg(errMsg);
        }
    });
}

//学年
function BindPeriod() {
    $("#Period").children().remove();
    option = "<a href=\"javascript:;\" id='0' class=\"on\" onclick=' PeriodChangeall(0,this)' value=\"全部\">全部</a>";
    $("#Period").append(option);
    $("#HChapterID").val(0);
    if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
        for (var i = 0, nm = CatagoryJson.GradeOfSubject.retData; i < nm.length; i++) {

            if (i == 0) {
                option = "<a href=\"javascript:;\" id=\"gradename\" onclick=' PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].GradeName + "</a>";
                $("#HPeriod").val(0);
                $("#Period").append(option);
                BindSubject();
            }
            else if (nm[i].GradeName != nm[i - 1].GradeName) {
                option = "<a href=\"javascript:;\" id=\"gradename\"' onclick='PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].GradeName + "</a>";
                $("#Period").append(option);
            }

        }
    }
    else {
        layer.msg(CatagoryJson.Period.errMsg);
    }
}
var gradeid = 0;
var booo = "";
function PeriodChangeall(GradeID, em) {
    $("#textbook").html("全部");
    gradeid = GradeID;
    $("#HTextboox").val(0);
    $("#HPeriod").val(GradeID);
    BindSubject();
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    $("#Title").val("");
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#sel_Type").val("");
    book = "";
    booo = book;
    getData(1, 10);
}

function PeriodChange(GradeID, em) {
    $("#textbook").html("全部");
    gradeid = GradeID;
    book = "" + GradeID + "|%|%|%";
    $("#HTextboox").val(0);
    TopMenuNum = 0;
    $("#HPeriod").val(GradeID);
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    BindSubject();
    booo = book;
    getData(1, 10);
}
//科目
function BindSubject() {

    //var Period = $("#Period").val();
    //$("#HPeriod").val();
    $("#Subject").children().remove();
    var SelPeriod = $("#HPeriod").val();
    $("#HChapterID").val("");

    if (SelPeriod == "0") {
        option = "<a id='0'  class='on' onclick='SubjectChangeall(this)'>全部</a>";
        $("#Subject").append(option);
        $("#HChapterID").val("");
        //版本
        TextbookVersion();
        return;
    }

    option = "<a id='0' class='on' onclick='SubjectChangeall(this)'>全部</a>";
    $("#Subject").append(option);
    if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
        var j = 0;
        $(CatagoryJson.GradeOfSubject.retData).each(function () {

            var option = "";
            if (this.GradeID == SelPeriod) {
                if (j == 0) {

                    option = "<a id='" + this.SubjectID + "'  onclick='SubjectChange(this," + this.GradeID + ")'>" + this.SubjectName + "</a>";
                    $("#HSubject").val(0);
                    //版本
                    TextbookVersion();
                }
                else {
                    option = "<a id='" + this.SubjectID + "'onclick='SubjectChange(this," + this.GradeID + ")'> " + this.SubjectName + "</a>";
                }
                j++;
                $("#Subject").append(option);
            }

        })
    }
    else {
        layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
    }
}
var emid = 0;
var bok = "";
function SubjectChangeall(em) {
    $("#sput").html("收起");
    $("#textbookv").attr("style", "display: block;");
    $("#text").attr("style", "display: block;");
    $("#angle-down").attr("class", "icon fr icon-angle-up");
    $("#textbook").html("全部");
    emid = em.id;
    book = booo;
    $("#HSubject").val(em.id);
    TextbookVersion();
    $("#HTextboox").val(0);
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    //版本
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#sel_Type").val("");
    $("#Title").val("");
    bok = book;
    getData(1, 10);
}

function SubjectChange(em, GradeID) {
    $("#sput").html("收起");
    $("#textbookv").attr("style", "display: block;");
    $("#text").attr("style", "display: block;");
    $("#angle-down").attr("class", "icon fr icon-angle-up");
    $("#textbook").html("全部");
    emid = em.id;
    book = "" + GradeID + "|" + em.id + "|%|%";
    TopMenuNum = 0;
    $("#HSubject").val(em.id);
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#HTextboox").val(0);
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    //版本
    TextbookVersion();
    bok = book;
    getData(1, 10);
}
//版本
function TextbookVersion() {
    $("#TextbookVersion").children().remove();
    var currentPeriod = $("#HPeriod").val();
    var currentSubjectID = $("#HSubject").val();
    $("#HChapterID").val("");
    $("#HTextboox").val(0);
    if (currentPeriod == "0" || currentSubjectID == "0") {
        option = "<a id='0' class='on' onclick='VersionChangeall(this)'>全部</a>";
        $("#TextbookVersion").append(option);
        $("#HChapterID").val("");
        Textbook();
        return;
    }
    option = "<a id='0'  class='on' onclick='VersionChangeall(this)'>全部</a>";
    $("#TextbookVersion").append(option);
    if (CatagoryJson.TextbookVersion.errNum.toString() == "0") {
        var i = 0

        $(CatagoryJson.TextbookVersion.retData).each(function () {

            var option = "";
            if (i == 0) {

                option = "<a id='" + this.Id + "'  onclick='VersionChange(this)'>" + this.Name + "</a>";
                $("#bookVersion").val(0);
                Textbook();
            }
            else {
                option = "<a id='" + this.Id + "' onclick='VersionChange(this)'>" + this.Name + "</a>";
            }
            $("#TextbookVersion").append(option);
            i++;
        })
    }
    else {
        layer.msg(CatagoryJson.TextbookVersion.errMsg);
    }
}
var vcid = 0;
var bk = "";
function VersionChangeall(em) {
    $("#textbook").html("全部");
    vcid = em.id;
    book = bok;
    $("#bookVersion").val(em.id);
    Textbook();
    $("#HTextboox").val(0);
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    //版本
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#sel_Type").val("");
    $("#Title").val("");
    bk = book;
    getData(1, 10);
}

function VersionChange(em) {
    $("#textbook").html("全部");
    vcid = em.id;
    book = "" + gradeid + "|" + emid + "|" + vcid + "|%";
    i = 0;
    TopMenuNum = 0;
    $("#bookVersion").val(em.id);
    $(em).addClass("on").siblings().removeClass("on");
    $("#HTextboox").val(0);
    $("#HChapterID").val("");
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
    Textbook();
    bk = book;
    getData(1, 10);
}
//教材
function Textbook() {
    $("#HTextboox").val(0);
    var currentPeriod = $("#HPeriod").val();
    var currentSubjectID = $("#HSubject").val();
    $("#Textbook").children().remove();
    var bookVersion = $("#bookVersion").val();
    if (currentPeriod == "0" || currentSubjectID == "0" || bookVersion == "0") {
        option = "<a id='0' class='on' onclick=' TextbookChangeall(this)'>全部</a>";
        $("#Textbook").append(option);
        $("#BookName").html("全部");
        $("#HTextboox").val("0");
        return;
    }
    option = "<a id='0'  class='on' onclick=' TextbookChangeall(this)'>全部</a>";
    $("#Textbook").append(option);
    if (CatagoryJson.Textbook.errNum.toString() == "0") {

        var i = 0;
        $(CatagoryJson.Textbook.retData).each(function () {
            var option = "";
            if (bookVersion == this.VersionID && currentPeriod == this.GradeID && currentSubjectID == this.SubjectID) {

                if (i == 0) {
                    option = "<a id='" + this.Id + "' onclick=' TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                    $("#BookName").html(this.Name);
                    $("#HTextboox").val(0);
                    Chapator();
                }
                else {
                    option = "<a id='" + this.Id + "' onclick='TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                }
                $("#Textbook").append(option);
                i++;
            }

        })
    }
    else {
        layer.msg(CatagoryJson.Textbook.errMsg);
    }
    if ($("#HTextboox").val() == "0") {
        Chapator();
    }
}
var tbid = 0;
var btk = "";
function TextbookChangeall(em) {
    $("#textbook").html("全部");
    tbid = em.id;
    book = bk;
    $("#HTextboox").val(em.id);
    //版本
    $(em).addClass("on").siblings().removeClass("on");
    $("#HChapterID").val("");
    $("#sel_Type").val("");
    $("#Title").val("");
    btk = book;
    Chapator();
    getData(1, 10);
}

function TextbookChange(em) {
    $("#textbook").html(em.name);
    tbid = em.id;
    book = "" + gradeid + "|" + emid + "|" + vcid + "|" + tbid + "";
    TopMenuNum = 0;
    $(em).addClass("on").siblings().removeClass("on");
    $("#BookName").html($("#Textbook").text());
    $("#HTextboox").val(em.id);
    $("#HChapterID").val("");
    Chapator();
    btk = book;
    getData(1, 10);
}
var chapterjson = "";
function Chapator() {
    $.ajax({
        url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: { "PageName": "TextbookCatalogHandler.ashx", "Func": "GetTextbookCatalogData" },
        success: function (json) {
            chapterjson = json;
            //BindleftMenu(json);
            if (json.result.errNum.toString() == "0") {
                div = "";
                BindleftMenu(json.result.retData, 0);
                $("#menuChapater").html("");
                $("#menuChapater").append(div);
                menuSel();
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
var div = "";
var TopMenuNum = 0;
var chapter = "";
function BindleftMenu(data, id) {
    var i = 0;
    $(data).each(function () {
        if (this.TextbooxID == $("#HTextboox").val()) {

            if (this.PID == 0 && this.PID == id) {
                div += "<div class=\"units\">";
                div += " <div class=\"item_title\"><span class=\"text\" onclick=\"chapter('" + this.Name + "')\">" + this.Name + "</span><span class=\"icon icon-angle-down\"></span></div>";
                BindleftMenu(data, this.Id);
                if (i > 0) {
                    div += "</ul>";
                }
                i = 0;
                div += "</div>";
                TopMenuNum++;
            }
            if (this.PID != 0 && this.PID == id) {
                if (TopMenuNum == 0 && i == 0) {
                    div += "<ul class=\"contentbox\" style=\"display: block;\"><li class=\"active\" onclick=\"changeMenu(" + this.Id + "," + this.PID + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                    $("#HChapterID").val(this.Id);
                    $("#HChapterPid").val(this.PID);

                    //getData(1, 10);
                }
                if (TopMenuNum > 0 && i == 0) {
                    div += "<ul class=\"contentbox\">";
                }
                if (i > 0) {
                    div += "<li onclick=\"changeMenu(" + this.Id + "," + this.PID + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                }
                i++;
            }
        }
    })
    if ($("#HChapterID").val() != "0" && $("#HChapterID").val() != undefined) {
        //getData(1, 10);
    }
}

function chapter(Name) {
    chapter = Name;
}
var joint = "";
function changeMenu(id, pid) {
    //joint = Name;
    $("#HChapterID").val(id);
    $("#HChapterPid").val(pid);

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
}*/
//判断非空（专业/题型/）
function CheckNull() {
    var result = false;
    var Major = $('#se_subject').val();
    var Question = Questioneditor.text();
    var Type = $('#a_type').val();
    var Difficulty = $('#as_difficult').val();
    var score = $("#a_score").val();
    if (Major == null || Major == "0") { layer.msg('请选择学科！'); }
    else if (Type == null || Type == "0" || Type == "请选择") { layer.msg('请选择试题类型！'); }
    else if (Difficulty == null || Difficulty == "0") { layer.msg('请选择试题难度！'); }
    else if (Question == null || Question.trim() == "") {
        layer.msg('请输入题干信息！');
    }
    else if (score == null || score.trim() == "") {
        layer.msg('请填写试题分数！');
    }
    else {
        //客观(单选)
        if ($(".radio").css("display") == "block") {
            var Answer = $("input[name='answer']:checked").val();
            var OptionA = $("input[id='OptionA']").val();
            if (Major != null && Major != "0" && Type != null && Type != "请选择" && Type != "0" && Question != null && Question.trim() != "" && OptionA != null && OptionA.trim() != "" && Answer != null && Answer != "" && Difficulty != "0") {
                result = true;

            } else {
                if (OptionA == null || OptionA.trim() == "") { layer.msg('请输入一个以上选项,从选项A开始！'); }
                else if (Answer == null || Answer == "") { layer.msg('请选择答案！'); }
            }
        }//主观
        else if ($(".canswer").css("display") == "block" && $(".checkbox").css("display") == "none" && $(".radio").css("display") == "none") {
            if (Question != null && Question.trim() != "" && Major != null && Major != "0" && Type != null && Type != "0" && Difficulty != "0") {
                result = true;
            }
        }
            //客观（多选）
        else if ($(".canswer").css("display") == "none" && $(".checkbox").css("display") == "block" && $(".radio").css("display") == "none") {
            var Answer = "";
            $("input[name$='danswer']:checked").each(function () {
                if (Answer == "") {
                    Answer = $(this).val();
                }
                else {
                    Answer = Answer + "&" + $(this).val();
                }
            });
            var OptionA = $("input[id$='ckOptionA']").val();
            if (Major != null && Major != "0" && Type != null && Type != "0" && Question != null && Question.trim() != "" && OptionA != null && OptionA.trim() != "" && Answer != null && Answer != "" && Difficulty != "0") {
                result = true;
            } else {
                if (OptionA == null || OptionA.trim() == "") { layer.msg('请输入一个以上选项,从选项A开始！'); }
                else if (Answer == null || Answer == "") { layer.msg('请选择答案！'); }
            }
        }
            //判断
        else if ($(".judge").css("display") == "block") {
            var Answer = $("input[name='panswer']:checked").val();
            if (Major != null && Major != "0" && Type != null && Type != "0" && Question != null && Question.trim() != "" && Answer != null && Answer != "" && Difficulty != "0") {
                result = true;
            } else {
                if (Answer == null || Answer == "") { layer.msg('请选择答案！'); }
            }
        } else {
            result = true;
        }
    }
    return result;
}
