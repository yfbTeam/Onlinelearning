<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceReviwe.aspx.cs" Inherits="SSSWeb.PersonalOffice.ResourceReviwe" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>文件审批</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />
    <%--<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>--%>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td><a style="cursor: pointer; background: none; color: #808080" href="${FileUrl}">${Name}</a></td>
            <td>${CreateName}</td>
            <td>${OrgName}</td>
            <td>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</td>
            <td>{{if Status==0}}待审核
            {{else}}{{if Status==2}}审核失败
            {{else}}审核通过
            {{/if}}{{/if}}</td>
            <td>${TwoUserName}</td>
            <td>${DateTimeConvert(EidtTime,'yyyy-MM-dd')}</td>
            <td>${CheckMessage}</td>

            <td>
                <a href="javascript:;" onclick="javascript:OpenIFrameWindow('审核', 'CheckResource.aspx?ID=${ID}', '600px', '270px');">
                    <i class="icon icon-edit"></i>审核</a>
            </td>
        </tr>
    </script>

</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.UniqueNo%>" />
    <input type="hidden" id="HUserName" value="<%=UserInfo.Name %>" />
    <input type="hidden" id="HPId" />
    <form id="form1" runat="server">

        <div class="onlinetest_item width">
            <div class="course_manage bordshadrad">

                <div class="newcourse_select clearfix" id="CourseSel">
                    <div class="search_exam fl pr" style="margin:10px 0px;">
                        <select name="" class="select" id="Status" onchange="getData(1, 10)" style="height: 30px; margin: 0px 5px">
                            <option value="0">待审核</option>
                            <option value="1">审核通过</option>
                            <option value="2">审核失败</option>
                        </select>
                    </div>

                  
                </div>
                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <th>文件</th>
                            <th>上传人</th>
                            <th>组织机构</th>
                            <th>上传时间</th>
                            <th>状态</th>
                            <th>审核人</th>
                            <th>审核时间</th>
                            <th>审核意见</th>
                            <th>操作</th>
                        </thead>
                        <tbody id="tb_Manage">
                        </tbody>
                    </table>

                </div>
                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                </div>
            </div>
        </div>
        <footer id="footer" class="none"></footer>
    </form>
</body>
<script type="text/javascript" src="../js/common.js"></script>
<script>
    var UrlDate = new GetUrlDate();

    $(document).ready(function () {
        getData(1, 10);
    });

    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: {
                "PageName": "ResourceManage/ResourceInfoHander.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize
                ,"Status": $("#Status").val(), LoginCheckUser: '<%=UserInfo.UniqueNo %>'
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
    }
</script>
</html>
