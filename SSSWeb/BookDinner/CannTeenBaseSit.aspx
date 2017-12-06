<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CannTeenBaseSit.aspx.cs" Inherits="SSSWeb.BookDinner.CannTeenBaseSit" %>

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
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
        .ss_dialog {
            width: 600px;
            position: absolute;
            z-index: 9999;
        }

        .ss_tab {
            width: 600px;
            height: 467px;
            background: #fff;
        }

            .ss_tab .yy_tabheader {
                height: 45px;
                transition: all 0.3s ease-in-out;
                background: #fafafa;
                border-bottom: 1px solid #ccc;
            }

            .ss_tab ul li {
                width: 198px;
                float: left;
                line-height: 45px;
                text-align: center;
            }

            .ss_tab .yy_tabheader a {
                text-decoration: none;
                color: #666;
                display: block;
                text-align: center;
                overflow: hidden;
            }
            /*选中颜色*/
            .ss_tab .yy_tabheader ul li.selected {
                background: #fff;
                border-bottom: 2px solid #96cc66;
                line-height: 44px;
                transition: all 0.3s ease-in-out;
            }

                .ss_tab .yy_tabheader ul li.selected a span.num_1, .ss_tab .yy_tabheader ul li.selected a span.num_2 {
                    background: #96cc66;
                }

                .ss_tab .yy_tabheader ul li.selected a span.num_3 {
                    color: #96cc66;
                }

            .ss_tab .yy_tabheader ul li a span.zong_tit {
                display: block;
                overflow: hidden;
                width: 116px;
                margin: auto;
                line-height: 44px;
                text-align: center;
            }
            /*未选中颜色*/
            .ss_tab .yy_tabheader ul li a span.num_1, .ss_tab .yy_tabheader ul li a span.num_2 {
                color: #fff;
                background: #bfbfbf;
                border-radius: 44px;
                display: block;
                float: left;
                line-height: 20px;
                margin-top: 10px;
                margin-right: 10px;
                width: 22px;
                height: 21px;
            }

            .ss_tab .yy_tabheader ul li a span.add_li {
            }

            .ss_tab .yy_tabheader ul li a span.num_3 {
                color: #bfbfbf;
                display: block;
                float: left;
                font-size: 24px;
                line-height: 20px;
                margin-top: 10px;
                margin-right: -21px;
                width: 22px;
                height: 21px;
            }
            /*tab_content*/
            .ss_tab .content .tc {
                margin: auto;
                padding: 15px;
            }
        /*两个框之间的线*/
        .ss_dialog .t_content .t_message .message_con .c_line {
            border-bottom: 1px solid #ccc;
            margin: 10px;
            display: block;
            overflow: hidden;
        }
        /*input框*/
        .ss_dialog .t_content .t_message .message_con tr td {
            font-size: 14px;
            line-height: 28px;
            padding: 10px;
        }

            .ss_dialog .t_content .t_message .message_con tr td.mi {
                width: 130px;
                text-align: right;
                vertical-align: middle;
            }

            .ss_dialog .t_content .t_message .message_con tr td.ku input {
                border-radius: 3px;
                line-height: 28px;
                height: 28px;
                padding: 0px 10px;
                width: 186px;
            }

            .ss_dialog .t_content .t_message .message_con tr td.ku img {
                position: absolute;
                top: 73px;
                right: 65px;
            }

            .ss_dialog .t_content .t_message .message_con tr td.ku textarea {
                border-radius: 3px;
                margin-top: 5px;
                height: 60px;
                border: 1px solid #ccc;
            }

            .ss_dialog .t_content .t_message .message_con tr td.ck input {
                border-radius: 3px;
                padding-right: 5px;
            }

            .ss_dialog .t_content .t_message .message_con tr td.ku select {
                border-radius: 3px;
                line-height: 28px;
                height: 28px;
                border: 1px solid #ccc;
                color: #666;
                min-width: 98px;
            }

                .ss_dialog .t_content .t_message .message_con tr td.ku select option {
                    color: #666;
                    line-height: 28px;
                    height: 28px;
                }

            .ss_dialog .t_content .t_message .message_con tr td.ck input.select {
                background-color: #5493d7;
                color: #fff;
            }
        /*按钮  下一步*/
        .ss_dialog .t_content .t_btn {
            text-align: center;
            padding: 10px 0;
        }

            .ss_dialog .t_content .t_btn input {
                background-color: #5493d7;
                width: 80px;
                color: #fff;
                border: none;
                border-radius: 3px;
                margin-right: 10px;
                font-size: 14px;
                font-family: "微软雅黑";
                background: #96cc66;
                cursor: pointer;
            }

                .ss_dialog .t_content .t_btn input:hover {
                    background: #87c352;
                    outline: none;
                }
        /*完成finish*/
        .finish {
            width: 206px;
            overflow: hidden;
            text-align: center;
            margin: auto;
        }

            .finish span.icon_f i.finish_t {
                color: #96cc66;
                font-size: 50px;
                line-height: 300px;
            }

            .finish span.info_f {
                font-size: 20px;
                font-size: 18px;
                line-height: 300px;
            }


        .nextbtn {
            text-align: center;
        }

        .BulletinManager {
            padding: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="ID" />
        <div class="ss_dialog">
            <div class="t_content">
                <!---选项卡-->
                <div class="ss_tab">
                    <div class="yy_tabheader">
                        <ul>
                            <li class="selected"><a href="#"><span class="zong_tit"><span class="num_1">1</span><span class="add_li">食堂信息</span></span></a></li>
                            <li><a href="#"><span class="zong_tit"><span class="num_2">2</span><span class="add_li">基本项数据</span></span></a></li>
                            <li><a href="#"><span class="zong_tit"><span class="iconfont num_3">&#xe61d;</span><span class="add_li">完成</span></span></a></li>
                        </ul>
                    </div>
                    <div class="content">
                        <div class="tc" style="display: block;">
                            <div class="t_message">
                                <div class="message_con">

                                    <table class="m_top">
                                        <tbody>
                                            <tr>
                                                <td class="mi"><span class="m">*食堂名称：</span></td>
                                                <td class="ku">
                                                    <input type="text" id="Name" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mi"><span class="m">*营业时间：</span></td>
                                                <td class="ku">
                                                    <input name="Wdate" style="width: 75px" class="Wdate" id="BeginTime" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',maxDate:date})" type="text" value="">
                                                    -
                                                    <input name="Wdate" style="width: 75px" class="Wdate" id="EndTime" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',maxDate:date})" type="text" value="">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mi"><span class="m">食堂图片：</span></td>
                                                <td class="ku">
                                                    <input id="File1" type="file" />
                                                    <img id="img_Pic" style="width: 100px; height: 100px;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mi"><span class="m">地址：</span></td>
                                                <td class="ku">
                                                    <input type="text" value="" id="AddressMsg" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table class="c_line">
                                        <tbody>
                                            <tr></tr>
                                        </tbody>
                                    </table>
                                    <table class="m_top">
                                        <tbody>
                                            <tr>
                                                <td class="mi"><span class="m">公告：</span></td>
                                                <td class="ku">
                                                    <textarea rows="3" cols="30" id="Notice"></textarea>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                            <div class="t_btn">

                                <input type="button" value="保存" onclick="SaveBase()" />
                                <input onclick="nextstep();" type="button" value="下一步" />
                            </div>
                        </div>
                        <div class="tc" style="display: none;">
                            <div class="t_message">
                                <div class="message_con">

                                    <table class="tbEdit">
                                        <tbody>
                                            <tr>
                                                <td class="mi"><span class="m">早餐下单截止时间：</span></td>
                                                <td class="ku">
                                                    <input name="Wdate" class="Wdate" id="endTime1" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',maxDate:date})" type="text" value="">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mi"><span class="m">午餐下单截止时间：</span></td>
                                                <td class="ku">
                                                    <input name="Wdate" class="Wdate" id="endTime2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',maxDate:date})" type="text" value="">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="mi"><span class="m">晚餐下单截止时间：</span></td>
                                                <td class="ku">
                                                    <input name="Wdate" class="Wdate" id="endTime3" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',maxDate:date})" type="text" value="">
                                                </td>

                                            </tr>

                                        </tbody>
                                    </table>

                                </div>

                            </div>
                            <div class="t_btn">
                                <input onclick="lastep();" type="button" value="上一步" />

                                <input type="submit" value="保存" onclick="SaveTime()"/>
                            </div>
                        </div>
                        <div class="tc" id="success" style="display: none;">
                            <p class="finish">
                                <span class="fl icon_f"><i class="iconfont finish_t"></i></span>
                                <span class="fr info_f">您已成功维护信息</span>
                            </p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            $(".yy_tabheader").find("a").click(function () {
                var index = $(this).parent().index();
                $(this).parent().addClass("selected").siblings().removeClass("selected");
                $(".content").find(".tc").eq(index).show().siblings().hide();
            });
            GetData();
        })
        function nextstep() {
            //SaveBase();
            $(".yy_tabheader").find("li").eq(1).addClass("selected").siblings().removeClass("selected");
            $(".content").find(".tc").eq(1).show().siblings().hide();
        }
        function lastep() {
            $(".yy_tabheader").find("li").eq(0).addClass("selected").siblings().removeClass("selected");
            $(".content").find(".tc").eq(0).show().siblings().hide();
        }
        //添加数据
        function SaveBase() {

            var Name = $("#Name").val().trim();
            var AddressMsg = $("#AddressMsg").val();//.children('span').attr("value").trim();
            var Notice = $("#Description").val();
            var Photo = $("#img_Pic").attr("src");
            var BeginTime = $("#BeginTime").val();
            var EndTime = $("#EndTime").val();

            if (!Name || !BeginTime || !EndTime || !AddressMsg) {
                layer.msg("请输入食堂名称、地址、营业时间！");
            }
            else {
                $.ajax({
                    url: "../Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "CanteenReservation/BaseSit.ashx",
                        func: "Add", Name: Name, AddressMsg: AddressMsg, Notice: Notice, Photo: Photo, BeginTime: BeginTime, EndTime: EndTime, ID: $("#ID").val()
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            parent.layer.msg('操作成功!');
                            parent.GetBase();
                            parent.CloseIFrameWindow();
                        } else {
                            layer.msg(result.errMsg);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.msg("操作失败！");
                    }
                });
            }
        }
        //绑定数据
        function GetData() {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CanteenReservation/BaseSit.ashx", "Func": "GetCanteeData" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#ID").val(this.ID);
                            $("#Name").val(this.Name);
                            $("#AddressMsg").val(this.AddressMsg);//.children('span').attr("value", this.CourceType)
                            $("#img_Pic").attr("src", this.Photo);
                            $("#Notice").val(this.Notice);
                            $("#BeginTime").val(this.BeginTime);
                            $("#EndTime").val(this.EndTime);
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


    </script>
</body>
</html>


