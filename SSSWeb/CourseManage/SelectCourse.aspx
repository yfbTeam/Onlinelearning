<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectCourse.aspx.cs" Inherits="SSSWeb.CourseManage.SelectCourse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>选课人员</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/choosen/chosen.css" rel="stylesheet" />
    <link href="../css/choosen/prism.css" rel="stylesheet" />
    <link href="../css/choosen/style.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=2.0"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/choosen/chosen.jquery.js"></script>
    <script src="../Scripts/choosen/prism.js"></script>
    <script src="../Scripts/choosen/chosen.jquery.js"></script>
    <script src="../Scripts/choosen/prism.js"></script>
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td>${CreateName}</td>
            <td>${DateTimeConvert(LastStudyTime,"yyyy-MM-dd HH:mm:ss")}</td>

            <td>${CalculatePercent(CoStatistics)}</td>
            <td>
                <a href="javascript:;" onclick="Save('${StuNo}','${CalculatePercent(CoStatistics)}','${CreateName}')" style="background: #ef6161; text-decoration: none;"><i class="icon icon-trash"></i>删除</a>
            </td>
        </tr>

    </script>
</head>
<body style="background: #fff;">
    <form id="form1" runat="server">
        <div>

            <div class="newcourse_dialog_detail">
                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select" style="margin-bottom: 8px;">
                        <label for="">课程名称：</label>
                        <span id="CourceName"></span>
                    </div>
                    <div class=" fr" style="margin-top: 8px;">
                        <label for="" class="fl" style="line-height: 38px; color: #555;">添加人员：</label>
                        <div class="fl" style="min-width: 160px; max-width: 400px; margin-top: 5px">
                            <select class="chosen-select" data-placeholder="学员" multiple="multiple" id="StuInfo" onchange="Save()">
                            </select>
                        </div>
                    </div>
                </div>

                <div class="wrap">
                    <table id="Course">
                        <thead>
                            <tr>
                                <th>姓名</th>
                                <th>最近学习时间</th>
                                <th>学习进度</th>
                                <th>操作</th>
                            </tr>
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
    </form>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            $("#CourceName").html(decodeURI(UrlDate.CourceName));
            BindSelInfo(1, 10);
            BindStu();
        })

        function Save(StuNo, Per, StuName) {
            var Flag = true;
            var Type = "";
            if (StuNo == "" || StuNo == undefined || StuNo == null) {
                StuNo = $("#StuInfo").val();
                Type = "1";
            }
            else {
                if (Per != "0%") {
                    Flag = false;
                    layer.msg("已学习的学员不允许删除");
                }
                else {
                    if (confirm("确定要移除该学员吗？")) {
                        Type = "0"
                    }
                    else {
                        Flag = false;
                    }
                }
            }
            if (Flag) {
                $.ajax({
                    url: "../Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "/CourseManage/CourceManage.ashx",
                        Func: "AdJustStu",
                        CourseID: UrlDate.CourceID,
                        StuNo: StuNo,
                        Type: Type
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            if (Type == "1") {
                                layer.msg("新增成功");
                                BindStu();
                            }
                            else {
                                layer.msg("移除成功");
                                $("#StuInfo").append("<option value='" + StuNo + "'>" + StuName + "</option>");
                            }
                            BindSelInfo();
                            parent.geCoursetData(1, 10, '2')
                        }
                        else {
                            if (json.result.errMsg != "未作调整") {
                                layer.msg(json.result.errMsg);
                            }
                        }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }
        }
        function BindStu() {
            var HasStu = "";
            $(UserInfo).each(function () {
                HasStu += this.StuNo + ",";
            })
            UserInfo
            $("#StuInfo").html("");
            $.ajax({
                url: "../SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    func: "GetUserInfoData", IsStu: "false"
                },
                success: function (json) {
                    var Option = "";
                    var result = json.result;
                    if (result.errNum == 0) {
                        $(json.result.retData).each(function () {
                            if (HasStu.indexOf(this.UniqueNo) < 0) {
                                Option += "<option value='" + this.UniqueNo + "'>" + this.Name + "</option>";
                            }
                        })
                        $("#StuInfo").html(Option);
                        $("#StuInfo").chosen({
                            allow_single_deselect: true,
                            disable_search_threshold: 10,
                            no_results_text: '未找到',
                            width: '95%'
                        });
                        $("#StuInfo").trigger("chosen:updated");
                        //$("#Grade").trigger("liszt:updated");--旧版本
                        $("#StuInfo").chosen();

                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        var UserInfo = [];
        //获取数据
        function BindSelInfo(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            var StudyTerm = $("#StudyTerm").val();

            $.ajax({
                url: "../Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                    Func: "GetMyLessonsDataPage",
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    ispage: true,
                    IsPercent: 1,
                    CourseID: UrlDate.CourceID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        UserInfo = json.result.retData.PagedData;
                        $(".page").show();
                        $("#tb_Manage").html('');
                        $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_Manage");
                        if (json.result.retData.RowCount > pageSize) {
                            $(".page").show();
                            makePageBar(BindSelInfo, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                        }
                        else {
                            $(".page").hide();
                        }
                        BindStu();
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
        function CalculatePercent(perinfo) {
            var allwidth = 0;
            var oneArray = perinfo.split(',');
            for (var i = 0; i < oneArray.length; i++) {
                var twoArray = oneArray[i].split('|');
                if (twoArray[2].toString() != "0") {
                    allwidth += Math.round((twoArray[3] / twoArray[2]) * (twoArray[1] / 100) * 10000) / 100.00;
                }
            }
            return allwidth + "%";
        }
    </script>
</body>
</html>
