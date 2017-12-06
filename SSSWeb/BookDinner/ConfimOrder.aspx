<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfimOrder.aspx.cs" Inherits="SSSWeb.BookDinner.ConfimOrder" %>

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
        span.d_jiajian {
            vertical-align: middle;
            display: inline-block;
        }

            span.d_jiajian a {
                display: inline-block;
                border: 1px solid #ccc;
                color: #ccc;
                display: inline-block;
                font-size: 22px;
                height: 16px;
                line-height: 12px;
                text-align: center;
                vertical-align: middle;
                width: 16px;
            }



            span.d_jiajian em {
                color: #ccc;
                font-weight: normal;
            }

                span.d_jiajian em input {
                    width: 30px;
                    height: 12px;
                    margin: 0 4px;
                    vertical-align: middle;
                    text-align: center;
                }
    </style>
    <style type="text/css">
        .Number input {
            width: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="Confirmation_order">
                <!--页面名称-->
                <%--<h1 class="Page_name">订餐</h1>--%>
                <!--整个展示区域-->
                <div class="Whole_display_area">
                    <!--tab切换title-->
                    <div class="Order_tab">
                        <div class="Order_tabheader" id="ordertitle">
                            <ul>
                                <li class="selected">
                                    <a href="OrderIndex.aspx">
                                        <span class="zong_tit">
                                            <span class="num_1">1</span>
                                            <span class="add_li">挑选菜品</span>
                                        </span>
                                    </a>
                                </li>
                                <li class="selected">
                                    <a href="#">
                                        <span class="zong_tit">
                                            <span class="num_2">2</span>
                                            <span class="add_li">确认订单</span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="zong_tit">
                                            <span class="iconfont num_3"></span>
                                            <span class="add_li">完成</span></span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="content">
                            <div class="tc" style="display: none;">1</div>
                            <div class="tc" style="display: block;">
                                <div class="Order_form">
                                    <p class="Remind">
                                        提醒：如果要修改订单，请及时点击
                                        <a class="O_back" href="OrderIndex.aspx">[返回菜单点餐]</a>
                                        ，剩余修改时间
                                        <span class="Timeshow">【<span id="" style="color: red;">5小时15分29秒</span>】

                                        </span>
                                        ，过时将无法修改！
                                    </p>
                                    <div class="Food_order">
                                        <h2 class="food_tit clearfix">
                                            <span class="F_name" id="">晚餐</span>
                                            <span>
                                                <i><span id="">7</span></i>
                                                份菜品
                                            </span>｜
                                            <span>总计<i>￥<span id="">150</span></i></span>
                                        </h2>
                                        <table class="O_form">
                                            <tr class="O_trth">
                                                <!--表头tr名称-->
                                                <th class="Dishes">菜品</th>
                                                <th class="Type">类型</th>
                                                <th class="Price">单价</th>
                                                <th class="Number">数量</th>
                                                <th class="Subtotal">小计</th>
                                                <th class="Operation">操作</th>
                                            </tr>
                                            <tbody>
                                                <tr class="Single">
                                                    <td class="Dishes">炝炒虾仁<i class="iconfont ladu"><em class="icohot1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em></i></td>
                                                    <td class="Type">荤菜</td>
                                                    <td class="Price">￥23</td>
                                                    <td class="Number">
                                                        <span class="d_jiajian">
                                                            <a class="d_jian" id="" href="javascript:;">-</a>
                                                            <em>
                                                                <input name="" class="num" id="" type="number" value="2" min="0" />
                                                            </em>
                                                            <a class="d_jia" id="" href="javascript:;">+</a>
                                                        </span>
                                                    </td>
                                                    <td class="Subtotal">￥46</td>
                                                    <td class="Operation">
                                                        <a class="btn" id="" href="javascript:;"><i class="iconfont"></i></a></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="O_total"><span>菜品：<i><span id="">7</span></i>份</span><span>总计：<i>¥<span id="">150</span></i></span></div>
                                </div>
                                <div class="To_submit">
                                    <input name="list_back" class="list_back" type="button" value="返回点餐" />
                                    <input class="sure_list" onclick="ChangeOrderStatus()" type="button" value="确认订单" />
                                </div>
                            </div>
                            <div class="tc" id="Success" style="display: none;">
                                <p class="O_finish">
                                    <span class="fl icon_o"><i class="iconfont finish_t"></i></span>
                                    <span class="fl info_o">请按时到食堂就餐，谢谢合作。<br />
                                        订单状态请到<a href="UserOrderManage.aspx">［我的订单］</a>中查看</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <!--展示区域-->

            </div>
        </div>

    </form>
    <script type="text/javascript">
        $(function () {
            GetData();
        })
        function ChangeOrderStatus() {
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/CanteenReservation/UserOrder.ashx", Func: "OrderSure", Status: 1, CreateUID: '<%= UserInfo.UniqueNo %>'
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(".Order_tabheader ul li").eq(2).addClass("selected");
                        $(".content").find(".tc").eq(2).show().siblings().hide();
                    }
                    else {
                        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        $(".Food_order").html(html);
                    }
                },
                error: function (errMsg) {

                }
            });
        } 
        function GetData() {
            $('.Food_order').html("");
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    PageName: "/CanteenReservation/UserOrder.ashx", Func: "GetData", IsPage: "false", Status: 0, CreateUID: '<%= UserInfo.UniqueNo %>', DiffDay: 0
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var tableID = 'table' + this.ScaleID;
                            var tr = '<tr><td class="Dishes">' + this.DishName +
                                    '<i class="iconfont ladu"><em class="icohot1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em></i></td><td class="Type">' + this.TypeName
                                    + '</td><td class="Price">￥' + this.Price + '</td><td class="Number"><span class="d_jiajian"><em>' +
                                    this.Peaces + '</em></span></td><td class="Subtotal">￥' +
                                    this.Price * this.Peaces + '</td><td class="Operation"><a class="btn" id="" style="cursor:pointer;" title="删除" onclick="Del(' +
                                    this.ID + ')"><i class="iconfont">&#xe60e;</i></a></td></tr>';

                            if ($('#' + tableID).html() != undefined) {
                                $('#' + tableID).append(tr);
                            }
                            else {
                                $('.Food_order').append(' <h2 class="food_tit" id=' + this.ScaleID + '><span class="F_name" id="">' + this.ScaleName
                                    + '</span><span><i><span id="">7</span></i>份菜品</span>｜<span>总计<i>￥<span id="">150</span></i></span> </h2><div class="clear"></div>');
                                $('.Food_order').append('<table class="O_form"><tr class="O_trth"><th class="Dishes">菜品</th><th class="Type">类型</th><th class="Price">单价</th><th class="Number">数量</th><th class="Subtotal">小计</th><th class="Operation">操作</th></tr><tbody id=' + tableID
                                    + '> </tbody> </table>');
                                $('#' + tableID).append(tr);

                            }
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
        //删除订单
        function Del(ID) {
            if (confirm("确定要删除订单?")) {

                $.ajax({
                    url: "../Common.ashx",
                    type: "post",
                    dataType: "json",
                    async: false,
                    data: {
                        PageName: "/CanteenReservation/UserOrder.ashx", Func: "Del", ID: ID
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            GetData();
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (errMsg) {

                    }
                })
            }
        }
        function GetEachNum() {

            $(".Food_order").find('.food_tit').each(function () {
                var tableID = 'table' + $(this).attr('id');
                var num = 0;
                var cash = 0;
                $("#" + tableID + ">tr").each(function () {
                    num++;
                    cash += parseInt($(this).find(".Subtotal").html().replace('￥', ''));

                })
                $("#" + tableID).find(".Subtotal").html().replace('￥', '')
                $(this).children("span").eq(1).find('i span').html(num);
                $(this).children("span").eq(2).find('i span').html(cash);

            })
        }
        function GetAllNum() {
            var num = 0;
            var cash = 0;

            $(".Food_order").find('.food_tit').each(function () {
                num += parseInt($(this).children("span").eq(1).find('i span').html());
                cash += parseInt($(this).children("span").eq(2).find('i span').html().replace('￥', ''));

            })
            $(".O_total").children("span").eq(0).find('i span').html(num);
            $(".O_total").children("span").eq(1).find('i span').html(cash);
        }
    </script>
</body>
</html>
