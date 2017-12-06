<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Check_Stu.aspx.cs" Inherits="SSSWeb.Recruit.Check_Stu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>报名审核</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/choosen/chosen.css" rel="stylesheet" />
    <link href="../css/choosen/prism.css" rel="stylesheet" />
    <link href="../css/choosen/style.css" rel="stylesheet" />
    <link href="../Scripts/Webuploader/css/webuploader.css" rel="stylesheet" />

    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=2.0"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>
    <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js?v=0.101"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="Term.js"></script>
    <script src="../Scripts/choosen/chosen.jquery.js"></script>
    <script src="../Scripts/choosen/prism.js"></script>

    <style>
        .course_form_selecta {
            margin-bottom: 20px;
        }

            .course_form_selecta label {
                float: left;
                color: #666666;
                font-size: 14px;
                line-height: 30px;
            }

            .course_form_selecta .chosen-select {
                width: 178px;
            }

        .chosen-container {
            float: left;
        }

        .course_form_img {
            width: 258px;
            height: 124px;
            border: 1px solid #1783c7;
            overflow: hidden;
            position: absolute;
            right: 0px;
            top: 0px;
        }

            .course_form_img .change_picture { /*width:90px;height: 24px;line-height: 24px;background: #40bb6b;*/
                text-align: center;
                display: block;
                font-size: 12px;
                position: absolute;
                right: 0;
                top: 0;
                color: #fff;
                z-index: 2;
                cursor: pointer;
                margin-top: 0px;
            }
    </style>


</head>
<body style="background: #fff;">
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">

        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">

                <div class="course_form_div fl">
                    <label for="">学生名称：</label>
                    <label for="" id="Name"></label>
                </div>
                <div class="course_form_div fr">
                    <label for="">学生性别：</label>
                    <label for="" id="Sex"></label>
                </div>
                <div style="clear: both"></div>
                <div class="course_form_div fl">
                    <label for="">联系电话：</label>
                    <label for="" id="ContactPhone"></label>
                </div>
                <div class="course_form_div fr">
                    <label for="">毕业学校：</label>
                    <label for="" id="GraduSchol"></label>
                </div>
                <div style="clear: both"></div>
                <div class="course_form_div fl">
                    <label for="">考试分数：</label>
                    <label for="" id="Score"></label>
                </div>

                <div style="clear: both"></div>

                <div class="course_form_select fl">
                    <label for="">家庭住址：</label>
                    <label for="" id="Address"></label>
                </div>

                <div style="clear: both"></div>
                <div class="course_form_select fl">
                    <label for="">兴趣爱好：</label>
                    <label for="" id="Intrested"></label>
                </div>
                <div style="clear: both"></div>
                <div class="course_form_select fl">
                    <label for="">审核：</label>
                    <select id="Status">
                        <option value="">==选择状态==</option>
                        <option value="1">通过</option>
                        <option value="2">不通过</option>
                    </select>
                </div>
                <div class="course_form_div clearfix" style="text-align: center;">
                    <input type="button" class="course_btn confirm_btn" onclick="Save()" id="btnCreate" value="确定" style="border: none;" />
                </div>

            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script src="../Scripts/Webuploader/dist/webuploader.js"></script>


    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            getData()
        })
        function Save() {
            var Status = $("#Status").val();
            if (Status == "") {
                layer.msg('请选择审核状态');
            }
            else {
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "Recruit/RecruitHandler.ashx", "Func": "Check", "ID": UrlDate.ID, Status: $("#Status").val()
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            getData();
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
        //获取数据
        function getData() {
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "Recruit/RecruitHandler.ashx", "Func": "GetStuInfo", IsPage: "false", "ID": UrlDate.ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $.each(json.result.retData, function () {
                            $("#Name").html(this.Name);
                            $("#Sex").html(this.Sex);//.children('span').attr("value").trim();
                            $("#ContactPhone").html(this.ContactPhone);
                            $("#GraduSchol").html(this.GraduSchol);
                            $("#Score").html(this.Score);
                            $("#Address").html(this.Address);
                            $("#Intrested").html(this.Intrested);
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

    </script>
</body>
</html>
