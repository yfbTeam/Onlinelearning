<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookCheck.aspx.cs" Inherits="SSSWeb.ResourceReservations.BookCheck" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资源审批</title>
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
    <%--<script src="/ResourceReservationMenu.js"></script>--%>
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
               <%-- {{if ApprovalStutus==2}}无需审批{{/if}}--%>
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
    <%--<input type="hidden" id="HUserName" value="<%=UserInfo.Name%>" />--%>
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
                        <a href="javascript:;" class="on" id="Car">车辆</a>
                        <a href="javascript:;" id="meeting">会议室</a>
                        <a href="javascript:;" id="classroom">专业教室</a>
                    </div>
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

                    <div class="booking_approval">
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
            //var elem = $(".submenu").find('li.selected').html();
            //cururl = $(elem).attr("data-src");

            //var len = cururl.indexOf("?Type");
            var type = UrlDate.Type;// cururl.substr(len + 6, cururl.length - len + 6);
            if (type == "Car") {
                $("#meeting").hide();
                $("#classroom").hide();
                $("#Car").show();
            }
            else {
                $("#meeting").show();
                $("#classroom").show();
                $("#Car").hide();
                $("#meeting").addClass("on").siblings().removeClass("on");
                $("#HTabName").val("会议室");
            }
            BindTimeInterval();
            ApprovalReservation(1, 10, 2);
        })


        $('.stytem_select_left a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var name = $(this).text();
            $("#HTabName").val(name);
            BindTimeInterval();
            ApprovalReservation(1, 10, 2);
        })

        //预约审批
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
            if (json.result.errNum.toString() == "0") {
                $("#tb_BookingCarList").html('');
                $("#tr_BookingCarList").tmpl(json.result.retData.PagedData).appendTo("#tb_BookingCarList");
                $("#pageBar").show();
                makePageBar(ApprovalReservation, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);

            } else {
                //$("#tb_BookingCarList").html('');
                $("#pageBar").hide();
                var html = ' <tr><td colspan="100" style="background: url(../images/error.png) no-repeat center center; height: 500px;" class="error"></td></tr>';
                $("#tb_BookingCarList").html(html);
            }
        }

        function OnApprovalError(XMLHttpRequest, textStatus, errorThrown) {
            var html = ' <tr><td colspan="100" style="background: url(../images/error.png) no-repeat center center; height: 500px;" class="error"></td></tr>';

            $("#tb_BookingCarList tbody").html(html);
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
        function EditBookCar(obj, id, status) {
            OpenIFrameWindow('资源审批', 'ResourceApproval.aspx?ID=' + id + '&approvalStutus=' + status, '700px', '500px');

        }


        function SearchByCondition() {
            var AppoIntmentTime = "";
            var TimeInterval = "";
            ApprovalReservation(1, 10, 2);

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

                            ApprovalReservation(1, 10, 2);

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
        function ViewBookCar(obj, id) {
            OpenIFrameWindow('预约详情', 'ViewBookCar.aspx?ID=' + id, '700px', '500px');
        }

    </script>
</body>
</html>
