<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Order_MenuManage.aspx.cs" Inherits="SSSWeb.BookDinner.Order_MenuManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/iconfont.css" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script type="text/javascript" src="../ZZSX/js/tz_slider.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <style type="text/css">
        /*****************************************************************************分配菜单**************************************************/
        .Operation_area {
            padding: 10px 0px;
        }

        .Allot_Meal {
            padding: 20px;
        }

            .Allot_Meal h1.title_name {
                font-size: 18px;
                font-weight: normal;
                padding: 10px 0;
            }

                .Allot_Meal h1.title_name .currentbtn {
                    display: block;
                    padding: 2px 8px;
                    width: 80px;
                    background: #ccc;
                    border-radius: 3px;
                    color: #fff;
                    margin: 0 4px;
                    float: right;
                }

        .Allot_tab {
            min-height: 400px;
            background: #fff;
        }

            .Allot_tab .Allot_tabheader {
                height: 45px;
                transition: all 0.3s ease-in-out;
                background: #f5f5f5;
                border-bottom: 2px solid #ccc;
            }

            .Allot_tab ul li {
                float: left;
                line-height: 45px;
                text-align: center;
                width: 19.95%;
                cursor: pointer;
            }

            .Allot_tab .Allot_tabheader a {
                text-decoration: none;
                color: #666;
                display: block;
                text-align: center;
                overflow: hidden;
                height: 44px;
            }

            .Allot_tab ul {
                width: 100%;
            }
            /*未选中颜色 当前状态*/


            /*选中颜色*/
            .Allot_tab .Allot_tabheader ul li.selected {
                line-height: 44px;
                border-left: 1px solid #ccc;
                border-right: 1px solid #ccc;
                background-color: #fff;
                border-top: 2px #96cc66 solid;
                color: #666;
                position: relative;
                top: 1px;
                border-bottom: none;
            }

            .Allot_tab .Allot_tabheader ul li:hover {
                background: #f5f5f5;
                color: #666;
            }
        /*tab_content*/

        /*table.A_form*/
        .Allot_form table.A_form {
            width: 100%;
            text-align: center;
            margin: auto;
            font-size: 14px;
        }

            .Allot_form table.A_form th {
                border: 1px solid #e6e6e6;
                border-bottom: none;
                color: #333;
                font-size: 14px;
                line-height: 34px;
                text-align: center;
            }

            .Allot_form table.A_form tr {
                border: 1px solid #e6e6e6;
                color: #666;
                line-height: 28px;
            }

            .Allot_form table.A_form td {
                border: 1px solid #e6e6e6;
                color: #666;
                line-height: 28px;
            }

            .Allot_form table.A_form th::first-line {
                border-left: 1px solid #fff !important;
            }

            .Allot_form table.A_form th::after {
                border-right: 1px solid #fff !important;
            }
        /*表头*/
        tr.A_trth {
            background: #fff;
            color: #fff;
            font-weight: bold;
        }
        /*单行变色*/
        table.A_form tr.Single {
            background: #fff;
        }
        /*双行变色*/
        table.A_form tr.Double {
            background: #fff;
        }

        /*菜品开始*/
        /*title*/
        .icohot1 {
            background: url(../Image/hot1.png) no-repeat;
            width: 25px;
            height: 17px;
        }

        .icohot2 {
            background: url(../Image/hot2.png) no-repeat;
            width: 25px;
            height: 17px;
        }

        .Food_Allot {
            margin-top: 5px;
            border-left: 1px solid #5493d7;
            border-right: 1px solid #5493d7;
            border-bottom: 1px solid #5493d7;
            border-top: 3px solid #5493d7;
            min-height: 70px;
        }

            .Food_Allot h2.food_tit {
                text-align: left;
                background: #f5f5f5;
                border-top: 1px solid #e6e6e6;
                height: 36px;
                line-height: 36px;
                padding-left: 20px;
                margin-top: -1px;
            }

                .Food_Allot h2.food_tit i {
                    font-weight: bold;
                    font-size: 16px;
                }

                .Food_Allot h2.food_tit span.F_name {
                    display: block;
                    padding: 0px 6px;
                    background: #ff666b;
                    color: #fff;
                    float: left;
                    height: 26px;
                    line-height: 26px;
                    margin: 5px 4px 3px 0px;
                }

        .F_Choice {
            display: block;
            padding: 0px 6px;
            background: #96cc66;
            border-radius: 5px;
            color: #fff;
            float: right;
            height: 26px;
            line-height: 26px;
            margin: 5px 4px 3px 0px;
        }

        .F_noChoice {
            display: block;
            padding: 0px 6px;
            background: #ccc;
            border-radius: 5px;
            color: #fff;
            float: right;
            height: 26px;
            line-height: 26px;
            margin: 5px 4px 3px 0px;
        }

        .Allot_Meal .btndiv {
            float: right;
            padding-right: 10px;
        }

            .Allot_Meal .btndiv .btn {
                border-radius: 4px;
                background-color: #96cc66;
                color: #fff;
                width: 80px;
                margin-right: 10px;
                display: inline-block;
                border: none;
            }

        .btnlaststep {
            border-radius: 4px;
            background-color: #5493d7;
            color: #fff;
            width: 90px;
            margin-right: 10px;
            display: inline-block;
            text-align: center;
        }

        .Food_Allot h3 {
            padding: 10px 10px;
        }
        /*****************************************************************************分配菜单结束**************************************************/
    </style>
    <script type="text/x-jquery-tmpl" id="DishTye">
        <div class="Food_Allot">
            <h2 class="food_tit">
                <span class="F_name">${Name}</span>
                <span>已选:<i id="Num${ID}">0</i>份菜品</span>
                <a class="F_Choice" onclick="DepartMenu(${ID})" style="cursor: pointer;">挑选菜品</a>
            </h2>
            <table class="A_form">
                <thead>
                    <tr class="A_trth">
                        <%--<th class="number">编号</th>--%>
                        <th class="Dishes">菜品 </th>
                        <th class="Type">类型 </th>
                        <th class="Price">价格 </th>
                        <th class="Operation">操作列 </th>
                    </tr>
                </thead>
                <tbody id="Dish${ID}">

                    <%--<tr class="Single">
                        <td class="Dishes">1</td>
                        <td class="Dishes">清炒土豆丝 <em class="icohot1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em><input name="" id="" type="hidden" value="清炒土豆丝" />
                        </td>
                        <td class="Type">素菜</td>
                        <td class="Price">￥15</td>
                        <td class="Operation">
                            <a class="btn" id="" href="javascript:;"><i class="iconfont"></i></a>
                        </td>
                    </tr>--%>
                </tbody>
            </table>
        </div>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="useDate" />
        <div class="Allot_Meal">
            <!--页面名称-->
            <%--<h1 class="title_name">分配菜单</h1>--%>
            <!--整个展示区域-->
            <div class="Whole_display_area">
                <div class="Operation_area clearfix">
                    <div class="left_choice fl">
                    </div>
                    <div class="right_add fr">
                        <a class="add" href="javascript:;" id="sfprevbtn">上一周</a>
                        <a class="add" href="javascript:;" id="sfnextbtn">下一周</a>
                        <a class="add" id="showtodaybtn">当前周</a>
                    </div>
                </div>

                <!--tab切换title-->
                <div class="Allot_tab">
                    <div class="Allot_tabheader" id="weekdate">
                        <ul class="toptr">
                            <li><%--<a href="javascript:void(0);">周一(2017-03-27)</a>--%></li>
                            <li><%--<a href="javascript:void(0);">周二(2017-03-28)</a>--%></li>
                            <li><%--<a href="javascript:void(0);">周三(2017-03-29)</a>--%></li>
                            <li><%--<a href="javascript:void(0);">周四(2017-03-30)</a>--%></li>
                            <li><%--<a href="javascript:void(0);">周五(2017-03-31)</a>--%></li>
                        </ul>
                    </div>
                    <div class="Allot_form">
                    </div>

                </div>
            </div>
        </div>
    </form>
    <script>
        function dataWeek() {
            var colNum = 0;
            timeArray = [];
            var cells = $(".toptr li");
            var clen = cells.length;
            var currentFirstDate;
            var formatDate = function (date) {
                var year = date.getFullYear();
                var month = (date.getMonth() + 1);
                var day = date.getDate();
                var week = '(' + ['星期天', '星期一', '星期二', '星期三', '星期四', '星期五'][date.getDay()] + ')';
                month = month < 10 ? "0" + month : month;
                day = day < 10 ? "0" + day : day;
                colNum++;
                timeArray += year + "-" + month + "-" + day + "/" + colNum + ",";
                return year + "-" + month + "-" + day + '  ' + week;
            };
            var TimeConvert = function (date) {
                var year = date.getFullYear();
                var month = (date.getMonth() + 1);
                var day = date.getDate();
                month = month < 10 ? "0" + month : month;
                day = day < 10 ? "0" + day : day;

                return year + "-" + month + "-" + day;
            };
            var addDate = function (date, n) {
                date.setDate(date.getDate() + n);
                return date;
            };
            var setDate = function (date) {
                var week = date.getDay() - 1;
                date = addDate(date, week * -1);
                currentFirstDate = new Date(date);

                for (var i = 0; i < clen; i++) {
                    var html = formatDate(i == 0 ? date : addDate(date, 1));
                    cells[i].innerHTML = html;
                    var CurrentTime = new Date();
                    if (date.toLocaleString() == CurrentTime.toLocaleString()) {
                        if (html.indexOf(TimeConvert(CurrentTime)) >= 0) {
                            $(".toptr li").eq(i).addClass("selected").siblings().removeClass("selected");
                            $("#useDate").val(TimeConvert(CurrentTime));
                        }
                    }
                    else {
                        if (i == 0) {
                            $(".toptr li").eq(0).addClass("selected").siblings().removeClass("selected");
                            $("#useDate").val(TimeConvert(date));
                        }
                    }

                }
                GetMenuDish();
            };
            document.getElementById('sfprevbtn').onclick = function () {
                timeArray = [];
                colNum = 0;
                setDate(addDate(currentFirstDate, -7));

            };
            document.getElementById('sfnextbtn').onclick = function () {
                timeArray = [];
                colNum = 0;
                setDate(addDate(currentFirstDate, 7));
            };
            document.getElementById('showtodaybtn').onclick = function () {
                timeArray = [];
                colNum = 0;
                setDate(new Date());
            };
            setDate(new Date());
        }


        function DepartMenu(ScaleID) {
            OpenIFrameWindow('挑选菜品', 'CreatMenu.aspx?useDate=' + $("#useDate").val() + '&ScaleID=' + ScaleID, '600px', '500px')
        }
        $(function () {
            dataWeek();
            $('.toptr li').click(function () {
                $(this).addClass('selected').siblings().removeClass('selected');
                var CurTime = $(this).html().toString().substring(0, 10);
                $("#useDate").val(CurTime);
                GetMenuDish();
            })
            GetTimeScale();
            GetMenuDish();
        })
        function GetTimeScale() {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: { PageName: "/CanteenReservation/Order_DishMenuHander.ashx", Func: "GetTimeScale", },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#DishTye").tmpl(json.result.retData).appendTo(".Allot_form");
                    }
                    else {
                    }
                },
                error: function (errMsg) {

                }
            });
        }
        function GetMenuDish() {
            $('.Allot_form .Food_Allot').each(function () {
                $(this).find('tbody').html("");
            })
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    PageName: "/CanteenReservation/Order_DishMenuHander.ashx", Func: "GetPageList", IsPage: 'false'
                    , "UseDate": $("#useDate").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {

                        $.each(json.result.retData, function () {
                            var DivID = 'Dish' + this.ScaleID;
                            $("#" + DivID).append('<tr><td>' + this.DishName + '</td><td class="Type">'
                                + this.DishType + '</td><td>￥' + this.Price + '</td><td><a class="btn" onclick="Del(' + this.ID + ')" title="删除" style="cursor:pointer;"><i class="iconfont">&#xe60e;</i></a></td></tr>');
                        })

                    }
                    else {

                    }
                    ScaleNum();
                },
                error: function (errMsg) {

                }
            });
        }
        function Del(ID) {

            if (confirm("确定要删除吗？")) {
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "CanteenReservation/Order_DishMenuHander.ashx", "Func": "Del", ID: ID
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            layer.msg("删除成功！");
                            GetMenuDish();
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

        }
        function ScaleNum() {
            $('.Allot_form .Food_Allot').each(function () {
                number = $(this).find('tbody').children('tr').length;
                $(this).children('.food_tit').find('i').html(number)
            })
        }
    </script>
</body>
</html>

