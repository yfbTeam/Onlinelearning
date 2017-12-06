<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Enterprise_Feedback.aspx.cs" Inherits="SSSWeb.FeedBackManage.Enterprise_Feedback" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>企业信息管理</title>
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/common.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/iconfont.css" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../ZZSX/js/tz_slider.js"></script>
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td>
                <input type="checkbox" class="Check_box" name="Check_box" id="${ID}" /></td>
            <td>${Name}</td>
            <td>${LoginName}</td>
            <td>${ContactMan}</td>
            <td>${ContactPhone}</td>
            <%--<td class="Post"><span class="Postname">财务专员</span> <i class="Drop_down iconfont"></i> <ul class="info none"><li>人事专员</li><li>前端开发工程师</li><li>硬件工程师</li><li>销售经理</li><li>售前工程师</li><li>产品经理</li> </ul><span class="Postadd" onclick="OpenIFrameWindow('添加实习岗位', 'Job_Add.aspx?EnterID=1','700px','500px')"><i class="Plus iconfont">󰀊</i></span>             </td>--%>
            <td class="Post">{{html CalculateJob(Job)}}
                
                <span class="Postadd" onclick="OpenIFrameWindow('添加实习岗位', 'Job_Add.aspx?EnterID=${ID}','700px','500px')"><i class="Plus iconfont">&#xf000a;</i></span>
            </td>
            <td>
                <div class="qijin">
                    {{if Status==1}}
                    <span class="Enable active">启用</span><span class="Disable" onclick="ChangeStatus(0,${ID})">禁用</span>
                    {{else}}<span class="Enable" onclick="ChangeStatus(1,${ID})">启用</span><span class="Disable active">禁用</span>
                    {{/if}}
                </div>
            </td>
            <td class="operate" title="修改"><i class="iconfont" onclick="OpenIFrameWindow('修改企业信息', 'Enterprise_Edit.aspx?ID=${ID}','700px','550px')">&#xe62f;</i></td>
        </tr>
    </script>
</head>
<body>
    <!--企业信息管理-->
    <div class="Enterprise_information_feedback">
        <!--页面名称-->
        <%--<h1 class="Page_name">企业信息管理</h1>--%>
        <!--整个展示区域-->
        <div class="Whole_display_area">
            <!--操作区域-->
            <div class="Operation_area">
                <div class="left_choice fl">
                    <ul>
                        <li class="Select">
                            <select class="option" id="Status" onchange="getData(1, 10)">
                                <option value="">全部状态</option>
                                <option value="1">启用</option>
                                <option value="0">禁用</option>
                            </select>
                        </li>
                        <li class="Batch_operation">
                            <select class="option">
                                <option>批量操作</option>
                                <option onclick="ChangeStatus(1,'')">启用</option>
                                <option onclick="ChangeStatus(0,'')">禁用</option>
                            </select>

                        </li>
                        <li class="Sear">
                            <input type="text" placeholder=" 请输入公司名称" class="search" name="search" id="Name" /><i class="iconfont" onclick="getData(1,10)" style="cursor: pointer">&#xe61b;</i>
                        </li>
                    </ul>
                </div>
                <div class="right_add fr">
                    <a href="javascript:OpenIFrameWindow('添加企业','Enterprise_Add.aspx','700px','500px')" class="add"><i class="iconfont">&#xf000a;</i>添加企业</a>
                </div>
            </div>
            <div class="clear"></div>
            <!--展示区域-->
            <div class="wrap">
                <table>
                    <thead>
                        <tr>
                            <th width="40px">
                                <%--<input type="checkbox" class="Check_box" name="Check_box" />--%>
                                选择
                            </th>
                            <th>企业名称 </th>
                            <th>企业账号 </th>
                            <th>负责人 </th>
                            <th>联系方式 </th>
                            <th>岗位 </th>
                            <th>状态 </th>
                            <th>操作 </th>
                        </tr>
                    </thead>
                    <tbody id="tb_Manage">
                    </tbody>
                </table>
                <div class="page">
                    <span id="pageBar"></span>
                </div>

            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(function () {
            getData(1, 10);
        })
        //获取数据
        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            var Name = $("#Name").val();

            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    "PageName": "FeedBack/Enterprise.ashx", "Func": "GetPageList",
                    PageIndex: startIndex, pageSize: pageSize, "Name": Name, Status: $("#Status").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(".page").show();
                        $("#tb_Manage").html('');
                        $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                    else {
                        var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        $("#tb_Manage").html(html);
                        $(".page").hide();
                    }

                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
            $(".Post_post").mouseover(function () {
                $(this).find(".more_info").show();
                $(this).find(".Drop_down").addClass("hover_ul");
            });
            $(".Post_post").mouseout(function () {
                $(this).find(".more_info").hide();
                $(this).find(".Drop_down").removeClass("hover_ul");
            });
        }
        function ChangeStatus(Status, ID) {
            var CurID = ID + ',';
            if (ID == "") {
                $("#tb_Manage").find("input:checkbox").each(function () {
                    if (this.checked) {
                        CurID += this.id + ',';
                    }
                })
            }
            if (CurID == "") {
                layer.msg("请选择操作行");
            }
            else {

                for (var i = 0; i < CurID.split(',').length ; i++) {
                    if (CurID.split(',')[i] != '') {
                        $.ajax({
                            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                            type: "post",
                            dataType: "json",
                            data: {
                                "PageName": "FeedBack/Enterprise.ashx", "Func": "AddEnterprise", ID: CurID.split(',')[i], Status: Status
                            },
                            success: function (json) {
                                if (json.result.errNum.toString() == "0") {
                                    layer.msg("修改成功");
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
            }
        }
        function CalculateJob(JobInfo) {
            var Result = "";
            var JobArray = JobInfo.split(',');
            for (var i = 0; i < JobArray.length; i++) {
                if (i == 0) {
                    Result += '<span class="Postname">' + JobArray[i] + '</span><span class="Post_post">';
                }
                else {
                    if (i == 1) {
                        Result += ' <i class="Drop_down iconfont">&#xe62e;</i> <div class="more_info" style="display:none;"> <ul class="info"><li>' + JobArray[i] + '</li>';
                    }
                    else {
                        Result += '<li>' + JobArray[i] + '</li>';

                    }
                    if (i == JobArray.length - 1) {
                        Result += " </ul></div></span>"

                    }
                }
            }
            return Result;

        }
    </script>
</body>
</html>
