<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedBack_DistributStu.aspx.cs" Inherits="SSSWeb.FeedBackManage.FeedBack_DistributStu" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>学生分配管理</title>
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/iconfont.css" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td class="checkradiob">
                <input type="checkbox" class="Check_box" name="Check_box" id="${ID}" /></td>
            <td class="name">${CreateName}</td>
            <td class="Head">${JobName}</td>
            <td class="Contact">{{if Status==0}}未反馈{{else}}已反馈{{/if}}
            </td>
        </tr>
    </script>

</head>
<body>
    <!--企业信息管理-->
    <input type="hidden" id="EnterID" />
    <input type="hidden" id="JobID" />

    <div class="Enterprise_information_feedback">
        <!--页面名称-->
        <%--<h1 class="Page_name clearfix">分配实习学生<input type="button" name="name" value="返回" class="btn fr" style="margin: 0; width: 60px; cursor: pointer;" /></h1>--%>
        <!--整个展示区域-->
        <div class="Whole_display_area">
            <!--操作区域-->

            <div class="tab_switch">
                <ul class="sw_tit">
                    <li class="fl">实习企业</li>
                    <li class="Sear fr">
                        <input type="text" placeholder=" 请输入公司名称" class="search" name="search" id="EnterName" /><i class="iconfont" onclick="BindEnter()">&#xe61b;</i></li>
                </ul>
                <div class="clear"></div>
                <div class="sw_tabheader">
                    <ul class="nav_list" id="EnterPrise">
                    </ul>
                </div>
                <div class="content">
                    <div class="sw">
                        <dl class="Position">
                        </dl>
                    </div>

                </div>

            </div>
            <div class="clear"></div>
            <div class="">
            </div>
            <!--展示区域-->
            <div class="Assignment_form">
                <div class="left_form fl">
                    <h3 class="trth">已分配学员</h3>
                    <table class="PL_form">
                        <tr>
                            <!--表头tr名称-->
                            <th class="checkallb">
                                <input type="checkbox" class="Check_box" name="Check_box" /></th>
                            <th class="name">姓名</th>
                            <th class="Internship">实习岗位</th>
                            <th class="Sex">状态</th>
                        </tr>
                        <tbody id="tb_Manage"></tbody>

                    </table>
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
                <div class="LR_btn fl">
                    <a href="#">
                        <input type="button" class="leftbtn" onclick="DepartStu()" /></a>
                    <a href="#">
                        <input type="button" class="rightbtn" onclick="DelStu()" /></a>
                </div>
                <div class="right_form fr">
                    <table class="PR_form">
                        <h3 class="trth">未分配学员 
					   <span class="sear fr">
                           <%--<span class="times_input">
                               <input type="text" class="time" id="StuName" placeholder="请输入学生姓名" />
                           </span>--%>
                           <span class="times_input">
                               <select id="StuClass" onchange="BindStu()">
                               </select>
                               <%--<input type="text" placeholder="请输入学生专业" class="time" id="StuName">--%>
                           </span>
                           <input type="button" class="b_query" value="查询">
                       </span>
                        </h3>
                        <tr>
                            <!--表头tr名称-->
                            <th class="checkall">
                                <input type="checkbox" name="Check_box" /></th>
                            <th class="name">姓名</th>
                            <th class="Sex">性别</th>
                            <th class="Internship">年级</th>
                        </tr>
                        <tbody id="Stu">
                            <%--<tr>
                                <td class="Check">
                                    <input type="checkbox" class="Check_box" name="Check_box" /></td>
                                <td class="name">林玉瑶</td>
                                <td class="Sex">女</td>
                                <td class="Internship">UI设计</td>
                            </tr>--%>
                        </tbody>

                    </table>
                    <div class="page">
                        <span id="pageBar1"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
<script type="text/javascript">
    $(".Position").find("dd").click(function () {
        $(this).addClass("selected").siblings().removeClass("selected")
    })

    $(function () {
        BindClass();
        BindEnter();
        BindStu();
        $('.checkall>input').click(function () {
            //alert(this.checked);
            if ($(this).is(':checked')) {
                $('.checkradio>input').prop('checked', true);
            } else {
                $('.checkradio>input').prop('checked', false);
            }
        })
        $('.checkallb>input').click(function () {
            //alert(this.checked);
            if ($(this).is(':checked')) {
                $('.checkradiob>input').prop('checked', true);
            } else {
                $('.checkradiob>input').prop('checked', false);
            }
        })
    })
    //分配
    function DepartStu() {
        $("#Stu").find("input:checkbox").each(function () {
            if (this.checked) {
                AssingStu(this.id);
            }
        })
        BindStu();
        getData(1, 10);

    }
    //取消分配
    function DelStu() {
        $("#tb_Manage").find("input:checkbox").each(function () {
            if (this.checked) {
                DelStu(this.id);
            }
        })
        BindStu();
        getData(1, 10);
    }
    function AssingStu(StuNo) {
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            dataType: "json",
            data: {
                "PageName": "FeedBack/FeedBack.ashx", "Func": "Add", "EnterID": $("#EnterID").val(), JobID: $("#JobID").val(), "StuNo": StuNo
            },
            success: function (json) {
               
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        })
    }
    function DelStu(ID) {
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            dataType: "json",
            data: {
                "PageName": "FeedBack/FeedBack.ashx", "Func": "Del", "ID": ID
            },
            success: function (json) {
               
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        })
    }

    function BindClass() {

        $("#StuClass").html("");
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",
            type: "post",
            dataType: "json",
            async: false,
            data: {
                func: "GetClass", Ispage: "false"
            },
            success: function (json) {
                var Option = "";
                var result = json.result;
                if (result.errNum == 0) {
                    $(json.result.retData).each(function () {
                        Option += "<option value='" + this.ClassNO + "'>" + this.ClassName + "</option>";
                    })
                    $("#StuClass").html(Option);

                } else {
                    layer.msg(result.errMsg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        });
    }
    function BindStu() {
        $("#Stu").html("");
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",
            type: "post",
            dataType: "json",
            data: {
                func: "GetUserInfoData", IsStu: "true", Ispage: "false", "OrgNo": $("#StuClass").val(), "NoFeedBack": "1"
            },
            success: function (json) {
                var Option = "";
                var result = json.result;
                if (result.errNum == 0) {
                    $(json.result.retData).each(function () {
                        var SexName = "女";
                        if (this.Sex == "1") {
                            SexName = "男";
                        }
                        $("#Stu").append(' <tr><td class="checkradio"><input type="checkbox" name="Check_box" id="' + this.UniqueNo + '"/></td><td class="name">' +
                            this.Name + '</td><td class="Sex">' + SexName + '</td><td class="Internship">' + this.OrgName + '</td></tr>')

                    })
                } else {
                    layer.msg(result.errMsg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        });
    }
    function SelEnter(EnterID, em) {
        $("#EnterID").val(EnterID);

        $(em).parent().addClass("selected").siblings().removeClass("selected");
        BindJob();
    }
    function BindEnter() {
        $("#EnterPrise").html("");
        var Name = $("#EnterName").val();
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: {
                "PageName": "FeedBack/Enterprise.ashx", "Func": "GetPageList", "IsPage": "false", "Name": Name, Status: 1
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    var i = 0;
                    $.each(json.result.retData, function () {

                        if (json.result.retData.length < 5) {
                            if (i == 0) {
                                $("#EnterPrise").append('<li class="selected"><a href="#" class="first_nav" onclick="SelEnter(' + this.ID + ',this)">' + this.Name + '</a></li>');
                                $("#EnterID").val(this.ID);
                                BindJob();
                                i++;
                            }
                            else {
                                $("#EnterPrise").append('<li><a href="#" class="first_nav" onclick="SelEnter(' + this.ID + ',this)">' + this.Name + '</a></li>');
                                i++;
                            }
                        }
                        else {
                            if (i == 0) {
                                $("#EnterPrise").append('<li class="selected"><a href="#" class="first_nav" onclick="SelEnter(' + this.ID + ',this)">' + this.Name + '</a></li>');
                                $("#EnterID").val(this.ID);
                                BindJob();
                                i++;
                            }
                            else if (i > 0 && i < 4) {
                                $("#EnterPrise").append('<li><a href="#" class="first_nav" onclick="SelEnter(' + this.ID + ',this)">' + this.Name + '</a></li>');
                                i++;
                            }
                            else if (i >= 4) {
                                $("#EnterPrise").append(' <li class="last"><a href="#" class="first_nav">查看更多<i class="iconfont">&#xe605;</i></a><div class="second_nav" style="display: none;"></div></li>');
                                i++;
                            }
                            else if (i > 4) {
                                $(".second_nav").append('<a href="#" class="ng-binding ng-scope">' + this.Name + '</a>');
                                i++;
                            }
                        }
                    })
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
    function BindJob() {
        $(".Position").html("");
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "FeedBack/Enterprise.ashx", "Func": "GetJobList", EnterID: $("#EnterID").val() },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    var i = 0;
                    $.each(json.result.retData, function () {
                        if (i == 0) {
                            $(".Position").append('<dd class="selected"><a href="#" onclick="SerchJob(' + this.ID + ',this)">' + this.Name + '</a></dd>');
                            $("#JobID").val(this.ID);
                            getData(1, 10);
                            i++;
                        }
                        else {
                            $(".Position").append('<dd><a href="#" onclick="SerchJob(' + this.ID + ',this)">' + this.Name + '</a></dd>');
                            i++;
                        }
                    })
                }
                else {
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    function getData(startIndex, pageSize) {
        $("#tb_Manage").html("");
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            async: false,
            data: {
                "PageName": "FeedBack/FeedBack.ashx", "Func": "GetPageList", IsPage: "false", "EnterID": $("#EnterID").val(), JobID: $("#JobID").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(".page").show();
                    $("#tb_Manage").html('');
                    $("#tr_User").tmpl(json.result.retData).appendTo("#tb_Manage");
                    // makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                    $("#tb_Manage").html(html);
                    $(".page").hide();
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
        BindStu();
    }
    function SerchJob(JobID, em) {
        $(em).parent().addClass("selected").siblings().removeClass("selected");
        $("#JobID").val(JobID);
        getData(1, 10);
    }
</script>
</html>
