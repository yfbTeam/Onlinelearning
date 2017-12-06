<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckCertApply.aspx.cs" Inherits="SSSWeb.PersonalSpace.CheckCertApply" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>证书管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link href="../css/certificateT.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="Term.js"></script>
    <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->


    <script id="tr_Certificate" type="text/x-jquery-tmpl">
        <tr>
            <td>${cName}</td>
            <td>${CreateName}</td>
            <td>${CompleteTime}</td>
            <%--<td>{{if Status==1}}<span>审核通过</span>{{else}}<span>待审核</span>{{/if}}
            </td>--%>
            <td>{{if Status==1}}审核通过
                {{else}}{{if Status==2}}审核未通过
                {{else}}<a onclick="CheckCertificate(${ID},1)" style="cursor: pointer;">通过</a>&nbsp;&nbsp;<a onclick="CheckCertificate(${ID},2)" style="cursor: pointer;">拒绝</a>
                {{/if}}
                 {{/if}}
            </td>
        </tr>
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=UserInfo.IDCard %>" />

    <form id="form1" runat="server">
        <input id="option" type="hidden" value=">" />
        <!--header-->

        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <div class="newcourse_select clearfix none" id="Search">
                </div>
                <div class="spacecenter">
                    <div class="wrap">
                        <table>
                            <thead>
                                <th>证书名称</th>
                                <th>申请人</th>
                                <th>申请时间</th>
                                <%--<th>状态</th>--%>
                                <th>操作</th>
                            </thead>
                            <tbody id="tbCheck">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page none">
            <span id="pageBar"></span>
        </div>
    </form>
</body>
<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">
    var UrlDate=new GetUrlDate();
    $(function () {
        CertificateCheck(1, 10);
    });

    //证书
    function CertificateCheck(startIndex, pageSize) {
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            dataType: "json",
            data: {
                PageName: "/Certificate/Certificate.ashx",
                Func: "GetCertificates",
                Ispage: true,
                NStatus: 1,
                PageIndex: startIndex,
                pageSize: pageSize,
                CourceID: UrlDate.CourceID
                },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tbCheck").html('');
                    $("#tr_Certificate").tmpl(json.result.retData.PagedData).appendTo("#tbCheck");
                }
                else {
                    var html = '<tr><td colspan="1000"><div style="background:#fff url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';

                    $("#NCertificateList").html(html);
                }
            },
            error: function (errMsg) {
                $("#tbCheck").html(errMsg);
            }
        });
    }


    //操作课程通知数据
    function CheckCertificate(ID, isPass) {
        $.ajax({
            url: "../Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Certificate/Certificate.ashx",
                Func: "CheckApply",
                ID: ID,
                CheckMessage: "",
                isPass: isPass,
                UserIdCard: $("#HUserIdCard").val()
            },
            success: function (json) {
                var result = json.result;
                if (result.errNum == 0) {
                    layer.msg('操作成功!');
                    CertificateCheck(1, 10);
                } else {
                    layer.msg(result.errMsg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        });
    }
</script>
</html>
