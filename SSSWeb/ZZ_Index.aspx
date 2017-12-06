<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZZ_Index.aspx.cs" Inherits="SSSWeb.ZZ_Index" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
    <meta charset="utf-8" />
    <title>远程教学平台</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css" />
    <link rel="stylesheet" type="text/css" href="css/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />

    <link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
    <link href="css/fancybox.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <script src="Scripts/Common.js"></script>
    <script src='http://code.jquery.com/ui/1.10.3/jquery-ui.js'></script>
    <script src='/js/jquery.fancybox-1.3.1.pack.js'></script>
    <style type="text/css">
        .fancy {
            width: 450px;
            height: auto;
        }

            .fancy h3 {
                height: 30px;
                line-height: 30px;
                border-bottom: 1px solid #d3d3d3;
                font-size: 14px;
            }

            .fancy form {
                padding: 10px;
            }

            .fancy p {
                height: 28px;
                line-height: 28px;
                padding: 4px;
                color: #999;
            }

        .input {
            height: 20px;
            line-height: 20px;
            padding: 2px;
            border: 1px solid #d3d3d3;
            width: 100px;
        }

        .btn1 {
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            padding: 5px 12px;
            cursor: pointer;
        }

        .btn_ok {
            background: #360;
            border: 1px solid #390;
            color: #fff;
        }

        .btn_cancel {
            background: #f0f0f0;
            border: 1px solid #d3d3d3;
            color: #666;
        }

        .btn_del {
            background: #f90;
            border: 1px solid #f80;
            color: #fff;
        }

        .sub_btn {
            height: 32px;
            line-height: 32px;
            padding-top: 6px;
            border-top: 1px solid #f0f0f0;
            text-align: right;
            position: relative;
        }

            .sub_btn .del {
                position: absolute;
                left: 2px;
            }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript">
        //日程协同
        $(function () {
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month'
                },
                height: '383',
                firstDay: 0,
                weekMode: 'liquid',
                events: 'json.ashx?Func=GetDate&CreateUID=' + $("#HUserIdCard").val(),
                dayClick: function (date, allDay, jsEvent, view) {
                    var selDate = $.fullCalendar.formatDate(date, 'yyyy-MM-dd');
                    $.fancybox({
                        'type': 'ajax',
                        'href': 'event.aspx?action=add&date=' + selDate
                    });
                },
                //单击事件项时触发
                eventClick: function (calEvent, jsEvent, view) {
                    $.fancybox({
                        'type': 'ajax',
                        'href': 'event.aspx?action=edit&id=' + calEvent.id
                    });
                }

            });

        });
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <!--header-->
    <header class="repository_header_wrap">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="HZ_Index.aspx">
                <img src="Images/logo.png" style="margin-top: -5px;" />

            </a>
            <div class="search_account fr clearfix">
                <%--<div class="search fl">
                    <i class="icon  icon-search"></i>
                    <input type="text" name="" id="" placeholder="请输入关键字" />
                </div>--%>
                <ul class="account_area fl">
                    <%--<li>
                        <a href="#" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">0</span>
                        </a>
                    </li>--%>
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
                        <a href="PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!--main-->
    <div class="main width clearfix pt20">
        <div class="main_left fl">
            <div class="teacher_wrap clearfix bordshadrad ">
                <!--教师信息-->
                <dl class="teacher p10 clearfix fl">
                    <dt class="fl">
                        <i class="dislb teacher_img">
                            <img src="<%=UserInfo.AbsHeadPic%>" />
                        </i>
                    </dt>
                    <dd class="fl p10">
                        <div class="teacher_mes colorBlack">
                            <span class="teacher_name"><%=UserInfo.Name%> 
                            </span>
                            <%=UserInfo.RegisterOrg%>
                        </div>
                        <div class="teacher_school1 colorGray">
                            门头沟中职
                        </div>
                        <div class="teacher_school2 colorGray">
                            <%--英语学院--%>
                        </div>
                    </dd>
                </dl>
                <ul class="course_mes fr p10">
                    <li class="course">课程
	    					<span class="course_mes_num fr">2
                            </span>
                    </li>
                    <li class="studends">学生
	    					<span class="course_mes_num fr">60
                            </span>
                    </li>
                    <li class="test">考试
	    					<span class="course_mes_num fr">10
                            </span>
                    </li>
                </ul>
            </div>

            <!--通知信息-->
            <div class="notice mt20">
                <ul class="clearfix">
                    <li class="notice_one bordshadrad">
                        <div class="notice_mes">
                            <a class="notice_mes1 borderblue" href="javascript:;">
                                <i class="icon icon-envelope colorblue"></i>
                                <p class="notice_mes_num">0</p>
                            </a>
                            <p class="notice_name">通知</p>
                        </div>
                        <div class="connect">
                            <span class="connect_left bgblue"></span>
                            <span class="connect_right bgblue"></span>
                        </div>
                    </li>
                    <li class="to_corrected bordshadrad">
                        <div class="notice_mes">
                            <a class="notice_mes1 borderorange" href="javascript:;">
                                <i class="icon icon-envelope colororange"></i>
                                <p class="notice_mes_num">0</p>
                            </a>
                            <p class="notice_name">待批改作业</p>
                        </div>
                        <div class="connect none">
                            <span class="connect_left bgorange"></span>
                            <span class="connect_right bgorange"></span>
                        </div>
                    </li>
                    <li class="pendingreview bordshadrad">
                        <div class="notice_mes">
                            <a class="notice_mes1 borderpink" href="javascript:;">
                                <i class="icon icon-envelope colorpink"></i>
                                <p class="notice_mes_num">0</p>
                            </a>
                            <p class="notice_name">待审阅</p>
                        </div>
                        <div class="connect none">
                            <span class="connect_left bgpink"></span>
                            <span class="connect_right bgpink"></span>
                        </div>
                    </li>
                </ul>
            </div>
            <!--xinxi-->
            <div class="messages mt10 bordshadrad">
                <ul class="p10" id="note1">
                    <%-- <li><a href="">英语教室申请已通过，请创建课程内容</a><span class="fr">2016.03.12</span></li>
                    <li><a href="">课程创建审核已通过，请尽快发布课程</a><span class="fr">2016.03.12</span></li>
                    <li><a href="">30名学生报名《英语演讲》，请尽快审核</a><span class="fr">2016.03.12</span></li>
                    <li><a href="">已有学生对《英语口语训练》进行评价</a><span class="fr">2016.03.12</span></li>
                    <li><a href="">班级论坛提出新讨论方向</a><span class="fr">2016.03.12</span></li>--%>
                </ul>
                <ul class="p10 none" id="note2">
                    <%-- <li><a href="">英语教室申请已通过，请创建课程内容</a><span class="fr">2016.03.19</span></li>
                    <li><a href="">课程创建审核已通过，请尽快发布课程</a><span class="fr">2016.03.19</span></li>
                    <li><a href="">30名学生报名《英语演讲》，请尽快审核</a><span class="fr">2016.03.19</span></li>
                    <li><a href="">已有学生对《英语口语训练》进行评价</a><span class="fr">2016.03.19</span></li>
                    <li><a href="">班级论坛提出新讨论方向</a><span class="fr">2016.03.19</span></li>--%>
                </ul>
                <ul class="p10 none" id="note3">
                    <%-- <li><a href="">英语教室申请已通过，请创建课程内容</a><span class="fr">2016.03.23</span></li>
                    <li><a href="">课程创建审核已通过，请尽快发布课程</a><span class="fr">2016.03.23</span></li>
                    <li><a href="">30名学生报名《英语演讲》，请尽快审核</a><span class="fr">2016.03.23</span></li>
                    <li><a href="">已有学生对《英语口语训练》进行评价</a><span class="fr">2016.03.23</span></li>
                    <li><a href="">班级论坛提出新讨论方向</a><span class="fr">2016.03.23</span></li>--%>
                </ul>
            </div>
        </div>
        <div class="scheduprog fr">
            <div class="calendar_titie">
                日程安排
            </div>
            <div class="calendar_wrap bordshadrad">
                <div class="wrap p10">
                    <div id='calendar'></div>
                </div>
            </div>
        </div>
    </div>
    <div class="main width clearfix pt20">
        <div class="myapp_wrap bordshadrad">
            <div class="apps_title ">
                <h1 class="bordshadrad">我的应用</h1>
            </div>
            <div class="apps_wrap clearfix">
                <div class="apps clearfix">
                    <ul class="app_list p10 clearfix" id="Menu">
                    </ul>

                </div>

            </div>
        </div>
    </div>
    <footer id="footer" class="mt20"></footer>
    <script src="js/common.js"></script>
    <script type="text/javascript" src="js/fullcalendar.min.js"></script>
    <script type="text/javascript">

        $(function () {
            $('#footer').load('footer.html');
            $('.search_account .search input').focus(function () {
                $(this).parent().css('background', '#fff');
                $(this).css({ 'background': '#fff', 'color': '#666' });
            }).blur(function () {
                $(this).parent().css('background', '#1d87d6');
                $(this).css({ 'background': '#1d87d6', 'color': '#fff' });
            });
            //通知，审阅，批改作业切换
            $('.notice ul li').each(function (i, elem) {
                $(elem).find('.notice_mes').click(function () {
                    $('.notice ul li').children('.connect').hide();
                    $('.notice ul li').children('.connect').eq(i).show().css('transition', 'all 1s 0.5s');
                    $('.messages ul').eq(i).show().siblings().hide();
                })
            })
            GetLeftNavigationMenu();
            //initMsg();
        })

        //获取数据
        function GetLeftNavigationMenu() {
            $("#Menu").html("");
            $.ajax({
                url: "Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/SystemSettings/ModelHander.ashx", "IDCard": $("#IDCard").val(), "Func": "GetModelList", Ispage: "false", IsShow: "in"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var RowCount = json.result.retData.length;
                        var i = 0;
                        $(json.result.retData).each(function () {
                            if (this.Pid == "0") {
                                var li = " <li><a href=\"" + this.LinkUrl //+ this.Url + "?ParentID=" + this.Id //+ "&PageName=" + this.Url
                                  + "\" class=\"bgblue\"  target=\"_blank\"><i><img src='/images/" + this.iconCss + ".png' /></i><p class=\"app_name\">" +
                                  this.ModelName + "</p></a></li>";
                                $("#Menu").append(li);
                            }


                        })
                    }
                    else {
                        // $("#main").html('<div class="modult" id=""><h1 class="title"><span>无分类</span></h1><div class="apps_wrap clearfix"><div class="apps clearfix"><div class="add fl" onclick="AddApp()"><i class="iconfont icon-add"></i></div></div></div></div>');

                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

        function initMsg() {
            //初始化序号 
            $.ajax({
                url: "Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MessageHandler.ashx",
                    Func: "GetPageList",
                    Receiver: $("#HUserIdCard").val(),
                    Status: 0,
                    Ispage: false
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            $(".badge").html(items.length);
                            var dpgzy = 0;
                            var dsy = 0;
                            $.each(items, function (i, item) {
                                if (item.Type == "0") {
                                    $("#note2").append("<li><a href=\"SysMessage/UsersMessage.aspx?id=" + item.Id + "\">" + item.Title + "</a><span class=\"fr\">" + DateTimeConvert(item.CreateTime, 'yyyy-MM-dd') + "</span></li>");

                                    dpgzy++;
                                } else if (item.Type == "3") {
                                    $("#note3").append("<li><a href=\"SysMessage/UsersMessage.aspx?id=" + item.Id + "\">" + item.Title + "</a><span class=\"fr\">" + DateTimeConvert(item.CreateTime, 'yyyy-MM-dd') + "</span></li>");

                                    dsy++;
                                }
                                else {
                                    $("#note1").append("<li><a href=\"SysMessage/UsersMessage.aspx?id=" + item.Id + "\">" + item.Title + "</a><span class=\"fr\">" + DateTimeConvert(item.CreateTime, 'yyyy-MM-dd') + "</span></li>");

                                }
                            });
                            $('.notice .to_corrected .notice_mes_num').html(dpgzy);
                            $('.notice .pendingreview .notice_mes_num').html(dsy);
                            $(".notice .notice_one .notice_mes_num").html($("#note1").children().length);
                        } else {
                            $(".badge").html("0");
                        }
                    }
                    else {
                        $(".badge").html("0");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</body>
</html>

