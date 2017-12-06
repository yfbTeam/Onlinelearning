<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserOrderManage.aspx.cs" Inherits="SSSWeb.BookDinner.UserOrderManage" %>

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
    <style>
        .myorderfood_tit {
            padding: 10px;
        }

        .times {
            padding: 10px 0px;
        }

        .Dishes {
            width: 200px;
        }

        .Type {
            width: 200px;
        }

        .Price {
            width: 200px;
        }

        .Number {
            width: 200px;
        }

        .Subtotal {
            width: 200px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="DiffDay" value="0" />
        <div class="Confirmation_order">
            <!--页面名称-->
            <%--<h1 class="Page_name">我的订单</h1>--%>
            <!--整个展示区域-->
            <div class="Whole_display_area">
                <div class="Operation_area clearfix">
                    <div class="left_choice fl">
                        <ul>
                            <li>
                                <div class="qiehuan fl">
                                    <span class="qijin">
                                        <a class="Enable" href="javascript:;" id="0">今日订单</a>
                                        <a class="Disable" href="javascript:;" id="1">历史订单</a>
                                    </span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="right_add fr">
                    </div>
                </div>
                <div class="times">
                    <span class="times_input">
                        <input class="time Wdate" id="" onclick="WdatePicker()" type="text" readonly="readonly" name="" /><i class="iconfont"></i>
                    </span>- 
                    <span class="times_input">
                        <input name="" class="time Wdate" id="" onclick="WdatePicker()" type="text" readonly="readonly" /><i class="iconfont"></i>
                    </span>
                    <input name="" class="b_query" id="" type="submit" value="查询" />
                </div>
                <div class="Display_form">
                    <div class="my_order">
                        <%--<h1>统计：
                            <span class="o_num">订单
                                <i>
                                    <span id="">2</span>
                                </i>
                            </span>
                            ,
                            <span class="o_menu">菜品
                                <i>
                                    <span id="">7</span>
                                    份,

                                </i>
                            </span>
                            <span class="o_count">总计
                                <i>￥<span id="">190</span></i>
                            </span>
                        </h1>--%>
                        <div id="slide">
                            <!--菜单区域-->
                            <ul id="Order">
                                <li class="selected">
                                    <a class="order_click" href="#">
                                        <i>-</i>
                                        <span class="Td_con">
                                            <span class="T_data">
                                                <span id="">2017-03-31</span></span>｜ 
                                            <span class="T_num" id="">4</span> 份菜品｜总计 ￥
                                            <span class="T_total" id="">170</span>
                                        </span>
                                    </a>
                                    <div class="order_con animated bounceIn" style="display: block;">
                                        <div class="Food_order">
                                            <h2 class="food_tit">
                                                <span class="F_name">晚餐</span>
                                                金额：￥<span id="">170</span>
                                            </h2>
                                            <h2 class="myorderfood_tit">订单编号 
                                                <span id="">2017331141552823</span> | 金额：￥<span id="">170</span></h2>
                                            <table class="O_form">

                                                <tr class="O_trth">
                                                    <th class="Dishes">编号</th>
                                                    <th class="Dishes">菜品</th>
                                                    <th class="Number">数量</th>
                                                    <th class="Price">价格</th>
                                                    <th class="Subtotal">小计</th>
                                                    <th class="Dishes">状态</th>
                                                </tr>
                                                <tbody>
                                                    <tr class="Single">
                                                        <td class="Dishes">
                                                            <label>1</label>
                                                        </td>
                                                        <td class="Dishes">
                                                            <label>炝炒虾仁</label></td>
                                                        <td class="Number">
                                                            <label>2</label></td>
                                                        <td class="Price">
                                                            <label>￥23</label></td>
                                                        <td class="Subtotal">
                                                            <label>￥46</label></td>
                                                        <td class="Price">
                                                            <label><font style="color: rgb(150, 204, 102);">已确认</font></label>
                                                        </td>
                                                    </tr>


                                                </tbody>
                                            </table>

                                        </div>
                                    </div>
                                </li>
                                <%--<li>
                                    <a class="order_click" href="#">
                                        <i>+</i>
                                        <span class="Td_con">
                                            <span class="T_data">
                                                <span id="">2017-03-31</span></span>｜ 
                                            <span class="T_num" id="">4</span> 份菜品｜总计 ￥
                                            <span class="T_total" id="">170</span>
                                        </span>
                                    </a>
                                    <div class="order_con animated bounceIn" style="display: none;">
                                        <div class="Food_order">
                                            <h2 class="food_tit">
                                                <span class="F_name">晚餐</span>
                                                金额：￥<span id="">170</span>
                                            </h2>
                                            <h2 class="myorderfood_tit">订单编号 
                                                <span id="">2017331141552823</span>|金额：￥<span id="">170</span></h2>
                                            <table class="O_form">

                                                <tr class="O_trth">
                                                    <th class="Dishes">编号</th>
                                                    <th class="Dishes">菜品</th>
                                                    <th class="Number">数量</th>
                                                    <th class="Price">价格</th>
                                                    <th class="Subtotal">小计</th>
                                                    <th class="Dishes">状态</th>
                                                </tr>
                                                <tbody>
                                                    <tr>
                                                        <td class="Dishes">
                                                            <label>1</label>
                                                        </td>
                                                        <td class="Dishes">
                                                            <label>炝炒虾仁</label></td>
                                                        <td class="Number">
                                                            <label>2</label></td>
                                                        <td class="Price">
                                                            <label>￥23</label></td>
                                                        <td class="Subtotal">
                                                            <label>￥46</label></td>
                                                        <td class="Price">
                                                            <label><font style="color: rgb(150, 204, 102);">已确认</font></label>
                                                        </td>
                                                    </tr>

                                                </tbody>
                                            </table>
                                            <div class="page" id="">
                                                <span id=""><a class="aspNetDisabled">首页</a>&nbsp;<a class="aspNetDisabled">上一页</a>&nbsp;<span class="number now">1</span>&nbsp;<a class="aspNetDisabled">下一页</a>&nbsp;<a class="aspNetDisabled">末页</a>&nbsp;                         
                                                    <span class="page">| 1 /  1  页(共1项)</span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </li>--%>
                            </ul>
                        </div>

                        <%--<div class="page" id="" style="display: none;">
                            <span id=""><a class="aspNetDisabled">首页</a>&nbsp;<a class="aspNetDisabled">上一页</a>&nbsp;<span class="number now">1</span>&nbsp;<a class="aspNetDisabled">下一页</a>&nbsp;<a class="aspNetDisabled">末页</a>&nbsp;<span class="page">| 1 / 1  页(共2项) </span>
                            </span>
                        </div>--%>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            $(".qijin a").click(function () {
                if ($(this).attr('class') == "Disable") {
                    $(this).removeClass("Disable").addClass("Enable").siblings().removeClass("Enable").addClass("Disable");
                    $("#DiffDay").val($(this).attr("id"));
                    GetData();
                }
            })
            GetData();
        })
        function GetData() {
            var CreateUID = "";
            if (UrlDate.Type == "My") {
                CreateUID = '<%= UserInfo.UniqueNo %>';
            }
            $('#Order').html("");
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    PageName: "/CanteenReservation/UserOrder.ashx", Func: "GetData", IsPage: "false", Status: 1, CreateUID: CreateUID, DiffDay: $("#DiffDay").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var i = 0;
                        var styleName = "none";
                        var iHtml = '+';
                        $(json.result.retData).each(function () {
                            var liID = 'li' + this.DiffDay;
                            if ($('#' + liID).html() != undefined) {
                                var tableID = 'table' + this.ScaleID;
                                var tr = '<tr><td class="Dishes">' + this.DishName +
                                        '<i class="iconfont ladu"><em class="icohot1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em></i></td><td class="Type">' + this.CreateName
                                        + '</td><td class="Price">￥' + this.Price + '</td><td class="Number"><span class="d_jiajian"><em>' +
                                        this.Peaces + '</em></span></td><td class="Subtotal">￥' +
                                        this.Price * this.Peaces + '</td><td class="Price"><label><font style="color: rgb(150, 204, 102);">已确认</font></label></td></tr>';

                                //if ($('#' + tableID).html() != undefined && $('#' + tableID).parent().parent().attr('id') == 'li' + this.DiffDay) {
                                if ($("#" + liID).find('#' + tableID).html() != undefined) {
                                    $("#" + liID).find('#' + tableID).append(tr);
                                }
                                else {
                                    $('#' + liID).append(' <h2 class="food_tit" id=' + this.ScaleID + '><span class="F_name" id="">' + this.ScaleName
                                        + '</span><span><i><span id="">7</span></i>份菜品</span>｜<span>总计<i>￥<span id="">150</span></i></span> </h2><div class="clear"></div>');
                                    $("#" + liID).append('<table class="O_form"><tr class="O_trth"><th class="Dishes">菜品</th><th class="Type">用户</th><th class="Price">单价</th><th class="Number">数量</th><th class="Subtotal">小计</th><th class="Operation">状态</th></tr><tbody id=' + tableID
                                        + '> </tbody> </table>');
                                    $("#" + liID).find('#' + tableID).append(tr);

                                }
                            }
                            else {
                                if (i == 0) {
                                    styleName = "";
                                    iHtml = '-';
                                }
                                else {
                                    styleName = "none";
                                    iHtml = '+';
                                }
                                $('#Order').append('<li class="selected"><a class="order_click" href="#"><i>' + iHtml
                                    + '</i><span class="Td_con"><span class="T_data"><span id="">' +
                                    DateTimeConvert(this.CreateTime) + '</span></span>｜<span class="T_num" id="">4</span> 份菜品｜总计 ￥<span class="T_total" id="">170</span></span></a><div class="order_con animated bounceIn ' + styleName + '"><div class="Food_order" id=' +
                                   liID + '> </div></div></li>');


                                var tableID = 'table' + this.ScaleID;
                                var tr = '<tr><td class="Dishes">' + this.DishName +
                                        '<i class="iconfont ladu"><em class="icohot1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em></i></td><td class="Type">' + this.CreateName
                                        + '</td><td class="Price">￥' + this.Price + '</td><td class="Number"><span class="d_jiajian"><em>' +
                                        this.Peaces + '</em></span></td><td class="Subtotal">￥' +
                                        this.Price * this.Peaces + '</td><td class="Price"><label><font style="color: rgb(150, 204, 102);">已确认</font></label></td></tr>';
                                if ($("#" + liID).find('#' + tableID).html() != undefined) {
                                    //if ($('#' + tableID).html() != undefined && $('#' + tableID).parent().parent().attr('id') == 'li' + this.DiffDay) {
                                    $("#" + liID).find('#' + tableID).append(tr);
                                }
                                else {
                                    $('#' + liID).append(' <h2 class="food_tit" id=' + this.ScaleID + '><span class="F_name" id="">' + this.ScaleName
                                        + '</span><span><i><span id="">7</span></i>份菜品</span>｜<span>总计<i>￥<span id="">150</span></i></span> </h2><div class="clear"></div>');
                                    $("#" + liID).append('<table class="O_form"><tr class="O_trth"><th class="Dishes">菜品</th><th class="Type">用户</th><th class="Price">单价</th><th class="Number">数量</th><th class="Subtotal">小计</th><th class="Operation">操作</th></tr><tbody id=' + tableID
                                        + '> </tbody> </table>');
                                    $("#" + liID).find('#' + tableID).append(tr);

                                }
                            }
                            i++;

                        })
                        $(".my_order li").each(function () {
                            $(this).find('a').click(function () {
                                if ($(this).parent().find(".order_con").hasClass('none')) {
                                    $(this).parent().find(".order_con").removeClass('none');
                                    $(this).find('i').html('-');
                                }
                                else {
                                    $(this).parent().find(".order_con").addClass('none');
                                    $(this).find('i').html('+');
                                }
                            })
                        })
                    }
                    else {
                        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        $(".Food_order").html(html);
                    }
                },
                error: function (errMsg) {

                }

            });
            GetEachNum();
            GetAllNum();
        }
        function GetEachNum() {

            $(".Food_order").find('.food_tit').each(function () {
                var tableID = 'table' + $(this).attr('id');
                var num = 0;
                var cash = 0;

                $(this).parent().find("#" + tableID + ">tr").each(function () {
                    num++;
                    cash += parseInt($(this).find(".Subtotal").html().replace('￥', ''));

                })
                $("#" + tableID).find(".Subtotal").html().replace('￥', '')
                $(this).children("span").eq(1).find('i span').html(num);
                $(this).children("span").eq(2).find('i span').html(cash);

            })
        }
        function GetAllNum() {
            $(".my_order li").each(function () {
                var num = 0;
                var cash = 0;

                $(this).find(".Food_order").find('.food_tit').each(function () {
                    num += parseInt($(this).children("span").eq(1).find('i span').html());
                    cash += parseInt($(this).children("span").eq(2).find('i span').html().replace('￥', ''));

                })
                $(this).find(".Td_con").children("span").eq(1).html(num);
                $(this).find(".Td_con").children("span").eq(2).html(cash);
            })

            //$(".my_order h1").children("span").eq(1).find('i span').html(num);
            //$(".my_order h1").children("span").eq(2).find('i span').html(cash);

        }
    </script>
</body>
</html>
