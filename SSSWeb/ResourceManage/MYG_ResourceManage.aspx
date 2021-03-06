﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MYG_ResourceManage.aspx.cs" Inherits="SSSWeb.ResourceManage.MYG_ResourceManage" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>资源中心</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/sprite.css" rel="stylesheet" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <%--<script src="../Scripts/Pager.js"></script>--%>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
    <script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="checkbox fl">
                <input type='checkbox' value='${ID}' class='Check_box' name='Check_box' id='subcheck'  />
            </div>
            <div class="docu_messages fl">
                <p class="docu_title">
                    <span class="ico-${postfix1}-min h-ico" onclick="FolderClick(${ID},'${FileUrl}','${code}',${IsFolder},'${CheckUsers}')">
                        <%--<img style="width:100%;height:auto;" />--%></span>
                    <span class="docu_name" href="javascript:;" onclick="FolderClick(${ID},'${FileUrl}','${code}',${IsFolder},'${CheckUsers}')" title="${Name}">${cutstr(Name,30)}</span>
                </p>
            </div>
            <div class="unload_none fl">
                <span class="upload"  btncls="icon-Download" style="display:none;" >
                    <i class="icon icon-download-alt" onclick="Down(${ID})" title="下载"></i>
                </span>
                <span class="arrow-down pr">
                    <i class="icon" title="更多">
                        <img src="../images/xai.png" /></i>
                    <div class="arrow_downwrap">
                        <span style="display:none;" onclick="SetCheckUser(${ID},'${CheckUsers}')"  btncls="icon-CheckUser">审核人</span>
                        <span onclick="Move(${ID})" style="display:none;"  btncls="icon-Remove">移动到</span>
                        <span class="rename" style="display:none;"  onclick="cl(this,${ID},'${Name}','${FileUrl}')"  btncls="icon-ReName">重命名</span>
                        <span class="delete" style="display:none;"  onclick="Del(${ID},'${Name}')"  btncls="icon-del">删除</span>
                    </div>
                </span>
            </div>
            <div style="left: 56%" class="skydrive_size fl">
                {{if Status==0}}待审核
            {{else}}{{if Status==2}}审核失败
            {{else}}审核通过
            {{/if}}{{/if}}
            </div>
            <div class="skydrive_size fl" style="left: 67%">
                {{if CheckMessage==""}}--                       
                        {{else}}
                            ${CheckMessage}
                        {{/if}}
            </div>
            <div class="skydrive_size fl" style="left: 77%">
                <span>{{if FileSize==0}}--
                        {{else FileSize>1024*1024}}
                            ${(FileSize/1024/1024).toFixed(2)}MB
                        {{else}}
                            ${(FileSize/1024).toFixed(2)}KB
                        {{/if}}
                   
                </span>
            </div>
            <div class="date fr">
                <span>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</span>
            </div>
        </li>


    </script>
    <script id="tr_User1" type="text/x-jquery-tmpl">
        <li>
            <div class="checkbox">
                <input type='checkbox' value='${ID}' class='Check_box' name='Check_box'  />
            </div>
            <div class="skydrive_grid_view">
                <a href="#" onclick="FolderClick(${ID},'${FileUrl}','${code}',${IsFolder},'${CheckUsers}')">
                    <em class="ico-${postfix1}-max a-ico-file">
                        <img style="width: 100%; height: auto;" /></em>
                    <p class="grid_view_name" title="${Name}">${cutstr(Name,12)}</p>
                </a>
            </div>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input type="hidden" id="HUserIdCard" runat="server" />
            <input type="hidden" id="HUserName" runat="server" />
            <input type="hidden" id="HClassID" runat="server" />
            <input type="hidden" id="HIcons" runat="server" />
            <input id="Pid" type="hidden" value="0" />
            <input id="code" type="hidden" value="0" />
            <input id="HFoldUrl" type="hidden" value="/OpenFile" />
            <input id="ShowType" type="hidden" value="1" />
            <input id="GroupName" type="hidden" value="" />
            <input id="Postfixs" type="hidden" value="" />
            <input id="TimeQuery" type="hidden" value="" />
            <!--header-->
            <header class="repository_header_wrap">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="../AppManage/Index.aspx">
                        <img src="../images/logo.png" /></a>
                    <div class="wenzi_tips fl">
                        <img src="../images/ziyuanzhongxin.png" />
                    </div>
                    <div class="search_account fr clearfix">
                        <%--<div class="search fl">
                            <i class="icon  icon-search"></i>
                            <input type="text" name="" id="search_w" placeholder="请输入关键字" />
                        </div>--%>
                        <ul class="account_area fl">

                            <li>
                                <a href="javascript:;" class="login_area clearfix">
                                    <div class="avatar">
                                        <img src="<%=UserInfo.AbsHeadPic%>" />
                                    </div>
                                    <h2><%=UserInfo.Name%>
                                    </h2>
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
            <!--网盘-->
            <div class="skydrive width bordshadrad">
                <div class="modult_toolsbar clearfix">
                    <div class="list_grid_switch fr">
                        <a href="javascript:;" class="list_switch on">
                            <i class="icon icon-th-list" onclick="ShowType(1)"></i>
                        </a>
                        <a href="javascript:;" class="grid_switch">
                            <i class="icon  icon-th-large" onclick="ShowType(2)"></i>
                        </a>
                    </div>

                    <!--工具条-->
                    <div class="toolsbar fl">
                        <div class="bars">
                            <a href="#" class="upload pr">
                                <i class="icon  icon-upload-alt"></i>
                                <span class="txt" onclick="upload()">上传文件</span>
                            </a>
                            <a href="#" class="newfile" style="display:none;" btncls="icon-NewFolder">                               
                                <span class="txt"onclick="javascript: appendAfterRow('1')"> <i class="icon icon-folder-close-alt"></i>新建文件夹</span>
                            </a>
                            <a href="javascript:;" class="operate pr">
                                <i class="icon  icon-wrench"></i>
                                <span class="txt">批量操作</span>
                                <div class="operate_wrap">
                                    <span onclick="Del('','')" style="display:none;" btncls="icon-del">删除</span>
                                    <span onclick="Move('','')" style="display:none;" btncls="icon-Remove">移动</span>
                                    <span onclick="Down('','')" style="display:none;" btncls="icon-Download">下载</span>
                                    <%--<span>共享</span>--%>
                                </div>
                            </a>

                        </div>

                    </div>
                </div>
                <div class="selectionwrap">
                    <div class="select_nav clearfix pr">
                        <div class="select_nav_left fl">
                            文件类型:
                        </div>
                        <ul class="select_nav_right clearfix" id="ResourceType">
                            <li class="on">
                                <a href="#" onclick="serchType('',this)">不限</a>
                            </li>

                        </ul>
                    </div>
                    <div class="select_nav clearfix pr">
                        <div class="select_nav_left fl">
                            上传时间
                        </div>
                        <ul class="select_nav_right">
                            <li class="on">
                                <a href="#" onclick="SerchTime('',this)">不限</a>
                            </li>
                            <li>
                                <a href="#" onclick="SerchTime('Week',this)">一周内</a>
                            </li>
                            <li>
                                <a href="#" onclick="SerchTime('Month',this)">一月内</a>
                            </li>
                            <li>
                                <a href="#" onclick="SerchTime('Year',this)">半年内</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!--docu-->
                <div class="docu_wrap">

                    <!--面包屑-->
                    <div class="crumbs" id="Nav">
                        <a href="#" onclick="FolderClick(0, '\DriveFolder', 0,1,'')">全部</a>
                    </div>
                    <div class="docu_content">
                        <!--docu_list-->
                        <div class="IsCheckAll">
                            <div class="clearfix" style="padding: 10px; border-top: 1px dotted #CFCFCF;">
                                <div class="checkbox fl" style="margin-left: 1px;">
                                    <input type="checkbox" name="" id="checkAll" value="" style="width: 18px; height: 18px; border: 1px solid rgba(0,0,0,.2); border-radius: 2px; background: #fff;" />
                                </div>
                                <div class="docu_messages fl">
                                    <p class="docu_title" style="height: 24px; font-size: 15px; color: #555555; line-height: 24px; padding-left: 12px;">
                                        文件名
                                    </p>
                                </div>
                                <div class="bars none" style="margin: 5px 0px 0px 100px;">
                                    <a href="#" class="newfile" btncls="icon-del" style="display:none;">
                                        <i class="icon icon-trash"></i>
                                        <span class="txt" onclick="Del('','')" >删除</span>
                                    </a>
                                    <a href="#" class="upload pr"  btncls="icon-Download" style="display:none;" >
                                        <i class="icon  icon-download-alt"></i>
                                        <span class="txt" onclick="Down('','')">下载</span>
                                    </a>

                                    <a href="#" class="newfile" btncls="icon-Remove" style="display:none;">
                                        <span class="txt" onclick="Move('','')">移动</span>
                                    </a>
                                    <%--<a href="#" class="newfile">
                                        <span class="txt">移动到</span>
                                    </a>--%>
                                </div>
                                <div class="skydrive_size fl" style="left: 57%"><span style="font-size: 15px;">状态</span></div>
                                <div class="skydrive_size fl" style="left: 65%"><span style="font-size: 15px;">说明</span></div>
                                <div class="skydrive_size fl" style="left: 75%">
                                    <span style="font-size: 15px;">大小</span>
                                </div>
                                <div class="datea fr" style="line-height: 23px; margin-right: 15px;">
                                    <span style="font-size: 15px; color: #999999">修改时间</span>
                                </div>
                            </div>
                            <ul class="document_list skydrive_docu_list" style="display: block; min-height: 545px;" id="tb_MyResource">
                            </ul>
                        </div>
                        <div class="none IsCheckAlla">
                            <div class="clearfix" style="padding: 10px; border-top: 1px dotted #CFCFCF;">
                                <div class="checkbox fl" style="margin-left: 1px;">
                                    <input type="checkbox" name="" id="checkAll" value="" style="width: 18px; height: 18px; border: 1px solid rgba(0,0,0,.2); border-radius: 2px; background: #fff;" />
                                </div>
                                <div class="docu_messages fl">
                                    <p class="docu_title" style="height: 24px; font-size: 15px; color: #555555; line-height: 24px; padding-left: 12px;">
                                        文件名
                                    </p>
                                </div>
                                <div class="bars none" style="margin: 5px 0px 0px 100px;">
                                    <a href="#" class="newfile" btncls="icon-del" style="display:none;">
                                        <i class="icon icon-trash"></i>
                                        <span class="txt" onclick="Del('','')" >删除</span>
                                    </a>
                                    <a href="#" class="upload pr"  btncls="icon-Download" style="display:none;">
                                        <i class="icon  icon-download-alt"></i>
                                        <span class="txt" onclick="Down('','')">下载</span>
                                    </a>

                                    <a href="#" class="newfile" btncls="icon-Remove" style="display:none;">
                                        <span class="txt" onclick="Move('','')">移动</span>
                                    </a>
                                </div>
                            </div>
                            <ul class="skydrive_grid_list clearfix" id="tb_MyResource1" style="min-height: 545px;">
                            </ul>
                        </div>
                    </div>
                </div>
                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                </div>
            </div>
            <footer id="footer"></footer>
            <script type="text/javascript" src="../js/common.js"></script>
            <script type="text/javascript" src="../js/repository.js"></script>

        </div>
    </form>
</body>


<script type="text/javascript">
    $(document).ready(function () {
        SetPageButton('<%=UserInfo.UniqueNo%>',"span",'a')
        $('#footer').load('../footer.html');
        //列表页与图标页切换
        $('.list_grid_switch').find('a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            $('.docu_content>div').eq(n).show().siblings().hide();
        })
        GetFileType()
        //获取数据
        getData(1, 10);
    });
    //指定审核人
    function SetCheckUser(ID, CheckUsers) {
        OpenIFrameWindow('设置审核人', 'SetCheckUser.aspx?ID=' + ID + "&CheckUsers=" + CheckUsers, '450px', '200px;');


    }
    //获取数据
    function ShowType(Type) {
        if (Type == "1") {
            $('.IsCheckAll .bars').hide();
            $('.IsCheckAlla .bars').hide();
            $("#ShowType").val("1");
            getData(1, 10);
        }
        if (Type == "2") {
            $('.IsCheckAll .bars').hide();
            $('.IsCheckAlla .bars').hide();
            $("#ShowType").val("2");
            getData(1, 16);
        }
    }

    //获取数据
    function getData(startIndex, pageSize) {
        $('.IsCheckAll .bars').hide();
        $('.IsCheckAlla .bars').hide();
        $("#checkAll").attr("checked", false);

        var Pid = $("#Pid").val();
        var DocName = $("#search_w").val();
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        var CreateUID = $("#HUserIdCard").val();
        //name = name || '';
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "ResourceManage/ResourceInfoHander.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, CreateUID: CreateUID, "Pid": Pid, "DocName": DocName, "Postfixs": $("#Postfixs").val(), "CreateTime": $("#TimeQuery").val() },
            success: function OnSuccess(json) {
                var ShowType = $("#ShowType").val();

                if (json.result.errNum.toString() == "0") {
                    if (ShowType == "1") {
                        $("#tb_MyResource").html('');
                        $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_MyResource");
                    }
                    else {
                        $("#tb_MyResource1").html('');
                        $("#tr_User1").tmpl(json.result.retData.PagedData).appendTo("#tb_MyResource1");
                    }
                    $(".page").show();
                    //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);

                    hoverShow($('.document_list li'), $('.unload_none'));
                    hoverShow($('.skydrive_grid_list li'), $('.checkbox'));
                    //全选
                    CheckAlla($('.IsCheckAll input[type=checkbox]'));
                    CheckAllb($('.IsCheckAlla input[type=checkbox]'));
                    SetPageButton('<%=UserInfo.UniqueNo%>', "span")

                }
                else {
                    var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
                    if (ShowType == "1") {
                        $("#tb_MyResource").html(html);
                    }
                    else {
                        $("#tb_MyResource1").html(html);
                    }
                    $(".page").hide();
                }
            },
            error: OnError
        });
    }
    function CheckAlla(oInput) {
        var isCheckAll = function () {
            for (var i = 1, n = 0; i < oInput.length; i++) {
                oInput[i].checked && n++
            }
            oInput[0].checked = n == oInput.length - 1;
        };
        //全选
        oInput[0].onchange = function () {
            for (var i = 1; i < oInput.length; i++) {
                oInput[i].checked = this.checked;
                tabshow();
                listselect();
            }
            isCheckAll()
        };
        //根据复选个数更新全选框状态
        for (var i = 1; i < oInput.length; i++) {
            oInput[i].onchange = function () {
                isCheckAll()
                tabshow();
            }
        }
        var listselect = function () {
            if (oInput.eq(0).is(':checked')) {
                $('.document_list li').addClass('active');
                $('.document_list li .unload_none').show();
            } else {
                $('.document_list li').removeClass('active');
                $('.document_list li .unload_none').hide();
            }

        }
        var tabshow = function () {
            if (oInput.is(':checked')) {
                $('.IsCheckAll .skydrive_size,.IsCheckAll .datea').hide();
                $('.IsCheckAll .bars').show();
            } else {
                $('.IsCheckAll .skydrive_size,.IsCheckAll .datea').show();
                $('.IsCheckAll .bars').hide();
            }
        }
    }
    function CheckAllb(oInput) {
        var isCheckAll = function () {
            for (var i = 1, n = 0; i < oInput.length; i++) {
                oInput[i].checked && n++
            }
            oInput[0].checked = n == oInput.length - 1;
        };
        //全选
        oInput[0].onchange = function () {
            for (var i = 1; i < oInput.length; i++) {
                oInput[i].checked = this.checked;
                tabshow();
                listselect();
            }
            isCheckAll()
        };

        //根据复选个数更新全选框状态
        for (var i = 1; i < oInput.length; i++) {
            oInput[i].onchange = function () {
                isCheckAll();
                tabshow();
            }
        }
        var listselect = function () {
            if (oInput.eq(0).is(':checked')) {
                $('.skydrive_grid_list li').addClass('active');
                $('.skydrive_grid_list li .unload_none,.skydrive_grid_list li .checkbox').show();
            } else {
                $('.skydrive_grid_list li').removeClass('active');
                $('.skydrive_grid_list li .unload_none,.skydrive_grid_list li .checkbox').hide();
            }

        }
        var tabshow = function () {
            if (oInput.is(':checked')) {
                $('.IsCheckAlla .bars').show();
            } else {
                $('.IsCheckAlla .bars').hide();
            }
        }
    }
    function hoverShow(hoverObj, showObj) {
        showObj.find('.arrow-down').click(function () {
            $(this).find('.arrow_downwrap').show();
        });
        hoverObj.find('input[type=checkbox]').click(function () {
            if ($(this).is(':checked')) {
                $(this).parents('li').addClass('active');
            } else {
                $(this).parents('li').removeClass('active');
            }
        });
        hoverObj.hover(function () {
            $(this).find(showObj).show();
        }, function () {
            $(this).find(showObj).hide();
            showObj.find('.arrow_downwrap').hide();
            if ($(this).find('input[type=checkbox]').is(':checked')) {
                $(this).find(showObj).show();
            }
        })
    }

    function OnError(XMLHttpRequest, textStatus, errorThrown) {
        var htmlBq = '<li style="text-align:center">' + json.result.errMsg.toString() + '</li>';
        if (ShowType == "1") {
            $("#tb_MyResource").html(htmlBq);
        }
        else { $("#tb_MyResource1").html(htmlBq); }
        //$("#tb_MyResource").html('无内容');
    }
    //绑定文件类型
    function GetFileType() {
        $.ajax({
            type: "Post",
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            data: { "PageName": "ResourceManage/PublicResoure.ashx", Func: "ResourceType" },
            dataType: "json",
            success: function (returnVal) {

                //var PagedData = $.parseJSON(returnVal.result.retData);

                $(returnVal.result.retData).each(function () {
                    var result = "<li><a href='#' onclick=\"serchType('" + this.ID + "',this)\">" + this.Name + "</a>";
                    $("#ResourceType").append(result);
                });
            },
            error: function (errMsg) {
                layer.msg('数据加载失败！');
            }
        });
    }
    function CheckAll(flag) {
    }
    //面包屑
    function BindNav() {
        var Pid = $("#Pid").val();
        var CreateUID = $("#HUserIdCard").val();
        $("#Nav").html("<a href=\"#\" onclick=\"FolderClick(0, '\DriveFolder', 0,1,'')\">全部</a>");
        $.ajax({
            type: "Post",
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            data: { "PageName": "ResourceManage/ResourceInfoHander.ashx", Func: "BindNav", Pid: Pid, CreateUID: CreateUID },
            dataType: "json",
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        var result = "<span>></span><a href=\"#\" onclick=\"FolderClick(" + this.ID + ",'" + this.FileUrl + "', " + this.code + "," + this.IsFolder + ",'" + this.CheckUsers + "')\">" + this.Name + "</a>";
                        $("#Nav").append(result);
                    });
                }
            },
            error: function (errMsg) {
                layer.msg('数据加载失败！');
            }
        });
    }

    function Down(id) {
        var ids = "";
        if (id != "") {
            ids = id;
        }
        else {
            $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    ids += this.value + ",";
                }
            });
        }
        if (ids != "") {

            $.ajax({
                url: "../ResourceManage/ResourceInfoHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceManage/ResourceInfoHander.ashx", "Func": "Down", DownID: ids },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        window.open(json.result.retData);
                    }
                    else { layer.msg('下载失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('下载失败！');
                }
            });
        }
        else {
            layer.msg("请选择要下载的文件");
        }
    }


    function Move(id) {
        var ids = "";
        var pid = $("#Pid").val();
        var Pcode = $("#code").val();
        if (id != "") {
            ids = id;
        }
        else {
            var ids = "";
            $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    ids += this.value + ",";
                }
            });
        }
        if (ids == "") {
            layer.msg("请选择要移动的文件");
        }
        else {
            OpenIFrameWindow('文件移动', 'ResourceContent.aspx?Pid=' + pid + "&code=" + Pcode + "&id=" + id + "&random=" + Math.random(), '450px', '300px;');
        }
    }
    function MoveMore(url, pid, code, id) {
        var ids = "";

        if (id != "") {
            ids = id;
        }
        else {
            var ids = "";
            $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    ids += this.value + ",";
                }
            });
        }
        $.ajax({
            type: "Post",
            url: "../ResourceManage/ResourceInfoHander.ashx",
            data: {
                "PageName": "ResourceManage/ResourceInfoHander.ashx",
                Func: "MoveTo", "MoveIDs": ids, "Url": url,
                "pid": pid, "code": code, CreateUID: $("#HUserIdCard").val()
            },
            dataType: "json",
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    layer.msg("文件移动成功");
                    getData(1, 10);
                    CloseIFrameWindow();
                }
                else {
                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                layer.msg('操作失败！');
            }
        });

    }
    function Del(id, name) {
        var len = 0;
        var ids = "";
        if (id != "") {
            ids = id;
        }
        else {
            $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    ids += this.value + ",";// $(this).attr('value') + ",";
                    len++;
                }
            });
        }
        if (ids != "") {
            if (name == "") {
                name = "这" + len + "个文件/文件夹"
            }
            if (confirm("确定要删除'" + name + "'吗？")) {
                $.ajax({
                    url: "../ResourceManage/ResourceInfoHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "ResourceManage/ResourceInfoHander.ashx", "Func": "Del", DelID: ids },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            layer.msg("删除成功");
                            getData(1, 10);
                        }
                        else { layer.msg('删除失败！'); }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
                $('.IsCheckAll .bars').hide();
                $('.IsCheckAlla .bars').hide();

            }
        }
        else { layer.msg("请选择要删除的文件"); }
    }
    function getO(id) {
        if (typeof (id) == "string")
            return document.getElementById(id);
    }

    //文件夹点击
    function FolderClick(id, FoldUrl, code, IsFolder, CheckUsers) {
        if (IsFolder == 1) {

            $("#Pid").val(id);
            $("#HFoldUrl").val(FoldUrl);
            $("#code").val(code)
            var ShowType = $("#ShowType").val();
            if (ShowType == "1") {
                getData(1, 10);
            }
            else {
                getData(1, 16);
            }
            if (id != 0) {
                BindNav();
            }
            else {
                $("#Nav").html("<a href=\"#\" onclick=\"FolderClick(0, '\DriveFolder', 0,1)\">全部</a>");
            }
        }
        else {
            var FileExt = getFileName(FoldUrl);
            if (FileExt == "ppt" || FileExt == "pptx" || FileExt == "doc" || FileExt == "docx" || FileExt == "xls" || FileExt == "xlsx" || FileExt == "pdf") {
                $.ajax({
                    url: "../ResourceManage/ResourceInfoHander.ashx",
                    type: "post",
                    async: false,
                    dataType: "text",
                    data: {
                        "Func": "Wopi_Proxy", filepath: FoldUrl, CheckUsers: CheckUsers
                    },
                    success: function (result) {
                        window.open(result);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.msg("资源不存在！");
                    }
                });
            }
            else {
                DownLoad(FoldUrl);
            }
        }
    }

    function getFileName(o) {
        //通过第一种方式获取文件名
        var pos = o.lastIndexOf(".");
        //查找最后一个\的位置
        return o.substring(pos + 1);
    }
    function DownLoad(FoldUrl) {
        $.ajax({
            url: "../OnlineLearning/DownLoadHandler.ashx",
            type: "post",
            async: false,
            dataType: "text",
            data: {
                filepath: FoldUrl
            },
            success: function (result) {

                if (result == "-1") {
                    layer.msg('文件不存在!');
                    return;
                }
                else {
                    window.open("/OnlineLearning/DownLoadHandler.ashx?filepath=" + FoldUrl + "&UserIdCard=" + $("#HUserIdCard").val() + "&time=" + new Date());
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("资源不存在！");
            }
        });
        $('.IsCheckAll .bars').hide();
        $('.IsCheckAlla .bars').hide();

    }
    //按类型搜索
    function serchType(Postfixs, em) {
        $(em).parent().addClass("on").siblings().removeClass("on");

        $("#Postfixs").val(Postfixs);
        if ($("#ShowType").val() == "1") {
            getData(1, 10);
        }
        else {
            getData(1, 16);
        }
    }
    //按时间搜索
    function SerchTime(STime, em) {
        $(em).parent().addClass("on").siblings().removeClass("on");

        $("#TimeQuery").val(STime);
        if ($("#ShowType").val() == "1") {
            getData(1, 10);
        }
        else {
            getData(1, 16);
        }
    }
    //新增文件夹
    function AddFold(em) {
        var FileName = $("#txt" + em + "").val();
        var pid = $("#Pid").val();
        var Pcode = $("#code").val();
        var CreateUID = $("#HUserIdCard").val();
        if (FileName.length > 0) {
            $.ajax({
                type: "Post",
                url: "../ResourceManage/ResourceInfoHander.ashx",
                data: { Func: "AddFolder", "FileName": FileName, FoldUrl: $("#HFoldUrl").val(), Pid: pid, "code": Pcode, "CreateUID": CreateUID },
                dataType: "json",
                success: function (json) {

                    if (json.result.errNum.toString() == "0") {
                        layer.msg("文件夹添加成功");
                        getData(1, 10);
                    }
                    else { layer.msg('文件夹添加失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('文件夹添加失败！');
                }
            });
        }
        else { layer.msg("请输入文件夹名称"); }
    }
    function upload() {
        var pid = $("#Pid").val();
        var Pcode = $("#code").val();
        var FoldUrl = $("#HFoldUrl").val();
        var CreateUID = $("#HUserIdCard").val();
        if (pid == "0" || pid == "" || pid == undefined || pid == "null") {
            layer.msg("请选择文件目录");
        }
        else {
            OpenIFrameWindow('文件上传', 'HtmlUploder.aspx?FoldUrl=' + encodeURI(FoldUrl) + "&Pid=" + pid + "&code=" + Pcode + "&CreateUID=" + CreateUID + "&Type=Resources_Open", '800px', '550px');
        }
    }
    //格式化时间
    Date.prototype.Format = function (fmt) { //author: meizz 
        var o = {
            "M+": this.getMonth() + 1, //月份 
            "d+": this.getDate(), //日 
            "h+": this.getHours(), //小时 
            "m+": this.getMinutes(), //分 
            "s+": this.getSeconds(), //秒 
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
            "S": this.getMilliseconds() //毫秒 
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

    //修改文件名称
    function EditName(em, id, oldname, FileUrl) {
        var name = $("#txt" + id).val();
        if (name == oldname) {
            layer.msg("请输入新的文件名");
        }
        else {
            $.ajax({
                url: "../ResourceManage/ResourceInfoHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "reName", ID: id, "NewName": name, "FileUrl": FileUrl, oldname: oldname },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("重命名成功");
                        getData(1, 10);
                    }
                    else { layer.msg('重命名失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('重命名失败！');
                    $(em).parents("li").find(".docu_name").html(oldname);
                }
            });
        }
    }
    //取消修改文件名称
    function EditNameQ(em, name) {
        $(em).parents("li").find(".docu_name").html(name);
    }
    function cl(em, id, title, FileUrl) {
        var CurrentHtml = $(em).parents("li").find(".docu_name").html();
        var len = $(em).parents("ul").find('input:text').length;
        if (CurrentHtml.indexOf("text") > 0) {
            layer.msg("当前文件已处于编辑状态");
        }
        else {
            if (len > 0) {
                layer.msg("当前只能同时编辑一个文件");
            }
            else {
                var now = new Date();
                var nowStr = now.Format("yyyy-MM-dd");

                var name = $(em).parents("li").find(".docu_name").html();
                if (name = title) {
                    var v = "<input type='text' value='" + title + "' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + id +
            "\"/> <i class=\"icon tishi true_t icon-ok\" style=\"margin-left: 6px;margin-top:6px; color: #87c352; float: left;cursor:pointer;\" onclick=\"EditName(this,'" + id + "','" + name + "','" + FileUrl + "')\"></i> <i class=\"icon icon-remove tishi fault_t\" style=\"margin-left: 6px;margin-top:6px;color: #ff6d72; float: left;cursor:pointer;\" onclick=\"EditNameQ(this,'" + name +
            "')\"></i>";
                    $(em).parents("li").find(".docu_name").html(v);
                    $(em).parents("li").find(".docu_name").removeAttr("onclick");
                }
            }
        }
    }
    //删除一行（table）
    function DelRow() {
        var ShowType = $("#ShowType").val();
        if (ShowType == "2") {
            $('ul#tb_MyResource1 li:eq(0)').remove();
        }
        else {
            $('ul#tb_MyResource li:eq(0)').remove();
        }
    }
    //追加一行（新建文件夹）

    function appendAfterRow(RowIndex) {
        var tableID = 'tb_MyResource';
        var ShowType = $("#ShowType").val();
        if (ShowType == "2") {
            tableID = 'tb_MyResource1';
        }
        var txt1 = document.getElementById("txt1");
        if (txt1 != undefined) {
            //txt1.onfocus();
        }//<img src='" + $("#HIcons").val() + "/ico-file.png' style='float:left;'>
        else {
            var li = document.createElement("li");
            li.className = "clearfix";
            var ul = document.getElementById(tableID);
            var now = new Date();
            var nowStr = now.Format("yyyy-MM-dd");
            //newRefRow.insertCell(3).innerHTML = nowStr;
            li.innerHTML = "<div class='checkbox fl'><input type='checkbox'/></div><div class='docu_messages fl'>" +
                "<p class=\"docu_title\"><span class=\"h-ico ico-file-min\"></span><a class=\"docu_name\"><input type='text' value='新建文件夹' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + RowIndex +
                "\"/> <i class=\"icon tishi true_t icon-ok\" style=\"margin-top:6px ;margin-left:6px; color: #87c352; float: left;cursor:pointer;\" onclick=\"AddFold('" + RowIndex
                + "')\"></i> <i class=\"icon tishi fault_t icon-remove\" style=\"margin-top:6px ;margin-left:6px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"DelRow()\"></i></a></p></div><div class=\"skydrive_size fl\"><span>--</span></div><div class=\"date fr\"><span>" + nowStr + "</span></div>";
            if (ShowType == "2") {
                //li.innerHTML = "<div class='checkbox' style='display: none;'><input name='Check_box' class='Check_box' onclick=\"setSelectAll()\" type=\"checkbox\"></div><div class=\"skydrive_grid_view\">" +
                //    "<a href=\"#\"><em class=\"h-ico ico-file-max\"><img style=\"width: 100%; height: auto;\"></em>\<p title=\"新建文件夹\" class=\"grid_view_name\">Pocket(3).mp...</p></a></div></li>";
                li.innerHTML = "<div class='checkbox' style='display: none;'><input name='Check_box' class='Check_box' type='checkbox'/></div><div class='skydrive_grid_view'>" +
                    "<a href='#'><em class='ico-file-max a-ico-file'><img style='width: 100%; height: auto;'></em><input type='text' value='新建文件夹' style='float:left;line-height:10px;margin-top:5px;width:66px;' id=\"txt" + RowIndex +
                    "\"/> <i class=\"icon tishi true_t icon-ok\" style=\"margin-top:6px ;margin-left:6px; color: #87c352; float: left;cursor:pointer;\" onclick=\"AddFold('" + RowIndex
                    + "')\"></i> <i class=\"icon tishi fault_t icon-remove\" style=\"margin-top:6px ;margin-left:6px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"DelRow()\"></i></a></div>";
            }
            var nodeli1 = ul.getElementsByTagName('li')[0];//获取ul下第3个节点——秋天
            ul.insertBefore(li, nodeli1);
        }
    }
</script>
</html>
