<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedBack_Manage.aspx.cs" Inherits="SSSWeb.FeedBackManage.FeedBack_Manage" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>企业信息管理</title>
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />

    <link href="../css/repository.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/iconfont.css" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script type="text/javascript" src="../ZZSX/js/tz_slider.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td class="name">${CreateName}</td>
            <td class="Account">${EnterName}</td>
            <td class="Head">${JobName}</td>
            <td class="Contact">${DateTimeConvert(CreateTime,"yyyy-MM-dd")}</td>
            <td class="Operation">{{if Status==1}}
                <a href="#" title="查看" onclick="ViewFeed(${ID})"><i class="iconfont">查看</i></a>
                {{else}}
                <a href="#" title="填写" onclick="SaveFeed(${ID})"><i class="iconfont">填写</i></a>
                {{/if}}
            </td>
        </tr>
    </script>
</head>
<body>
    <!--企业信息管理-->
    <div class="Enterprise_information_feedback">
        <input type="hidden" id="EnterID" />
        <input type="hidden" id="JobID" />
        <input type="hidden" id="Status" value="0" />
        <!--页面名称-->
        <%--<h1 class="Page_name">分配实习学生</h1>--%>
        <!--整个展示区域-->
        <div class="Whole_display_area">
            <!--操作区域-->
            <div class="Operation_area">
                <%--<div class="left_choice fl">
                    <ul>
                        <li class="">
                            <div class="qiehuan fl"><span class="qijin"><a class="Enable" href="#">反馈详情</a><a class="Disable" href="#">图表统计</a></span></div>
                        </li>
                    </ul>
                </div>--%>
                <%--<div class="right_add fr">
                    <a href="#" class="add"><i class="iconfont">&#xf0047;</i>反馈表设置</a>
                </div>--%>
            </div>
            <div class="tab_switch">
                <ul class="sw_tit">
                    <li class="fl">实习企业</li>
                    <li class="Sear fr">
                        <input type="text" placeholder=" 请输入公司名称" class="search" name="search" id="EnterName" /><i class="iconfont" onclick="BindEnter()">&#xe61b;</i>
                    </li>
                </ul>
                <div class="clear"></div>
                <div class="sw_tabheader">
                    <ul class="nav_list clearfix" id="EnterPrise">
                        <%-- <li class="selected"><a href="#" class="first_nav">北京圣邦天麒科技有限公司</a></li>
                        <li><a href="#" class="first_nav">北京圣邦天麒科技有限公司</a></li>
                        <li><a href="#" class="first_nav">北京圣邦天麒科技有限公司</a></li>
                        <li class="last">
                            <a href="#" class="first_nav">查看更多<i class="iconfont">&#xe605;</i></a>
                            <div class="second_nav" style="display: none;">
                                <a href="#" class="ng-binding ng-scope">北京圣邦天麒科技有限公司</a>
                                <a href="#" class="ng-binding ng-scope">北京圣邦天麒科技有限公司</a>
                                <a href="#" class="ng-binding ng-scope">北京圣邦天麒科技有限公司</a>
                                <a href="#" class="ng-binding ng-scope">北京圣邦天麒科技有限公司</a>
                                <a href="#" class="ng-binding ng-scope">北京圣邦天麒科技有限公司</a>
                                <a href="#" class="ng-binding ng-scope">北京圣邦天麒科技有限公司</a>
                                <a href="#" class="ng-binding ng-scope">北京圣邦天麒科技有限公司</a>
                            </div>
                        </li>--%>
                    </ul>
                </div>
                <div class="content clearfix">
                    <div class="sw">
                        <dl class="Position">
                            <%-- <dt>全部：</dt>
                            <dd><a href="#" onclick="SerchJob()">软件研发工程师</a></dd>
                            <dd><a href="#">UI设计师</a></dd>
                            <dd><a href="#">WEB前端工程师</a></dd>
                            <dd><a href="#">软件研发工程师</a></dd>
                            <dd><a href="#">软件研发工程师</a></dd>
                            <dd><a href="#">软件研发工程师</a></dd>--%>
                        </dl>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
            <div class="">
                <div class="Operation_area">
                    <div class="left_choice fl">
                        <ul>
                            <li class="State">
                                <span class="qijin">
                                    <a class="Disable" href="#" onclick="FeedStatusChange(1,this)">已反馈</a>
                                    <a class="Enable" href="#" onclick="FeedStatusChange(0,this)">未反馈</a>
                                </span>
                            </li>
                            <%--<li class="Select">
                                <select class="option">
                                    <option>所有专业</option>
                                    <option>平面设计</option>
                                    <option>UI设计</option>
                                    <option>研发工程师</option>
                                    <option>产品经理</option>
                                </select>
                            </li>--%>
                        </ul>
                    </div>
                    <div class="search_exam fr pr">
                        <input type="text" name="" id="Name" value="" placeholder="请输入菜品名称">
                        <i class="icon iconfont icon-jian1" onclick="getData(1,10)"></i>
                    </div>
                </div>
            </div>
            <!--展示区域-->
            <div class="Display_form">
                <table class="D_form">
                    <tr class="trth">
                        <th class="name">学生姓名</th>
                        <th class="Account">实习企业 </th>
                        <th class="Head">实习岗位 </th>
                        <th class="Contact">分配时间 </th>
                        <th class="Operation">操作 </th>
                    </tr>
                    <tbody id="tb_Manage">
                    </tbody>

                </table>
                <div class="page">
                    <span id="pageBar"></span>
                </div>

            </div>
        </div>
    </div>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        //查看反馈内容
        function ViewFeed(ID) {
            OpenIFrameWindow('查看反馈详情', 'FeedBackView.aspx?ID=' + ID, '800px', '700px')
        }
        function SaveFeed(ID) {
            var EnterName = UrlDate.EnterName;
            if (EnterName != undefined && EnterName != "") {
                OpenIFrameWindow('填写反馈表', 'FeedBackPaper.aspx?ID='+ID, '900px', '800px');
            }
            else {
                layer.msg("只有企业用户可以填写反馈表");
            }
        }
        $(".Position").find("dd").click(function () {
            $(this).addClass("selected").siblings().removeClass("selected")
        })
        $(function () {
            var EnterName = UrlDate.EnterName;
            if (EnterName != undefined && EnterName != "") {
                $(".Sear").hide();
                BindEnter(EnterName);
            }
            else {
                $(".Sear").show();
                BindEnter("");
            }
        })
        function FeedStatusChange(Status, em) {
            $(em).addClass("Enable").siblings().removeClass("Enable");
            $(em).removeClass("Disable").siblings().addClass("Disable");
            $("#Status").val(Status);
            getData(1, 10);
        }
        function BindEnter(EnterID) {
            $("#EnterPrise").html("");
            var Name = $("#EnterName").val();
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "FeedBack/Enterprise.ashx", "Func": "GetPageList", "IsPage": "false", "Name": Name, Status: 1, ID: EnterID.replace('#','')
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
        function SelEnter(EnterID, em) {
            $("#EnterID").val(EnterID);

            $(em).parent().addClass("selected").siblings().removeClass("selected");
            BindJob();
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
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            var Name = $("#Name").val();

            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "FeedBack/FeedBack.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, "EnterID": $("#EnterID").val(), JobID: $("#JobID").val(), Status: $("#Status").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(".page").show();
                        $("#tb_Manage").html('');
                        $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
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
        }
        function SerchJob(JobID, em) {
            $(em).parent().addClass("selected").siblings().removeClass("selected");
            $("#JobID").val(JobID);
            getData(1, 10);
        }
    </script>

</body>
</html>
