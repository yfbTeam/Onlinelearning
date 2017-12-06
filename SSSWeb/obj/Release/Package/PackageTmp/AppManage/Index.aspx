<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SSSWeb.AppManage.Index" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>我的桌面</title>
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" type="text/css" href="css/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script src="Scripts/jquery-1.8.3.min.js"></script>
    <script src="Scripts/layer/layer.js"></script>
    <script src="Scripts/common.js"></script>
    <script type="text/javascript">
        $(function () {
            //退出
            $('.setting').hover(function () {
                $(this).find('.setting_none').show();
            }, function () {
                $(this).find('.setting_none').hide();
            })
        })
    </script>
    <style>
        .app_lists {
            background: rgba(255,255,255,.7);
            border-top: 1px solid #dcdcdc;
            border-left: 1px solid #dcdcdc;
            width: 1200px;
            margin: 20px auto 0 auto;
        }

            .app_lists a {
                width: 33.3%;
                height: 150px;
                border-right: 1px solid #dcdcdc;
                border-bottom: 1px solid #dcdcdc;
                display: block;
                float: left;
                box-sizing: border-box;
                padding: 30px 50px;
            }

                .app_lists a p {
                    line-height: 90px;
                    margin-left: 30px;
                    font-size: 18px;
                    color: #333;
                    width: 178px;
                }

        .icon {
            width: 90px;
            height: 90px;
            border-radius: 10px;
            display: block;
            float: left;
        }

            .icon i {
                width: 60px;
                height: 60px;
                margin: 15px;
                display: block;
                font-size: 50px;
                line-height: 60px;
                text-align: center;
                color: #fff;
            }
    </style>
</head>
<body>
    <input type="hidden" id="IDCard" value="<%=UserInfo.IDCard %>" />
    <input type="hidden" id="CatagoryID" value="" />
    <div id="container">
        <div id="header">
            <div class="logo fl">
                <img src="/AppManage/images/logo.png" style="height: 32px;" />
            </div>
            <div class="mydesktop fl">
                <a href="javascript::">
                    <i class="iconfont icon-home"></i>
                    <span>我的桌面</span>
                </a>
            </div>
            <div class="user_setting fr clearfix mr20">
                <div class="replace_bg fl" onclick="openSkin()">
                    <img src="/AppManage/images/huanfu.png" alt="Alternate Text" />
                </div>
                <div class="fl user_img">
                    <img src="<%=UserInfo.AbsHeadPic %>" />
                </div>
                <div class="user_name fl">
                    <%=UserInfo.Nickname %>
                </div>
                <div class="setting fl pr">

                    <a href="javascript:;">
                        <i class="iconfont icon-settings"></i>
                    </a>
                    <div class="setting_none">
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
        <div id="main">
            <div class="modult">
                <h1 class="title" id="title">
                    <%--  <span class="active">
                        基础平台
                    </span>
                    <span>
                        基础平台
                    </span>--%>
                </h1>
            </div>
            <div class="app_lists clearfix" id="module">
                <%-- <a href="" class="clearfix">
                    <div class="icon bgred">
                        <i class="iconfont icon-xuexi"></i>
                    </div>
                    <p class="fl">课程管理</p>
                </a>--%>
            </div>
        </div>
        <div id="footer">
            <p>咨询电话: 010-83068508</p>
            <p> 地址: 北京市丰台区南四环西路128号诺德中心3座7层</p>
        </div>
    </div>
    <script>
        $(function () {
            CatoryModel();
            getData();
            InitSkin();
        })

        function CatogyClick(em, ID) {
            $(em).addClass("active").siblings().removeClass("active");
            $("#CatagoryID").val(ID);
            getData();
        }
        function CatoryModel() {
            //$("#title").html("");
            $.ajax({
                url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "/DeskManage/AppHandler.ashx", "Func": "ModelCatogory" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var i = 0;
                        $(json.result.retData).each(function () {
                            var html = "";
                            if (i == "0") {
                                var modultID = "modult" + this.ID;
                                html = "<span class=\"active\" id=" + modultID + " onclick='CatogyClick(this," + this.ID + ")\'>" + this.Name + "</span>";
                                $("#title").append(html);
                                $("#CatagoryID").val(this.ID);
                                i++;
                            }
                            else {
                                var modultID = "modult" + this.ID;
                                html = "<span  id=" + modultID + " onclick='CatogyClick(this," + this.ID + ")\'>" + this.Name + "</span>";

                                //html = "<span id=" + modultID + ">" + this.Name + "</span>";
                                $("#title").append(html);
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
        function InitSkin() {
            $.ajax({
                url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "UserID": $("#IDCard").val(), "Func": "Skin"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        //$('#bgcolor').attr('src', json.result.retData)

                        document.getElementById("container").style.background = "url(" + json.result.retData + ") no-repeat center top fixed";
                        //CloseIFrameWindow();
                    }
                    else {
                        layer.msg("皮肤更新失败");
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function UpdateSkin(ImageUrl) {

            $.ajax({
                url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "UserID": $("#IDCard").val(), "Func": "AddSkin", "SkinImage": ImageUrl
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        //$('#bgcolor').attr('src', json.result.retData)
                        document.getElementById("container").style.background = "url(" + ImageUrl + ") no-repeat center top fixed;background-size:100%;";
                        CloseIFrameWindow();
                    }
                    else {
                        layer.msg("皮肤更新失败");
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });

        }
        function ViewSkin(ImageUrl) {
            //$('#bgcolor').attr('src', ImageUrl)

            document.getElementById("container").style.background = "url(" + ImageUrl + ") no-repeat center top fixed";
        }
        function CancelSkin() {
            InitSkin();
        }
        function AddApp() {
            OpenIFrameWindow('模块添加', 'DeskModel.aspx', '800px', '650px');
        }
        function openSkin() {
            OpenIFrameWindow('选择皮肤', 'Skin.aspx', '700px', '680px');
        }
        //获取数据
        function getData() {
            $("#main").html("");
            $.ajax({
                url: "/Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "IDCard": $("#IDCard").val(), "Func": "GetModelList", Ispage: "false", IsShow: "in"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var RowCount = json.result.retData.length;
                        var i = 0;
                        $(json.result.retData).each(function () {
                            var li = '<a href="' + this.LinkUrl + '" class="clearfix" target="' + this.OpenType +
                                '"><div class="icon"	style="background: ' + this.ModelCss + '"><i class="iconfont icon-' + this.iconCss + '"></i></div><p class="fl">' + this.ModelName + '</p></a>';
                            var modultID = "modult" + this.CatogryID;
                            var len = $("#main").find("#" + modultID).length;
                            var html = '<div class="modult" id="' + modultID + '"><h1 class="title"><span>' + this.CatogryName + '</span></h1><div class="apps_wrap clearfix"><div class="apps clearfix"></div></div></div>';
                            if (len == 0) {
                                $("#main").append(html);
                            }
                            $("#" + modultID).find(".apps").append('<a href="' + this.LinkUrl + '" style="background:' + this.ModelCss + '" target="' + this.OpenType + '"><i class="iconfont icon-' + this.iconCss + '"></i><p>' + this.ModelName + '</p></a>');
                            i++;
                            if (i == RowCount) {
                                $("#" + modultID).find(".apps").append('<div class="add fl" onclick="AddApp()"><i class="iconfont icon-add"></i></div>');
                            }
                        })
                    }
                    else {
                        $("#main").html('<div class="modult" id=""><h1 class="title"><span>无分类</span></h1><div class="apps_wrap clearfix"><div class="apps clearfix"><div class="add fl" onclick="AddApp()"><i class="iconfont icon-add"></i></div></div></div></div>');

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
