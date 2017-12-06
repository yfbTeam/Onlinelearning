<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CameraControl.aspx.cs" Inherits="SSSWeb.CameraControl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>在线学习</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <link rel="stylesheet" type="text/css" href="css/repository.css" />
    <link rel="stylesheet" type="text/css" href="css/onlinetest.css" />
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <style>
        .myexam{padding:20px;}
        .camera_right{width:320px;border-radius:3px;}
        .camera_right ul li{
            border: 2px solid #C2C2C2;margin:10px 20px;
           border-radius:3px;
            padding:20px;cursor:pointer;overflow:hidden;position:relative;
        }
        .camera_right ul li img{width:130px;}
        .camera_right ul li span{
            margin-left:20px;line-height:100px;color:#555;font-size:22px;
        }
        .camera_left{
            width:810px;height:498px;background:black;
        }
        .camera_right ul li:hover{
            border:2px solid #75CE66;
        }
        .camera_right ul li:hover div{
            display:block;
        }
        .camera_right ul li.active{
            border:2px solid #75CE66;
        }
        .camera_right ul li.active div{
            display:block;
        }
         .camera_right ul li div{
             width:40px;height:40px;background:#75CE66;border-radius:50%;position:absolute;right:-20px;bottom:-20px;display:none;
         }
         .camera_right ul li div .icon{
             width:25px;line-height:25px;
         }
         .camera_control{
             padding:20px;margin-top:20px;
         }
         #btn{
             width:411px;margin:0 auto;
         }
        .control{
           position:relative;width:244px;
        }
        .control div{padding:15px 0px;height:60px;}
        .control .text{
            border:none;border:1px solid #C2C2C2;border-radius:2px;width:85px;height:30px;color:#666;margin:12px;
        }
        .control .btncoontrol{width:60px;height:60px;background:url(images/control.png) no-repeat;background-size:160px 134px ;display:block;}
        #up{
            background-position: -15px -4px;
        }
        #down{
            background-position: -85px -4px;
        }
         #left{
            background-position: -15px -68px;
        }
        #right{
            background-position: -85px -68px;
        }
        .mc{
            margin:0 auto;
        }
        .controlbtn *{
           margin:15px 0px 30px 15px;
        }
        .switchbtn{
            width:152px;background:url(/images/close.png) no-repeat;background-size:cover;height:60px;display:block;
        }
        .switchbtn.active{
            background:url(/images/open.png) no-repeat;background-size:cover;
        }
        .zoom{width:152px;height:60px;display:block;font-size:18px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="AppManage/Index.aspx">
                    <img src="images/logo.png" /></a>
                <%--<div class="wenzi_tips fl">
                    <img src="images/zaixianxuexi.png" />
                </div>--%>
                <div class="search_account fr clearfix">
                    <ul class="account_area fl">
                        <li>
                            <a class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=UserInfo.AbsHeadPic%>" />
                                </div>
                                <h2><%=UserInfo.Name%></h2>
                            </a>
                        </li>
                    </ul>

                    <div class="settings fl pr">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="myexam bordshadrad">
                <div class="camera_top clearfix">
                    <div class="camera_left fl bordshadrad">

                    </div>
                    <div class="camera_right fr bordshadrad">
                        <ul>
                            <li class="clearfix active">
                                <img src="images/camera.png" alt="Alternate Text" class="fl"/>
                                <span>摄像机1</span>
                                <div>
                                    <i class="icon icon-ok"></i>
                                </div>
                            </li>
                            <li class="clearfix">
                                <img src="images/camera.png" alt="Alternate Text" class="fl"/>
                                <span>摄像机2</span>
                                <div>
                                    <i class="icon icon-ok"></i>
                                </div>
                            </li>
                            <li class="clearfix">
                                <img src="images/camera.png" alt="Alternate Text" class="fl"/>
                                <span>摄像机3</span>
                                <div>
                                    <i class="icon icon-ok"></i>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="camera_control bordshadrad">
                    <div id="btn" class="clearfix">
                        <div class="control fl">
                            <div>
                                <a href="javascript:;" class="btncoontrol mc" id="up"></a>
                            </div>
                            <div class="clearfix">
                                <a href="javascript:;" class="btncoontrol fl" id="left"></a>
                                <input type="text" name="name"  placeholder="请输入角度" class="text fl"  />
                                <a href="javascript:;" class="btncoontrol fl" id="right"></a>
                            </div>
                            <div>
                                 <a href="javascript:;" class="btncoontrol mc" id="down"></a>
                            </div>
                        </div>
                        <div class="controlbtn fl">
                            <a href="javascript:;" class="switchbtn" id="switchbtn"></a>
                            <input type="button" name="name" value="增加焦距"  id="zoomin" class="zoom "/>
                            <input type="button" name="name" value="缩小焦距"  id="zoomout" class="zoom"/>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
        <footer id="footer"></footer>
        <script type="text/javascript" src="js/common.js"></script>
        <script>
            $(function () {
                $('#footer').load('footer.html');
                $('.camera_right ul li').click(function () {
                    $(this).addClass('active').siblings().removeClass('active');
                });
                $('#switchbtn').click(function () {
                    if($(this).hasClass('active')){
                        $(this).removeClass('active');
                    } else {
                        $(this).addClass('active');
                    }
                   
                })
            })
        </script>
    </div>
    </form>
</body>
</html>
