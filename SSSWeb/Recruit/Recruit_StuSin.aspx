<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Recruit_StuSin.aspx.cs" Inherits="SSSWeb.Recruit.Recruit_StuSin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>学生报名</title>
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
                    <input type="text" placeholder="学生名称" class="text" id="Name" />
                    <i class="stars"></i>
                </div>
                <div class="course_form_div fr">
                    <label for="">学生性别：</label>
                    <input type="text" placeholder="学生性别" class="text" id="Sex" />
                    <i class="stars"></i>
                </div>
                <div style="clear: both"></div>
                <div class="course_form_div fl">
                    <label for="">联系电话：</label>
                    <input type="text" placeholder="联系电话" class="text" id="ContactPhone" />
                    <i class="stars"></i>
                </div>
                <div class="course_form_div fr">
                    <label for="">毕业学校：</label>
                    <input type="text" placeholder="毕业学校" class="text" id="GraduSchol" />
                    <i class="stars"></i>
                </div>

                <div class="course_form_div fl" style="margin-top: 0;">
                    <label for="">考试分数：</label>
                    <input type="text" placeholder="考试分数" class="text" id="Score" />
                    <i class="stars"></i>
                </div>

                <div style="clear: both"></div>

                <div class="course_form_select" style="margin-top: 0;">
                    <label for="">家庭住址：</label>
                    <textarea name="" rows="" cols="" id="Address"></textarea>
                </div>

                <div style="clear: both"></div>
                <div class="course_form_select">
                    <label for="">兴趣爱好：</label>
                    <textarea name="" rows="" cols="" id="Intrested"></textarea>
                </div>


                <div class="course_form_div clearfix" style="text-align: center;">
                    <input type="button" class="course_btn confirm_btn" onclick="Add()" id="btnCreate" value="确定" style="border: none;" />
                </div>

            </div>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script src="../Scripts/Webuploader/dist/webuploader.js"></script>


    <script>
        var UrlDate= new GetUrlDate();
        //添加数据
        function Add() {

            var CreateUID = '<%=UserInfo.UniqueNo%>';
            var Name = $("#Name").val().trim();
            var Sex = $("#Sex").val();//.children('span').attr("value").trim();
            var ContactPhone = $("#ContactPhone").val();
            var GraduSchol = $("#GraduSchol").val();
            var Score = $("#Score").val();
            var Address = $("#Address").val();
            var Intrested = $("#Intrested").val();

            if (!Name || !Sex || !ContactPhone || !GraduSchol || !Score) {
                layer.msg("学生姓名、性别、联系电话、毕业院校、考试分数不能为空！");
            }
            else {
                $.ajax({
                    url: "../Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "Recruit/RecruitHandler.ashx", func: "SinIn", Name: Name, Sex: Sex, ContactPhone: ContactPhone,
                        GraduSchol: GraduSchol, Score: Score, Address: Address, Intrested: Intrested, InfoNo: UrlDate.InfoNo
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            parent.layer.msg('操作成功!');
                            parent.getData(1, 10);
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

    </script>
</body>
</html>
