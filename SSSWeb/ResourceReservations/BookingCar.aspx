<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingCar.aspx.cs" Inherits="SSSWeb.ResourceReservations.BookingCar" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资源预定</title>
    <!--图标样式-->
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" href="../css/repository.css" />
    <link rel="stylesheet" href="../css/plan.css" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />

    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../js/common.js"></script>
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script id="tr_BookingCarList" type="text/x-jquery-tmpl">
        <tr>
            <td>${Name}
                <input type="hidden" id="HApprovalStutus" value="${ApprovalStutus}" />
            </td>
            <td>${Applicant}</td>
            <td>${Address}</td>
            <td>${DateTimeConvert(AppoIntmentTime)}
            </td>
            <td>${School}
            </td>
            <td>{{if ApprovalStutus==0}}待审批{{/if}}
                {{if ApprovalStutus==1}}审批通过{{/if}}
                <%--{{if ApprovalStutus==2}}无需审批{{/if}}--%>
                {{if ApprovalStutus==3}}审批未通过{{/if}}
            </td>

            <td>
                <a href="javascript:;" onclick="ViewBookCar(this,${Id})"><i class="icona icon-eye-open" title="查看"></i></a>
                {{if ApprovalStutus == 0}} 
                <a href="javascript:;" onclick="EditBookCar(this,${Id},${ApprovalStutus})" id="approvalStutus"><i class="icona" title="审核">
                    <img src="../images/shenpi.png" alt="" /></i></a>
                {{/if}}
                {{if UseStatus == 0}}
                    <a href="javascript:void(0);;" onclick="javascript:ChangeStatus(this,${Id},'1',${ApprovalStutus})"><i class="icona icon-minus-sign" title="取消预约"></i></a>
                {{/if}}
            </td>
        </tr>
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HTabName" value="" />
    <input type="hidden" id="ResourceReservation" runat="server" />
    <input type="hidden" id="HTeacherEmail" value="" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HMyReservation" value="" />
    <input type="hidden" id="HApprovalreservation" value="" />
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
            <div class="wenzi_tips fl">
                <img src="../images/shixuenshiguanli.png" />
            </div>
            <nav class="navbar menu_mid fl">
                <ul id="ResourceMenu">
                    <li currentclass="active"><a href="ResourceReservationInfo.aspx">基础数据维护</a></li>
                    <li currentclass="active"><a href="ResourceTimesManagement.aspx">时间段维护</a></li>
                    <li currentclass="active"><a href="BookingCar.aspx">资源预定</a></li>
                    <li currentclass="active"><a href="AssetManagement.aspx">资产管理</a></li>
                </ul>
            </nav>
            <div class="search_account fr clearfix">

                <ul class="account_area fl">
                    <li>
                        <a href="" class="dropdown-toggle">
                            <i class="icon icon-envelope" style="color: #fff;"></i>
                            <span class="badge"></span>
                        </a>
                    </li>
                    <li>
                        <a href="" class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=UserInfo.AbsHeadPic %>" />
                            </div>
                            <h2><%=UserInfo.Name %>
                            </h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr">
                    <a href="javascript:;">
                        <i class="icon icon-cog" style="height: 70px;"></i>
                    </a>
                    <div class="setting_none">
                        <a href="../PersonalSpace/PersonalSpace_Teacher.aspx"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <form id="carForm">
        <div class="time_wrap pt90 width">
            <div class="booking_wrap bordshadrad">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on">车辆</a>
                        <a href="javascript:;" id="meeting">会议室</a>
                        <a href="javascript:;" id="classroom">专业教室</a>
                    </div>

                </div>
                <div class="booking_nav mt10">
                    <a href="javascript:;" class="on" id="carreservation">车辆预约</a>
                    <a href="javascript:;" id="myapprovalreservation" onclick="ApprovalReservation(1,10,1)">我的预约</a>
                    <%--<a href="javascript:;" id="approvalreservation" onclick="ApprovalReservation(1,10,2)">预约审批</a>--%>
                </div>
                <div class="booking_duan clearfix mt10">
                    <label for="" class="fl">预约日期：</label>
                    <input id="SelectedDate" class="Wdate fl" type="text" placeholder="选择日期" value="" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
                    <label for="" class="fl">预约时间段：</label>
                    <select name="TimeInterval" class="select fl" id="sel_TimeInterval">
                        <option value=""></option>
                    </select>
                    <input type="button" name="search" id="search" value="搜索" style="font-size: 14px; border: none; float: right; margin: 5px 0px; text-indent: 0px; height: 30px; line-height: 30px; width: 50px; border-radius: 2px; background: #1472b9; color: #fff;" onclick="SearchByCondition()" />
                </div>
                <div class="booking_mes_wrap">
                    <!--车辆预约-->
                    <div class="booking_mes">
                        <ul class="clearfix" id="CarData">
                        </ul>
                    </div>
                    <!--分页-->
                    <div class="page" id="carpage" style="display: none">
                        <span id="carPageBar"></span>
                    </div>
                    <div class="booking_approval" style="display: none;">
                        <table class="table_wrap mt10">
                            <thead class="thead">
                                <th>预约事由</th>
                                <th>申请人</th>
                                <th>使用场所</th>
                                <th>预约时间</th>
                                <th>所属学校</th>
                                <th>状态</th>
                                <th>操作</th>
                            </thead>
                            <tbody class="tbody" id="tb_BookingCarList">
                            </tbody>
                        </table>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            var CourseAppoint = UrlDate.CourseAppoint;
            if (CourseAppoint != null && CourseAppoint != undefined) {
                $("#HTabName").val("专业教室");
                $('.stytem_select_left a').eq(2).addClass("on");
                $('.stytem_select_left a').eq(2).show().siblings().hide();
                $(".booking_nav a").eq(1).hide();
                $("#carreservation").text("专业教室预约");

            }
            //var type = UrlDate.Type;
            //var typeName = unescape(UrlDate.TypeName);
            //loadTitle();
            BindTimeInterval();
            //if (type == "3") {
            //    $(".booking_nav a[id='approvalreservation']").addClass('on').siblings().removeClass('on');
            //    ApprovalReservation(1, 10, 2);
            //}
            //else if (type == "4") {
            //    $(".booking_nav a[id='myapprovalreservation']").addClass('on').siblings().removeClass('on');
            //    ApprovalReservation(1, 10, 1);
            //}
            //else {
            getData(1, 10);
            //}
            //if ($("#myapprovalreservation").hasClass("on")) {
            //    $("#tb_BookingCarList").find("td").each(function (i, n) {
            //        $("#approvalStutus").remove();
            //    })
            //}

        })
        /*
        function loadTitle() {
            var name = "";
            var type = UrlDate.Type;
            if (type == null || type == "") {
                name = "车辆";
            }
            else {
                if (type == "1") {
                    $('#meeting').addClass('on').siblings().removeClass('on');
                    name = $("#meeting").text();
                    $("#carreservation").text("会议室预约");
                    $("#carreservation").addClass('on').siblings().removeClass('on');
                }
                else if (type == "2") {
                    $('#classroom').addClass('on').siblings().removeClass('on');
                    name = $("#classroom").text();
                    $("#carreservation").text("专业教室预约");
                    $("#carreservation").addClass('on').siblings().removeClass('on');
                }
                else if (type == "3") {
                    var text = $("#approvalreservation").text();
                    $("#approvalreservation").addClass('on').siblings().removeClass('on');
                    var name = unescape(UrlDate.ResourceTypeName);
                    $(".stytem_select_left a").each(function (i, n) {
                        if ($(this).text() == name) {
                            $(this).addClass('on').siblings().removeClass('on');
                            $("#carreservation").text($(this).text() + "预约");
                        }
                    })
                    $("#HTabName").val(name);
                }
                else if (type == "4") {
                    var text = $("#myapprovalreservation").text();
                    $("#myapprovalreservation").addClass('on').siblings().removeClass('on');
                    var name = unescape(UrlDate.ResourceTypeName);
                    $(".stytem_select_left a").each(function (i, n) {
                        if ($(this).text() == name) {
                            $(this).addClass('on').siblings().removeClass('on');
                            $("#carreservation").text($(this).text() + "预约");
                        }

                    })
                    $("#tb_BookingCarList").find("td").each(function (i, n) {
                        $("#approvalStutus").remove();
                    })
                    $("#HTabName").val(name);
                }
                else {
                    $("#carreservation").addClass('on').siblings().removeClass('on');
                }
                $("#HTabName").val(name);
                BindTimeInterval();
            }
        }*/
        //资源类型切换效果
        $('.stytem_select_left a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var name = $(this).text();
            if (name == "会议室") {
                $("#carreservation").text("会议室预约");
                $("#carreservation").addClass('on').siblings().removeClass('on');
            } else if (name == "专业教室") {
                $("#carreservation").text("专业教室预约");
                $("#carreservation").addClass('on').siblings().removeClass('on');
            } else {
                $("#carreservation").text("车辆预约");
                $("#carreservation").addClass('on').siblings().removeClass('on');
            }

            $("#HTabName").val(name);
            BindTimeInterval();
            getData(1, 10);
        })

        $('.booking_nav a').click(function () {
            var name = "";
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            var t = $(this).text();
            $('.booking_mes_wrap>div').eq(n).show().siblings().hide();
            if (t == "我的预约") {
                ApprovalReservation(1, 10, 1);
                $("#tb_BookingCarList").find("td").each(function (i, n) {
                    $("#approvalStutus").remove();
                })
            }
                //else if (t == "预约审批") {
                //    ApprovalReservation(1, 10, 2);
                //}
            else {
                getData(1, 10);
            }
            if ($("#myapprovalreservation").hasClass("on")) {
                $("#tb_BookingCarList").find("td").each(function () {
                    $("#approvalStutus").remove();
                })
            }
        })
        var chapterDiv = "";
        //获取车辆信息
        function getData(startIndex, pageSize) {
            var AppoIntmentTime = $("#SelectedDate").val();
            var TimeInterval = $("#sel_TimeInterval").val();
            var ResourceReservation = "";
            ResourceReservation = $("#ResourceReservation").val();
            var ResourceTypeName = "";
            if ($("#HTabName").val() == "") {
                ResourceTypeName = "车辆";
                $("#HTabName").val("车辆");
            } else {
                ResourceTypeName = $("#HTabName").val();
            }
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationInfoHandler.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize,
                    "ResourceTypeName": ResourceTypeName, "TimeInterval": TimeInterval, "AppoIntmentTime": AppoIntmentTime, "ResourceReservation": ResourceReservation, "BookCar": 1
                },
                success: OnSuccess,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        //获取数据成功显示列表
        function OnSuccess(json) {
            $(".booking_approval").css("display", "none");
            var ids = "";
            chapterDiv = "";
            var Image = "";
            if (json.result.errNum.toString() == "0") {
                $(".booking_mes_wrap .error").remove();
                Image = "";
                //$("#CarData li").remove();
                $(".booking_mes").css("display", "block");
                if ($("#HTabName").val() == "车辆") {
                    $(json.result.retData.PagedData).each(function (i, n) {
                        if (n.Image == "" || n.Image == null) {
                            Image = "../images/car_01.png";
                        } else {
                            var image = "../images/fpsc.jpg";
                            if (n.Image == image) {
                                Image = "../images/car_01.png";
                            } else {
                                Image = n.Image;
                            }
                        }
                        ids += n.Id + ",";//&ParentID=" + UrlDate.ParentID + "+ "&PageName=" + UrlDate.PageName
                        chapterDiv += "<li>";
                        chapterDiv += "<a href=\"/ResourceReservations/BookingCarDetail.aspx?Id=" + n.Id  + "&ResourceId=" + n.ResourceId + "&ie=utf-8&ResourceTypeName=" + escape(n.ResourceTypeName) + "\">";
                        chapterDiv += "<div class=\"booking_img fl\"><img src='" + Image + "' alt=\"\"></div>"
                        chapterDiv += "<div class=\"booking_mess fr\" id=" + n.Id + ">";
                        chapterDiv += "<p>名称：" + n.Name + "</p>";
                        chapterDiv += "<p>型号：" + n.Model + "</p>";
                        chapterDiv += "<p>座位数：" + n.SeatNum + "</p>";
                        chapterDiv += "</div></a>";
                        chapterDiv += "</li>";
                    });
                }
                else if ($("#HTabName").val() == "会议室") {
                    $(json.result.retData.PagedData).each(function (i, n) {
                        if (n.Image == "" || n.Image == null) {
                            Image = "../images/meeting_02.jpg";
                        } else {
                            var image = "../images/fpsc.jpg";
                            if (n.Image == image) {
                                Image = "../images/meeting_02.jpg";
                            } else {
                                Image = n.Image;
                            }
                        }
                        ids += n.Id + ",";
                        chapterDiv += "<li>";
                        chapterDiv += "<a href=\"/ResourceReservations/BookingCarDetail.aspx?Id=" + n.Id + "&ResourceId=" + n.ResourceId + "&ie=utf-8&ResourceTypeName=" + escape(n.ResourceTypeName) + "\">";
                        chapterDiv += "<div class=\"booking_img fl\"><img src='" + Image + "' alt=\"\"></div>"
                        chapterDiv += "<div class=\"booking_mess fr\" id=" + n.Id + ">";
                        chapterDiv += "<h1 class='metting_title'>" + n.Name + "</h1>";
                        chapterDiv += "<p>地址：" + n.Address + "</p>";
                        chapterDiv += "<p>面积：" + n.Area + "</p>";
                        chapterDiv += "<p>开放时间：" + n.OpenTime + "</p>";
                        chapterDiv += "<p>限定人数：" + n.Galleryful + "</p>";
                        chapterDiv += "</div></a>";
                        chapterDiv += "</li>";
                    });
                }
                else {
                    $(json.result.retData.PagedData).each(function (i, n) {
                        if (n.Image == "" || n.Image == null) {
                            Image = "../images/meeting_01.png";
                        } else {
                            var image = "../images/fpsc.jpg";
                            if (n.Image == image) {
                                Image = "../images/meeting_01.png";
                            } else {
                                Image = n.Image;
                            }
                        }
                        ids += n.Id + ",";
                        chapterDiv += "<li>";
                        chapterDiv += "<a href=\"/ResourceReservations/BookingCarDetail.aspx?Id=" + n.Id + "&CourseAppoint=" + UrlDate.CourseAppoint + "&ResourceId=" + n.ResourceId + "&ie=utf-8&ResourceTypeName=" + escape(n.ResourceTypeName) + "\">";
                        chapterDiv += "<div class=\"booking_img fl\"><img src='" + Image + "' alt=\"\"></div>"
                        chapterDiv += "<div class=\"booking_mess fr\" id=" + n.Id + ">";
                        chapterDiv += "<p>专业教室名称：" + n.Name + "</p>";
                        chapterDiv += "<p>楼层：" + n.Floor + "</p>";
                        chapterDiv += "<p>地址：" + n.Address + "</p>";
                        chapterDiv += "<p>房间号:" + n.Room + "</p>";
                        chapterDiv += "<p>开放时间：" + n.OpenTime + "~" + n.ClosedTime + "</p>";
                        chapterDiv += "<p>容纳人数:" + n.Galleryful + "</p>";
                        chapterDiv += "</div></a>";
                        chapterDiv += "</li>";
                    });
                }
                $("#CarData").html(chapterDiv);
                $("#carpage").css("display", "block");
                makePageBar(getData, document.getElementById("carPageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);

            } else {
                $("#carpage").hide();
                var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;" class="error"></div>';
                $("#CarData").html(html);

            }
        }
        //function BookDetail(ID, ResourceId, ResourceTypeName) {
        //    chapterDiv += "<a href=\"/ResourceReservations/BookingCarDetail.aspx?Id=" + n.Id + "&ResourceId=" + n.ResourceId + "&ie=utf-8&ResourceTypeName=" + escape(n.ResourceTypeName) + "\">";
        //    OpenIFrameWindow("预约详情", "BookingCarDetail.aspx?Id=" + ID + "&ResourceId=" + ResourceId + "&ie=utf-8&ResourceTypeName=" + ResourceTypeName, "1000px", "800px");
        //}
        //我的预约
        function ApprovalReservation(startIndex, pageSize, status) {
            var ApprovalStutus = "";
            var type = UrlDate.Type;
            if (type == "3") {
                ApprovalStutus = 0;
            }
            if (status == "1") {
                $("#HMyReservation").val($("#HUserIdCard").val());
            } else {
                var isApprovalreservation = $("#HApprovalreservation").val();

            }

            var IDCard = $("#HMyReservation").val();
            var AppoIntmentTime = $("#SelectedDate").val();
            var TimeInterval = $("#sel_TimeInterval").val();
            if ($("#HTabName").val() == "") {
                ResourceTypeName = "车辆";
            } else {
                ResourceTypeName = $("#HTabName").val();
            }
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationHandler.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize,
                    "ResourceTypeName": ResourceTypeName, "ReservationAppoIntmentTime": AppoIntmentTime, "ReservationTimeInterval": TimeInterval, "IDCard": IDCard, "ApprovalStutus": ApprovalStutus
                },
                success: OnApprovalSuccess,
                error: OnApprovalError
            });
        }

        function OnApprovalSuccess(json) {
            $("#carpage").css("display", "none");
            $(".booking_mes").css("display", "none");
            $(".booking_approval").css("display", "block");
            $(".booking_mes_wrap error").remove();
            $(".booking_wrap").removeAttr("style");
            if (json.result.errNum.toString() == "0") {
                $(".booking_mes_wrap .error").remove();
                $("#tb_BookingCarList").html('');
                $("#tr_BookingCarList").tmpl(json.result.retData.PagedData).appendTo("#tb_BookingCarList");
                $("#pageBar").show();
                makePageBar(ApprovalReservation, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);

            } else {
                $("#tb_BookingCarList").html('');
                $("#pageBar").hide();
                var html = '<td colspan="100" style="background: url(../images/error.png) no-repeat center center; height: 500px;" class="error"></td>';
                $("#tb_BookingCarList").html(html);
            }
        }

        function OnApprovalError(XMLHttpRequest, textStatus, errorThrown) {
            var html = '<td colspan="100" style="background: url(../images/error.png) no-repeat center center; height: 500px;" class="error"></td>';

            $("#tb_BookingCarList").html(html);
        }

        function BindTimeInterval() {
            $("#sel_TimeInterval option:not(:first)").remove();
            var ResourceTypeName = "";
            if ($("#HTabName").val() == "") {
                ResourceTypeName = "车辆";
                $("#HTabName").val("车辆");
            } else {
                ResourceTypeName = $("#HTabName").val();
            }
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/TimeManagementHandler.ashx", "Func": "GetTimeManagementList",
                    "GetTime": "1", "Name": ResourceTypeName, "ispage": "false"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function (i, n) {
                            $("#sel_TimeInterval").append("<option value='" + n.Id + "'>" + n.BeginTime + "~" + n.EndTime + "</option>");
                        });

                    }
                }
            });
        }
        //审核
        //function EditBookCar(obj, id, status) {
        //    OpenIFrameWindow('审批', 'ResourceApproval.aspx?ID=' + id + '&approvalStutus=' + status, '700px', '40%');

        //}

        //function getEmailInfo() {
        //    var IDCard = $("#HIDCard").val();
        //    var Email = "";
        //    $.ajax({
        //        url: "../SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
        //        type: "post",
        //        async: false,
        //        dataType: "json",
        //        data: {
        //            "Func": "GetTeacherData", "IDCard": IDCard
        //        },
        //        success: function (json) {
        //            if (json.result.errNum.toString() == "0") {
        //                Email = json.result.retData[0].Email;
        //            }
        //            $("#HTeacherEmail").attr("value", Email);
        //        },
        //        error: function (request) {
        //            layer.msg("操作失败");
        //        }
        //    });
        //}

        function ViewBookCar(obj, id) {
            OpenIFrameWindow('预约详情', 'ViewBookCar.aspx?ID=' + id, '700px', '540px');
        }

        function SearchByCondition() {
            var AppoIntmentTime = "";
            var TimeInterval = "";
            var tabName = $(".booking_nav a[class=on]").text();

            if (tabName == "我的预约") {
                ApprovalReservation(1, 10, 1);
            } else if (tabName == "预约审批") {
                ApprovalReservation(1, 10, 2);
            } else {
                AppoIntmentTime = $("#SelectedDate").val();
                TimeInterval = $("#sel_TimeInterval").val();
                if (AppoIntmentTime != "" || TimeInterval != "") {
                    $("#ResourceReservation").val('1');
                } else {
                    $("#ResourceReservation").val('');
                }
                getData(1, 10);
            }

        }

        function ChangeStatus(obj, id, status, ApprovalStutus) {
            var UserName = $("#HUserName").val();
            if (id != null && id != "") {

                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "ResourceReservations/ResourceReservationHandler.ashx", "Func": "ChangeStatus",
                        Id: id, Status: status, "UserName": UserName
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            var tabName = $(".booking_nav a[class=on]").text();
                            if (tabName == "我的预约") {
                                ApprovalReservation(1, 10, 1);
                            } else if (tabName == "预约审批") {
                                ApprovalReservation(1, 10, 2);
                            }
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (request) {
                        layer.msg("操作失败");
                    }
                });
            }
        }
    </script>
</body>
</html>

