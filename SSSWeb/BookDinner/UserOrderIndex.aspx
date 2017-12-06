<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserOrderIndex.aspx.cs" Inherits="SSSWeb.BookDinner.UserOrderIndex" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>订餐</title>
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />

    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/iconfont.css" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <%--<script type="text/javascript" src="../ZZSX/js/tz_slider.js"></script>--%>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>

    <script id="tr_User" type="text/x-jquery-tmpl">
        <li>
            <div>
                <span class="img_food">
                    <img src="${Photo}" onerror="javascript:this.src='../ZZSX/images/food.jpg'" /></span>
                <span class="name_food">${DishName}<i class="iconfont"></i></span>
                <span class="money_food"><i class="shuzi">￥${Price}</i>
                    {{if maxMinite-diffMinite>0}}  
                    <a href="#"><i class="iconfont fr jia" onclick="CartAdd(${EachDishID},'${DishName}',${Price},${ScaleID})">&#xf0087;</i></a>
                    {{/if}}
                </span>
            </div>
        </li>
    </script>
</head>
<body style="background: #fafafa;">
    <input type="hidden" id="ScaleID" value="" />
    <input type="hidden" id="DishID" value="" />
    <input type="hidden" id="useDate" value="" />

    <!--订餐-->
    <div class="Ordering">
        <!--页面名称-->
        <%--<h1 class="Page_name">订餐</h1>--%>
        <!--整个展示区域-->
        <div class="Whole_display_area">
            <div class="information_top">
                <em id="Name"><b>营业中</b>
                </em>
                <span>
                    <i class="iconfont">&#xe647;</i>
                    营业时间<span id="Time"></span>
                </span>
                <span>
                    <i class="iconfont">&#xe65e;</i>
                    食堂地址：<span id="AddressMsg"></span>
                </span>
                <span class="fr"><a href="#">
                    <input type="button" value="食堂信息设置" onclick="javascript: OpenIFrameWindow('食堂信息设置', 'CannTeenBaseSit.aspx', '605px', '515px');" /></a></span>
            </div>
            <div class="information_bottom">
                <!---选项卡-->
                <div class="dc_tab fl">
                    <div class="dc_tabheader">
                        <ul class="tab_tit">
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                        </ul>
                    </div>
                    <div class="content">
                        <div class="Screening_conditions">
                            <dl class="time_food clearfix">
                            </dl>
                            <dl class="dishes clearfix">
                            </dl>
                        </div>
                        <!--菜品-->
                        <div class="food_con">
                            <ul class="foodcontent">
                            </ul>
                            <!--分页-->
                            <div class="page none">
                                <span id="pageBar"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="announce fr">
                    <div class="announce_con">
                        <span class="title">餐厅公告
                        </span>
                        <ul class="announce_lists">
                            <li id="Notice"><%--1.请各位老师务必在规定的点餐时间，登陆系统点餐，超时后订餐功能会禁用，谢谢合作。午餐最晚下单时间11:00晚餐最晚下单时间16:00--%>
                            </li>
                            <%--<li>2.新品上市，敬请期待
                            </li>--%>
                        </ul>
                    </div>
                </div>
                <div class="Shopping_cart">
                    <div class="shopping">
                        <!--购物车 数量-->
                        <h1><span class="shop_name fl">购物车</span><span class="shop_num fr">0</span></h1>
                        <div class="clear"></div>
                        <!--购物车订单-->
                        <div class="shopping_food">
                            <!--菜单区域-->
                            <div id="menubox" class="shop_menu">
                                <ul id="MenuCart">
                                    <%-- <li>
                                        <a class="menuclick" href="#">
                                            <span class="lz_name fl">早餐 </span>
                                            <span class="rz_con fr"><span class="num_num z_num">2</span><span class="z_total">小计：<em class="money_num">50</em></span></span>
                                        </a>
                                        <ul class="submenu">
                                            <li>
                                                <span class="d_dish" style="width: 30%;">宫保鸡丁</span>
                                                <span class="d_jiajian" style="width: 40%; text-align: center">
                                                    <a href="#" class="d_jia">+</a>
                                                    <em class="">
                                                        <input type="number" value="1" min="0" /></em>
                                                    <a href="#" class="d_jian">-</a>
                                                </span>
                                                <span class="d_money" style="width: 15%; text-align: center">30</span>
                                                <span class="d_delete" style="width: 15%; text-align: center"><em class="iconfont d_d">&#x3474;</em></span>
                                            </li>
                                            <li>
                                                <span class="d_dish" style="width: 30%;">宫保鸡丁</span>
                                                <span class="d_jiajian" style="width: 40%; text-align: center">
                                                    <a href="#" class="d_jia">+</a>
                                                    <em class="">
                                                        <input type="number" value="1" min="0" /></em>
                                                    <a href="#" class="d_jian">-</a>
                                                </span>
                                                <span class="d_money" style="width: 15%; text-align: center">30</span>
                                                <span class="d_delete" style="width: 15%; text-align: center"><em class="iconfont d_d">&#x3474;</em></span>
                                            </li>
                                        </ul>
                                    </li>--%>
                                </ul>
                            </div>
                            <!--end 菜单区域-->

                        </div>
                        <div class="clear"></div>
                        <!--总计钱数 提交-->
                        <div class="Total">
                            <span class="total_money fl">总计：
                                <em class="total_num">0</em>
                            </span>
                            <span class="total_submit fr">
                                <a href="#">
                                    <input type="button" onclick="SaveCart()" value="提交" />
                                </a>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            GetBase();
            BindDishType();
            GetTimeScale();
            dataWeek();
            $(".tab_tit li").click(function () {
                $(this).addClass("selected").siblings().removeClass("selected");
                var id = $(this).children('a').attr('id');
                $("#useDate").val(id);
                GetMenuDish(1, 12);
            })
            //GetMenuDish(1, 12);
        })
        /*刘泽你改吧*/
        function CartDeal() {
            var totalText = $('.shop_num');
            $('#MenuCart>li').each(function () {
                $(this).find('li').each(function () {
                    var $curInput = $(this).find('input');
                    var $add = $(this).find('.d_jia');
                    var $reduce = $(this).find('.d_jian');
                    var $curMoney = $(this).find('.d_money');
                    var CurMoney = parseInt($curMoney.html()) / parseInt($curInput.val());
                    var Name = $(this).find(".d_dish").html();
                    $add.click(function () {
                        var n = parseInt($curInput.val()) + 1;
                        $curInput.val(n);
                        $curMoney.html(parseInt(CurMoney) * n);
                        totalText.html(sum());
                        i++;
                    })
                    $reduce.click(function () {
                        var n = parseInt($curInput.val()) - 1;
                        if (n < 0) {
                            return;
                        };
                        $curInput.val(n);
                        $curMoney.html(parseInt(CurMoney) * n);
                        totalText.html(sum());

                    })

                    $curInput.blur(function () {
                        var $val = Number($(this).val());
                        $curMoney.html(parseInt(CurMoney) * n);
                        totalText.html(sum());

                    })
                })
            })
            function sum() {
                var sum = 0;
                $('#MenuCart>li').each(function () {
                    $(this).find('li').each(function () {
                        var $curInput = $(this).find('input');
                        sum += parseInt($curInput.val());
                    })
                })
                return sum;
            }

        }
        function CartDeal(em, Num) {
            var totalText = $('.shop_num');
            var $totalCash = $(".total_num");
            var $curInput = $(em).parent().find('input');
            var $curMoney = $(em).parent().parent().find('.d_money');
            var CurMoney = parseInt($curMoney.html()) / parseInt($curInput.val());
            var n = parseInt($curInput.val());
            if (Num == 0) {
                if (n > 1) {
                    n = parseInt($curInput.val()) - 1;
                }
            }
            else {
                n = parseInt($curInput.val()) + 1;
            }
            $curInput.val(n);
            $curMoney.html(parseInt(CurMoney) * n);
            totalText.html(sum());
            $totalCash.html(sumCash());
            /*$('#MenuCart>li').each(function () {
                $(this).find('li').each(function () {
                    var $curInput = $(this).find('input');
                    var $add = $(this).find('.d_jia');
                    var $reduce = $(this).find('.d_jian');
                    var $curMoney = $(this).find('.d_money');
                    var CurMoney = parseInt($curMoney.html()) / parseInt($curInput.val());
                    var Name = $(this).find(".d_dish").html();
                    $add.click(function () {
                        var n = parseInt($curInput.val()) + 1;
                        $curInput.val(n);
                        $curMoney.html(parseInt(CurMoney) * n);
                        totalText.html(sum());
                        i++;
                    })
                    $reduce.click(function () {
                        var n = parseInt($curInput.val()) - 1;
                        if (n < 0) {
                            return;
                        };
                        $curInput.val(n);
                        $curMoney.html(parseInt(CurMoney) * n);
                        totalText.html(sum());

                    })

                    $curInput.blur(function () {
                        var $val = Number($(this).val());
                        $curMoney.html(parseInt(CurMoney) * n);
                        totalText.html(sum());

                    })
                })
            })*/
            function sumCash() {
                var sumCash = 0;
                $('#MenuCart>li').each(function () {
                    var num1 = 0;
                    $(this).find('li').each(function () {
                        var $curMoney = $(this).find('.d_money');
                        sumCash += parseInt($curMoney.html());
                        num1 += parseInt($curMoney.html());
                    })
                    $(this).find(".money_num").html(num1);
                    //alert(num1);
                })
                return sumCash;
            }
            function sum() {
                var sum = 0;
                $('#MenuCart>li').each(function () {
                    var num1 = 0;

                    $(this).find('li').each(function () {
                        var $curInput = $(this).find('input');
                        sum += parseInt($curInput.val());
                        num1 += parseInt($curInput.val());
                    })
                    $(this).find(".z_num").html(num1);

                })
                return sum;
            }

        }
        //购物车数据提交
        function SaveCart() {
            var result = "";
            $(".submenu").find("li").each(function () {
                var DashiID = $(this).attr("id");
                var DashNum = $(this).find("input").val();
                var ScaleID = $(this).parent().attr("id").replace('submenu', '');
                result += ScaleID + '-' + DashiID + '-' + DashNum + ',';
            });
            if (result == "") {
                layer.msg("请选择菜品");
            }
            else {
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "CanteenReservation/UserOrder.ashx", "Func": "Add", result: result, CreateUID: '<%=UserInfo.UniqueNo%>' },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            window.location = "ConfimOrder.aspx";
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
        //添加到购物车
        function CartAdd(DishID, DishName, Price, ScaleID) {
            var ulID = 'submenu' + ScaleID;
            var CardNum = 'cartnum' + ScaleID;
            var CashNum = 'cashnum' + ScaleID;
            var Cash = parseInt($("#" + CashNum).html()) + parseInt(Price);
            $("#" + CashNum).html(Cash);
            $("#" + CardNum).html(parseInt($("#" + CardNum).html()) + 1);
            $(".shop_num").html(parseInt($(".shop_num").html()) + 1);
            $(".total_num").html(parseInt($(".total_num").html()) + parseInt(Price));
            $("#" + ulID).append('<li id=' + DishID + '><span class="d_dish" style="width: 30%;">' + DishName
                + '</span><span class="d_jiajian" style="width: 40%; text-align: center"><a href="#" class="d_jian" onclick="CartDeal(this,0)">-</a><em class=""><input type="number" value="1" min="0" /></em><a href="#" class="d_jia"  onclick="CartDeal(this,1)">+</a></span><span class="d_money" style="width: 15%; text-align: center">' +
                Price + '</span><span class="d_delete" style="width: 15%; text-align: center"><em class="iconfont d_d" onclick="DelCart(this)">&#x3474;</em></span></li>');
        }
        function DelCart(em) {
            var cash = $(em).parent().parent().find(".d_money").html();
            var num = $(em).parent().parent().find("input").val();

            $(".shop_num").html(parseInt($(".shop_num").html()) - parseInt(num));
            $(".total_num").html(parseInt($(".total_num").html()) + -parseInt(cash));
            var znum = $(em).parent().parent().parent().parent().find(".z_num");
            var money_num = $(em).parent().parent().parent().parent().find(".money_num");
            $(znum).html(parseInt($(znum).html()) - parseInt(num));
            $(money_num).html(parseInt($(money_num).html()) - parseInt(cash))
            $(em).parent().parent().remove();
        }
        //绑定数据
        function GetBase() {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CanteenReservation/BaseSit.ashx", "Func": "GetCanteeData" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {

                            $("#Name").html(this.Name);
                            $("#Time").html(this.BeginTime + '-' + this.EndTime);
                            //$("#img_Pic").attr("src", this.Photo);
                            $("#AddressMsg").html(this.AddressMsg);
                            $("#Notice").html(this.Notice);
                        });
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
        function dataWeek() {
            var colNum = 0;
            timeArray = [];
            var cells = $(".tab_tit li");
            var clen = cells.length;
            var currentFirstDate;
            var formatDate = function (date) {
                var year = date.getFullYear();
                var month = (date.getMonth() + 1);
                var day = date.getDate();
                var week = ['周日', '周一', '周二', '周三', '周四', '周五'][date.getDay()];
                month = month < 10 ? "0" + month : month;
                day = day < 10 ? "0" + day : day;
                colNum++;
                timeArray += year + "-" + month + "-" + day + "/" + colNum + ",";
                return '<a id="' + year + "-" + month + "-" + day + '">' + week + '</a> ';
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
                var flag = true;
                for (var i = 0; i < clen; i++) {
                    var html = formatDate(i == 0 ? date : addDate(date, 1));
                    cells[i].innerHTML = html;
                    var CurrentTime = new Date();
                    if (html.indexOf(TimeConvert(CurrentTime)) >= 0) {
                        $(".tab_tit li").eq(i).addClass("selected").siblings().removeClass("selected");
                        $("#useDate").val(TimeConvert(CurrentTime));
                        flag = false;
                    }
                    if (flag) {

                        $(".tab_tit li").eq(0).children('a').addClass("selected").siblings().removeClass("selected");
                        $("#useDate").val($(".tab_tit li").eq(0).children('a').attr('id'));

                        //$("#useDate").val(TimeConvert(new Date()))
                    }
                }
                GetMenuDish(1, 12);
            };
            if (new Date().getDay() == "6" || new Date().getDay() == "7") {
                setDate(addDate(new Date(), 7));
            }
            else {
                setDate(new Date());
            }
        }
        //判断时间段
        var time_range = function (beginTime, endTime) {
            var strb = beginTime.split(":");
            if (strb.length != 2) {
                return false;
            }

            var stre = endTime.split(":");
            if (stre.length != 2) {
                return false;
            }

            var b = new Date();
            var e = new Date();
            var n = new Date();

            b.setHours(strb[0]);
            b.setMinutes(strb[1]);
            e.setHours(stre[0]);
            e.setMinutes(stre[1]);

            if (n.getTime() - b.getTime() > 0 && n.getTime() - e.getTime() < 0) {
                return true;
            } else {
                //alert("当前时间是：" + n.getHours() + ":" + n.getMinutes() + "，不在该时间范围内！");
                return false;
            }
        }


        //订餐时间：早餐、中餐、晚餐
        function GetTimeScale() {
            $("#MenuCart").html("");
            $(".time_food").html('<dt>时段：</dt><dd class="selected"><a href="#" id="">所有</a></dd>');
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: { PageName: "/CanteenReservation/Order_DishMenuHander.ashx", Func: "GetTimeScale" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $.each(json.result.retData, function () {
                            var Flag = time_range(this.BeginTime, this.EndTime);
                            if (Flag) {
                                $(".time_food").find("dd").eq(0).removeClass("selected");
                                $(".time_food").append('<dd  class="selected"><a href="#" id=' + this.ID+'>' + this.Name + '</a></dd>');
                                $("#ScaleID").val(this.ID);

                            }
                            else {
                                $(".time_food").append('<dd><a href="#" id=' + this.ID + ' BeginTime="' + this.BeginTime + '" EndTime="' + this.EndTime + '">' + this.Name + '</a></dd>');

                            }
                            var CardNum = 'cartnum' + this.ID;
                            var CashNum = 'cashnum' + this.ID;
                            var ulID = 'submenu' + this.ID;
                            $("#MenuCart").append('<li><a class="menuclick" href="#"><span class="lz_name fl">' + this.Name
                                + ' </span><span class="rz_con fr"><span class="num_num z_num" id=' + CardNum
                                + '>0</span><span class="z_total">小计：<em class="money_num" id=' + CashNum
                                + '>0</em></span></span></a><ul class="submenu" id=' + ulID + '></ul></li>');
                        })
                    }
                    else {
                    }
                },
                error: function (errMsg) {

                }
            });
            $(".time_food").find('dd').click(function () {
                $(this).addClass("selected").siblings().removeClass("selected");
                var id = $(this).children('a').attr('id');
                $("#ScaleID").val(id);
                GetMenuDish(1, 12);

            })
        }
        //菜品
        function BindDishType() {
            $(".dishes").html('<dt>菜品：</dt><dd class="selected"><a href="#" id="">所有</a></dd>');
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,

                data: { PageName: "/CanteenReservation/Order_DishHander.ashx", Func: "GetDishType" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $(".dishes").append('<dd><a href="#" id=' + this.ID + '>' + this.Name + '</a></dd>');
                        });
                    }
                    else {
                    }
                },
                error: function (errMsg) {

                }
            });
            $(".dishes").find('dd').click(function () {
                $(this).addClass("selected").siblings().removeClass("selected");
                var id = $(this).children('a').attr('id');
                $("#DishID").val(id);
                GetMenuDish(1, 12);
            })
        }
        //菜单
        function GetMenuDish(startIndex, pageSize) {
            $('.Allot_form .Food_Allot').each(function () {
                $(this).find('tbody').html("");
            })
            $.ajax({
                url: "../Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    PageName: "/CanteenReservation/Order_DishMenuHander.ashx", Func: "GetPageList", PageIndex: startIndex, pageSize: pageSize,
                    ScaleID: $("#ScaleID").val(), DishID: $("#DishID").val()
                     , "UseDate": $("#useDate").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(".foodcontent").html('');
                        $("#tr_User").tmpl(json.result.retData.PagedData).appendTo(".foodcontent");
                        //ButtonList($("#HPId").val());
                        makePageBar(GetMenuDish, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                        if (json.result.retData.RowCount > pageSize) {
                            $(".page").show();
                        }
                    }
                    else {
                        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        $(".foodcontent").html(html);
                        $(".page").hide();
                        //layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {

                }
            });
        }

    </script>
</body>

</html>
