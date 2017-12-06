<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelResource.aspx.cs" Inherits="SSSWeb.ResourceManage.SelResource" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>教师云盘</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/sprite.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Pager.js"></script>
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
                <input type='checkbox' value='${ID}' class='Check_box' name='Check_box' id='subcheck' onclick='setSelectAll()' />
            </div>
            <div class="docu_messages fl">
                <p class="docu_title">
                    <span class="ico-${postfix1}-min h-ico" onclick="FolderClick(${ID},'${FileUrl}','${code}',${IsFolder})">
                        <img <%--src='${FileIcon}'--%>style="width:100%;height:auto;" /></span>
                    <span class="docu_name" href="javascript:;" onclick="FolderClick(${ID},'${FileUrl}','${code}',${IsFolder})" title="${Name}">${cutstr(Name,30)}</span>
                </p>
            </div>

            <div class="skydrive_size fl">
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
                <input type='checkbox' value='${ID}' class='Check_box' name='Check_box' onclick='setSelectAll()' />
            </div>
            <div class="skydrive_grid_view">
                <a href="#" onclick="FolderClick(${ID},'${FileUrl}','${code}',${IsFolder})">
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
            <input id="HFoldUrl" type="hidden" value="/DriveFolder" />
            <input id="ShowType" type="hidden" value="1" />
            <input id="GroupName" type="hidden" value="" />
            <input id="Postfixs" type="hidden" value="" />
            <input id="TimeQuery" type="hidden" value="" />
            <!--header-->

            <!--网盘-->
            <div class="skydrive width bordshadrad" style="width: 800px;">
                <div class="modult_toolsbar clearfix">


                    <!--工具条-->
                    <div class="toolsbar fl">
                        <div class="bars">
                            <a href="#" class="upload pr">

                                <span class="txt" onclick="CourceResource()">确定</span>
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
                        <a href="#" onclick="FolderClick(0, '\DriveFolder', 0,1)">全部</a>
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

                                <div class="skydrive_size fl" style="left: 61%">
                                    <span style="font-size: 15px;">大小</span>
                                </div>
                                <div class="datea fr" style="line-height: 23px; margin-right: 15px;">
                                    <span style="font-size: 15px; color: #999999">修改时间</span>
                                </div>
                            </div>

                            <ul class="document_list skydrive_docu_list" style="display: block;" id="tb_MyResource">
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

                            </div>
                            <ul class="skydrive_grid_list clearfix" id="tb_MyResource1">
                            </ul>
                        </div>
                    </div>
                </div>
                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                </div>
            </div>

            <script type="text/javascript" src="/js/common.js"></script>
            <script type="text/javascript" src="/js/repository.js"></script>

        </div>
    </form>
</body>


<script type="text/javascript">
    //资源绑定课程
    function CourceResource() {
        var ids = "";
        $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
            if (this.checked) {
                ids += this.value + ",";
            }
        });
        if (ids == "") {
            layer.msg("未选择任何资源");
        }
        else {
            var weikePic = "";
            var ResourcesID = ids;
            var CourceID = GetUrlDate.CourceID;
            var ChapterID = GetUrlDate.ChapterID;
            var IsVideo = GetUrlDate.IsVideo;

            $.ajax({
                url: "/CourseManage/Uploade.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    func: "AddWeike", VidoeImag: weikePic, ResourcesID: ResourcesID, CourceID: CourceID, ChapterID: ChapterID, IsVideo: IsVideo
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        if (IsVideo == "1") {
                            parent.BindWeikeResource();
                        }
                        else {
                            parent.BindPutongResource();
                        } parent.CloseIFrameWindow();
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg("操作失败！");
                }
            });
        }
    }
    $(document).ready(function () {

        GetFileType()
        //获取数据
        getData(1, 10);
    });


    //获取数据
    function getData(startIndex, pageSize) {
        var Pid = $("#Pid").val();
        var DocName = $("#search_w").val();
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        var CreateUID = $("#HUserIdCard").val();
        //name = name || '';
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "ResourceManage/ResourceHander.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, CreateUID: CreateUID, "Pid": Pid, "DocName": DocName, "Postfixs": $("#Postfixs").val(), "CreateTime": $("#TimeQuery").val() },
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
                    //全选
                    CheckAlla($('.IsCheckAll input[type=checkbox]'));
                    CheckAllb($('.IsCheckAlla input[type=checkbox]'));
                }
                else {
                    var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
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
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            data: { "PageName": "ResourceManage/PublicResoure.ashx", Func: "ResourceType" },
            dataType: "json",
            success: function (returnVal) {
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

    //面包屑
    function BindNav() {
        var Pid = $("#Pid").val();
        var CreateUID = $("#HUserIdCard").val();
        $("#Nav").html("<a href=\"#\" onclick=\"FolderClick(0, '\DriveFolder', 0,1)\">全部</a>");
        $.ajax({
            type: "Post",
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            data: { "PageName": "ResourceManage/ResourceHander.ashx", Func: "BindNav", Pid: Pid, CreateUID: CreateUID },
            dataType: "json",
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        var result = "<span>></span><a href=\"#\" onclick=\"FolderClick(" + this.ID + ",'" + this.FileUrl + "', " + this.code + "," + this.IsFolder + ")\">" + this.Name + "</a>";
                        $("#Nav").append(result);
                    });
                }
            },
            error: function (errMsg) {
                layer.msg('数据加载失败！');
            }
        });
    }
    function getO(id) {
        if (typeof (id) == "string")
            return document.getElementById(id);
    }

    //文件夹点击
    function FolderClick(id, FoldUrl, code, IsFolder) {
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
                    url: "/ResourceManage/ResourceHander.ashx",
                    type: "post",
                    async: false,
                    dataType: "text",
                    data: {
                        "Func": "Wopi_Proxy", filepath: FoldUrl
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

</script>
</html>
<%--<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <title>资源库</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/sprite.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>

    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="checkbox fl">
                <input type='checkbox' value='${ID}' class='Check_box' name='Check_box' id='subcheck' />
            </div>
            <div class="docu_messages fl">
                <p class="docu_title" onclick="FileClick(${ID},'${FileUrl}')">
                    <span class="ico-${postfix1}-min h-ico">
                        <img style="width: 100%; height: auto;" /></span><a class="docu_name" href="#" title="${Name}">${cutstr(Name,40)}</a>
                </p>
                <div class="down_mes">
                    <span class="down_mes_dates">
                        <i class="test_type">{{if FileGroup==""}} 
                            其他 {{else}}
                            ${FileGroup}
                             {{/if}}
                        </i>
                        <em class="download_mes_date">${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</em>
                    </span>
                </div>
            </div>
            <div class="unload_none" style="display: none">
                
                <span class="arrow-down pr">
                    <i class="icon" title="更多">
                        <img src="/images/xai.png" /></i>
                    <div class="arrow_downwrap">
                        <span class="rename" onclick="Down(${ID})">下载</span>
                        <span class="delete" onclick="Del(${ID},'${Name}')">删除</span>
                    </div>
                </span>
            </div>
            <div class="assess" id="${ClickNum}">

                <span id="1" onclick="Evalue(1,${ID},this)"></span>
                <span id="2" onclick="Evalue(2,${ID},this)"></span>
                <span id="3" onclick="Evalue(3,${ID},this)"></span>
                <span id="4" onclick="Evalue(4,${ID},this)"></span>
                <span id="5" onclick="Evalue(5,${ID},this)"></span>
            </div>
        </li>
    </script>
    <script id="tr_User1" type="text/x-jquery-tmpl">
        <li>
            <div class="checkbox">
                <input type="checkbox" name="Check_box" id="" value="" />
            </div>
            <div class="grid_view">
                <a href="#" onclick="FileClick(${ID},'${FileUrl}')">
                    <em class="ico-${postfix1}-max grid_view_ico">
                        <img style="width: 100%; height: auto;" /></em>
                    <p class="grid_view_name" title="${Name}">${cutstr(Name,12)}</p>
                </a>
                <div class="grid_view_dates">
                    <span class="grid_view_date fl">${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</span>

                </div>
            </div>
        </li>
    </script>
    <script id="tr_DowDetail" type="text/x-jquery-tmpl">
        <li>
            <div class="download_messages clearfix">
                <span class="date fl">${getDateDiff(ClickTime*1000)}
                </span>
                <span class="download_message fl">${CreateName}下载了
                </span>
            </div>
            <p class="download_title">
                <span class="ico-${postfix1}-min g-ico">
                    <img style="width: 100%; height: auto;" /></span><span class="download_name" title="${Name}">${Name}</span>
            </p>
        </li>
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input type="hidden" id="HUserIdCard" value="<%=UserInfo.IDCard %>" />
            <input type="hidden" id="HUserName" runat="server" />
            <input type="hidden" id="HClassID" runat="server" />

            <asp:HiddenField ID="HSchoolID" runat="server" />
            <input id="HFoldUrl" type="hidden" value="/PubFolder" />
            <input id="code" type="hidden" value="0" />
            <input id="ShowType" type="hidden" value="1" />
            <input id="GroupName" type="hidden" value="" />
            <input id="Postfixs" type="hidden" value="" />
            <input id="ID" type="hidden" value="0" />
            <input id="HPeriod" type="hidden" value="0" />
            <input id="HSubject" type="hidden" value="0" />
            <input id="HTextboox" type="hidden" value="0" />
            <input id="HChapterID" type="hidden" value="0" />

            <input id="bookVersion" type="hidden" value="0" />

          
            <div class="choiceversion">
                <div class="selected clearfix" style="background: #1783c7; padding: 10px; width: 100px;">
                    <strong>教育学部</strong>
                    <em class="trigger"><i class="icon-angle-down icon"></i></em>
                </div>
                <div class="contentbox">
                    <h2 class="subtitle">教材选择</h2>
                    <div class="item">
                        <select name="" id="Period" onchange="PeriodChange()">
                        </select>
                       
                    </div>
                    <div class="item">
                        <select name="" id="Subject" onchange="SubjectChange()">
                        </select>
                    </div>
                    <div class="item">
                        <select id="TextbookVersion" onchange="VersionChange()">
                        </select>
                    </div>
                    <div class="item">
                        <select id="Textbook" onchange="TextbookChange()">
                        </select>
                    </div>

                </div>
            </div>

            <!--内容-->
            <div class="grid clearfix" style="width: 100%">
                <div class="main clearfix">
                    <section class="menu fl">
                        <div class="grade pr">
                            <div class="item">
                                <span class="icon-th-list icon icon_list"></span>
                                <span class="title" id="BookName"></span>
                                <span class="icon icon-angle-right icon_right"></span>
                            </div>

                        </div>
                        <div class="items" id="menuChapater">
                        </div>

                    </section>
                    <section class="article_content fr bordshadrad">
                        <div class="modult_toolsbar clearfix">

                            <!--工具条-->
                            <div class="toolsbar fl">
                                <div class="bars">
                                    <a href="javascript:;" class="upload pr">
                                        <i class="icon  icon-upload-alt"></i>
                                        <span class="txt" onclick="CourceResource()">确定</span>
                                    </a>

                                </div>
                            </div>
                        </div>

                        <!--docu-->
                        <div class="docu_wrap">
                            <div class="docu_item none">
                                <a href="javascript:;" class="on" onclick="FileGroup('',this)">全部</a>
                                <a href="javascript:;" onclick="FileGroup('教案',this)">教案</a>
                                <a href="javascript:;" onclick="FileGroup('课件',this)">课件</a>
                                <a href="javascript:;" onclick="FileGroup('习题',this)">习题</a>
                                <a href="javascript:;" onclick="FileGroup('微课',this)">微课</a>

                            </div>

                            <!--内容-->
                            <div class="docu_content">

                                <!--docu_list-->
                                <ul class="document_list" style="display: block;" id="tb_MyResource">
                                </ul>
                                <ul class="docu_grid clearfix" id="tb_MyResource1">
                                </ul>
                            </div>
                        </div>
                        <!--分页-->
                        <div class="page" id="pageBar">
                        </div>
                    </section>
                </div>

            </div>
            <script src="/js/common.js"></script>
            <script type="text/javascript" src="/js/repository.js"></script>
        </div>
    </form>
</body>
<script type="text/javascript">
    function ResourceGroup() {
        $(".contentbox").hide();
    }
    $(document).ready(function () {

        BindCatagory();
        Chapator();
        var IsVideo = GetUrlDate.IsVideo;
        if (IsVideo == "1") {
            serchType('8', '');
        }
        else { serchType('', ''); }
    });
    function serchType(Postfixs, em) {
        $(em).parent().addClass("on").siblings().removeClass("on");

        $("#Postfixs").val(Postfixs);
        if ($("#ShowType").val() == "1") {
            getData(1, 10);
        }
        else {
            getData(1, 12);
        }
    }
    function getData(startIndex, pageSize) {
        var DocName = $("#search_w").val();
        var CatagoryID = $("#HPeriod").val() + "|" + $("#HSubject").val() + "|" + $("#bookVersion").val() + "|" + $("#HTextboox").val();

        //var CatagoryID = $("#HTextboox").val();
        var ChapterID = $("#HChapterID").val();
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        //name = name || '';
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: { "PageName": "ResourceManage/PublicResoure.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, "DocName": DocName, "GroupName": $("#GroupName").val(), "Postfixs": $("#Postfixs").val(), "IDCard": $("#HUserIdCard").val(), "CatagoryID": CatagoryID, "ChapterID": ChapterID },
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
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    //列表页与图标页每项划过显示
                    hoverShow($('.document_list li'), $('.unload_none'));
                    hoverShow($('.docu_grid li'), $('.checkbox'));
                    Star();
                }
                else {
                    $(".page").hide();
                    var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                    if (ShowType == "1") {
                        $("#tb_MyResource").html(html);
                    }
                    else { $("#tb_MyResource1").html(html); }
                }
            }
,
            error: OnError
        });
    }

    function OnError(XMLHttpRequest, textStatus, errorThrown) {
        var htmlBq = '<li style="text-align:center;">无内容</li>';
        if (ShowType == "1") {
            $("#tb_UserList").html(htmlBq);
        }
        else { $("#tb_UserList1").html(htmlBq); }
    }
    //评价
    function Star() {
        //stars评价
        $('.document_list').find(".assess").each(function () {
            var num = $(this).attr("id");
            if (num > 0) {
                $(this).find("span").eq(num - 1).siblings().removeClass('on');
                $(this).find("span").eq(num - 1).prevAll().andSelf().addClass('on');
            }
        })
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
    var GetUrlDate = new GetUrlDate();

    //资源绑定课程
    function CourceResource() {
        var ids = "";
        $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
            if (this.checked) {
                ids += this.value + ",";
            }
        });
        if (ids == "") {
            layer.msg("未选择任何资源");
        }
        else {
            var weikePic = "";
            var ResourcesID = ids;
            var CourceID = GetUrlDate.CourceID;
            var ChapterID = GetUrlDate.ChapterID;
            var IsVideo = GetUrlDate.IsVideo;

            $.ajax({
                url: "/CourseManage/Uploade.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    func: "AddWeike", VidoeImag: weikePic, ResourcesID: ResourcesID, CourceID: CourceID, ChapterID: ChapterID, IsVideo: IsVideo
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        if (IsVideo == "1") {
                            parent.BindWeikeResource();
                        }
                        else {
                            parent.BindPutongResource();
                        } parent.CloseIFrameWindow();
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg("操作失败！");
                }
            });
        }
    }

    function DownLoad(FoldUrl) {
        $.ajax({
            url: "/OnlineLearning/DownLoadHandler.ashx",
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
                    location.href = "/OnlineLearning/DownLoadHandler.ashx?filepath=" + FoldUrl + "&UserIdCard=" + $("#HUserIdCard").val() + "&time=" + new Date();
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("资源不存在！");
            }
        });
    }
    //评价
    function Evalue(star, ID, em) { //stars评价
        if ($(em).parent().find(".on").length > 0) {
            layer.msg("不允许重复评论");
        }
        else {
            $(em).siblings().removeClass('on');
            $(em).prevAll().andSelf().addClass('on');

            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                // async: false,
                dataType: "json",

                data: { "PageName": "ResourceManage/PublicResoure.ashx", "Func": "Evalue", "ID": ID, "ClickType": "2", "IDCard": $("#HUserIdCard").val(), "Evalue": star },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("评价成功");
                        getData(1, 10);
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
    function Chapator() {
        $("#HChapterID").val("");

        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Chapator" },
            success: function (json) {
                //BindleftMenu(json);
                if (json.result.errNum.toString() == "0") {
                    div = "";
                    BindleftMenu(json.result.retData, 0);
                    $("#menuChapater").html("");
                    $("#menuChapater").append(div);
                    menuSel();
                }
                else {
                    layer.msg(json.result.errMsg);
                }

            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
        if (GetUrlDate.CourceID == null) {
            getData(1, 10);
        }
    }
    var div = "";
    var TopMenuNum = 0;

    function BindleftMenu(data, id) {

        var i = 0;
        $(data).each(function () {
            if (this.TextbooxID == $("#Textbook").val()) {

                if (this.PID == 0 && this.PID == id) {
                    div += "<div class=\"units\">";
                    div += " <div class=\"item_title\"><span class=\"text\">" + this.Name + "</span><span class=\"icon icon-angle-down\"></span></div>";
                    BindleftMenu(data, this.Id);
                    if (i > 0) {
                        div += "</ul>";
                    }
                    i = 0;
                    div += "</div>";
                    TopMenuNum++;
                }
                if (this.PID != 0 && this.PID == id) {
                    if (TopMenuNum == 0 && i == 0) {
                        div += "<ul class=\"contentbox\" style=\"display: block;\"><li class=\"active\" onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                        $("#HChapterID").val(this.Id);
                        // getData(1, 10);
                    }
                    if (TopMenuNum > 0 && i == 0) {
                        div += "<ul class=\"contentbox\">";
                    }
                    if (i > 0) {
                        div += "<li>\<span class=\"text\" onclick=\"changeMenu(" + this.Id + ")\">" + this.Name + "</span> </li>";
                    }
                    i++;
                }
            }
        })
        //if ($("#HChapterID").val() != "0" && $("#HChapterID").val() != undefined) {
        //    getData(1, 10);
        //}
    }
    function changeMenu(id) {
        $("#HChapterID").val(id);
        getData(1, 10);
    }
    function menuSel()//menu折叠展开 选中切换
    {
        $('.items').find('.units').each(function () {
            var oLi = $('.items').find('li')
            oLi.click(function () {
                oLi.removeClass('active');
                $(this).addClass('active');
            });
            $(this).find('.item_title').click(function () {
                var $next = $(this).next();
                var $icon = $(this).find('.icon');
                $icon.toggleClass('active');
                $next.stop().slideToggle();
                $('.items').find('.contentbox').not($next).slideUp();
                $('.items').find('.icon').not($icon).removeClass('active');
            })
        })
    }
    function BindCatagory() {
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",

            data: { "Func": "Period" },
            success: function (json) {
                CatagoryJson = json;
                //学段
                BindPeriod();
                //版本
                TextbookVersion();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //学段
    function BindPeriod() {
        $("#Period").children().remove();
        option = "<option value='0'>选择学段</option>";
        $("#Period").append(option);

        if (CatagoryJson.Period.errNum.toString() == "0") {
            var num = 0;
            $(CatagoryJson.Period.retData).each(function () {
                var option = "";
                if (num == 0) {
                    option = "<option value='" + this.Id + "'  selected='selected'>" + this.Name + "</option>";
                    $("#HPeriod").val(this.Id);
                    $("#Period").append(option);

                    BindSubject()
                }
                else {
                    option = "<option value='" + this.Id + "'>" + this.Name + "</option>";
                    $("#Period").append(option);
                }
                num++;
            })
        }
        else {
            layer.msg(CatagoryJson.Period.errMsg);
        }
        //getData(1, 10);

    }
    function PeriodChange() {
        ($("#HPeriod").val($("#Period").val()));
        BindSubject();
        Textbook();
        Chapator();
    }
    //科目
    function BindSubject() {
        $("#HSubject").val("0");
        var Period = $("#Period").val();
        $("#HPeriod").val(Period);
        $("#Subject").children().remove();
        option = "<option value='0'>选择科目</option>";
        $("#Subject").append(option);

        var SelPeriod = $("#HPeriod").val();
        if (CatagoryJson.PeriodOfSubject.errNum.toString() == "0") {
            var j = 0;
            $(CatagoryJson.PeriodOfSubject.retData).each(function () {
                var option = "";
                if (this.PeriodID == SelPeriod) {
                    if (j == 0) {
                        option = "<option value='" + this.SubjectID + "' selected='selected'>" + this.SubjectName + "</option>";
                        $("#HSubject").val(this.SubjectID);
                    }
                    else {
                        option = "<option value='" + this.SubjectID + "'>" + this.SubjectName + "</option>";
                    }
                    j++;
                    $("#Subject").append(option);
                }
            })
        }
        else {
            layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
        }
        TextbookVersion();
        //getData(1, 10);

    }
    function SubjectChange() {
        $("#HSubject").val($("#Subject").val());

        Textbook();
    }
    //版本
    function TextbookVersion() {
        $("#bookVersion").val("0");
        var ChapterID = $("#HPeriod").val() + "|" + $("#HSubject").val() + "|" + $("#bookVersion").val() + "|" + $("#HTextboox").val();
        $("#TextbookVersion").children().remove();
        option = "<option value='0'  selected='selected'>教材版本</option>";
        $("#TextbookVersion").append(option);
        if ($("#HSubject").val() != "0") {
            if (CatagoryJson.TextbookVersion.errNum.toString() == "0") {
                var i = 0

                $(CatagoryJson.TextbookVersion.retData).each(function () {

                    var option = "";
                    if (i == 0) {
                        option = "<option value='" + this.Id + "'>" + this.Name + "</option>";
                        $("#bookVersion").val(this.Id);
                        Textbook();
                    }
                    else {
                        option = "<option value='" + this.Id + "'>" + this.Name + "</option>";
                    }
                    $("#TextbookVersion").append(option);
                    i++;
                })
            }
            else {
                layer.msg(CatagoryJson.TextbookVersion.errMsg);
            }
        }
        //getData(1, 10);

    }
    function VersionChange() {
        $("#bookVersion").val($("#TextbookVersion").val());
        Textbook();
        Chapator();
    }
    //教材
    function Textbook() {
        $("#HTextboox").val("0");

        var currentPeriod = $("#HPeriod").val();
        var currentSubjectID = $("#HSubject").val();
        $("#Textbook").children().remove();
        option = "<option value='0' selected='selected'>选择教材</option>";
        $("#Textbook").append(option);

        var bookVersion = $("#bookVersion").val();
        if (CatagoryJson.Textbook.errNum.toString() == "0") {
            var i = 0;

            $(CatagoryJson.Textbook.retData).each(function () {
                var option = "";
                if (bookVersion == this.VersionID && currentPeriod == this.PeriodID && this.SubjectID == currentSubjectID) {
                    if (i == 0) {
                        option = "<option value='" + this.Id + "' selected='selected'>" + this.Name + "</option>";
                        $("#BookName").html(this.Name);
                        $("#HTextboox").val(this.Id);
                    }
                    else { option = "<option value='" + this.Id + "'>" + this.Name + "</option>"; }
                    i++;
                    $("#Textbook").append(option);
                }

            })
        }
        else {
            layer.msg(CatagoryJson.Textbook.errMsg);
        }
        //getData(1, 10);

        //if ($("#HTextboox").val() != "0") {
        //    getData(1, 10);
        //}
    }
    function TextbookChange() {
        $("#BookName").html($("#Textbook").text());
        Chapator();
        $("#HTextboox").val($("#Textbook").val());
        //getData(1, 10);
    }
</script>
</html>--%>
