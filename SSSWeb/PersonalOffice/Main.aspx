<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="SSSWeb.PersonalOffice.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <link type="text/css" rel="stylesheet" href="../ZZSX/css/common.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/iconfont.css" />
    <link type="text/css" rel="stylesheet" href="../ZZSX/css/animate.css" />
    <link href="../css/sprite.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Common.js"></script>
    <link href="../Scripts/layer/skin/layer.ext.css" rel="stylesheet" />
    <script src="../Scripts/layer/layer.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <div class="rfmain">
            <input id="hdType" type="hidden" />

            <div class="stindex clearfix">
                <div class="stindex_rflf fl">
                    <dl class="xxk_gonggao_aa">
                        <dt class="ty_biaoti">
                            <span class="active">学校公告</span>
                            <%--<p onclick="showmybulletin()">更多+</p>--%>
                        </dt>
                        <dd>
                            <ul id="schoolbulletin">

                                <%--                                <li class="ali"><i>2</i><a onclick="showContent(10)" href="#">京西太平鼓亮相国际吉首鼓文化节</a><span>2/21 </span></li>
                                <li class="ali"><i>3</i><a onclick="showContent(9)" href="#">魅力京西 魅力中职</a><span>2/21 </span></li>
                                <li class="ali"><i>4</i><a onclick="showContent(8)" href="#">走出校门 谋发展 促共赢</a><span>2/21 </span></li>
                                <li class="ali"><i>5</i><a onclick="showContent(7)" href="#">艺术展</a><span>12/18</span></li>
                                <li class="ali"><i>6</i><a onclick="showContent(6)" href="#">12月18日足球赛</a><span>12/18</span></li>--%>
                            </ul>
                        </dd>
                    </dl>
                    <dl class="my_ziyuan">
                        <dt class="ty_biaoti">
                            <span class="active">我的资源</span>
                            <%--<p onclick="Moredoc()">更多+</p>--%>
                        </dt>
                        <dd id="my_ziyuan">
                            <%-- <ol>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icmp4.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/语文组112/知识生产143.mp4">知识生产.mp4</a><span>3/2 1</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icmp4.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/英语组114/知识生产143.mp4">知识生产.mp4</a><span>3/2 1</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icdocx.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/政教处83/1、北京市门头沟区中等职业学校数字化校园_用户使用手册 - 教师使用110.docx">1、北京市.docx</a><span>11/2 </span></li>
                            </ol>
                            <ol>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icwma.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/新消息81.mp3">新消息.wma</a><span>12/18</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icdocx.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/新建 Microsoft Word 文档80.docx">新建 Mi.docx</a><span>12/18</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icxlsx.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/新建 Microsoft Excel 工作表79.xlsx">新建 Mi.xlsx</a><span>12/18</span></li>
                            </ol>--%>
                        </dd>
                    </dl>
                </div>
                <div class="stindex_rfrf fr">
                    <dl class="xxk_gonggao_aa">
                        <dt class="ty_biaoti">
                            <span class="active">通知
                            </span>
                            <%--<p><a onclick="MoreTip()" href="#">更多+</a></p>--%>
                        </dt>
                        <dd>
                            <ul id="tongzhi">
                                <%--                                <li class="ali"><i>1</i><a style="cursor: pointer;" onclick="TipDetile(185)">教室预定审批消息</a><a class="weidu"></a><span>3/12 </span></li>
                                <li class="ali"><i>2</i><a style="cursor: pointer;" onclick="TipDetile(184)">啊啊提交了资源预定申请</a><a class="weidu"></a><span>3/12 </span></li>
                                <li class="ali"><i>3</i><a style="cursor: pointer;" onclick="TipDetile(183)">课程【晒是】审核通过:</a><a class="weidu"></a><span>3/12 </span></li>
                                <li class="ali"><i>4</i><a style="cursor: pointer;" onclick="TipDetile(182)">校本课程-新建课程待审核</a><a class="weidu"></a><span>3/12 </span></li>
                                <li class="ali"><i>5</i><a style="cursor: pointer;" onclick="TipDetile(181)">教室预定审批消息</a><a class="weidu"></a><span>3/2 1</span></li>--%>
                            </ul>
                        </dd>
                    </dl>
                </div>
                <div class="stindex_rfrf fr">
                    <dl class="stu_xinxi">
                        <dt class="ty_biaoti">
                            <span class="active">学校信息</span>
                            <p>更多+</p>
                        </dt>
                        <dd>
                            <ul>
                                <li>
                                    <i class="iconfont"></i>
                                    <a href="#">教师1000余人</a>
                                </li>
                                <li>
                                    <i class="iconfont"></i>
                                    <a href="#">教室500余间</a>
                                </li>
                                <li>
                                    <i class="iconfont"></i>
                                    <a href="#">学校资源丰富</a>
                                </li>
                                <li>
                                    <i class="iconfont"></i>
                                    <a href="#">学科专业15种</a>
                                </li>

                            </ul>
                        </dd>
                    </dl>
                </div>
            </div>
            <div class="stindex clearfix">
                <div class="stindex_lfcontent fl">
                    <dl>
                        <dt class="ty_biaoti">
                            <span class="active">最新课程</span>
                            <%--<p onclick="MoreCource">更多+</p>--%>
                        </dt>
                        <dd class="newkc_list"></dd>
                    </dl>

                </div>
                <div class="stindex_rfcontent fr">
                    <dl class="my_ziyuan">
                        <dt class="ty_biaoti">
                            <span class="active">热门资源</span>
                            <p onclick="Moredoc()">更多+</p>
                        </dt>
                        <dd>
                            <ul id="ActiveDoc">
                                <%--                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/iccss.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/style175.css">style.css</a><span>12/18</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/iczip.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/swfobject_2_276.zip">swfob.zip</a><span>12/18</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icjpg.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/老师 277.jpg">老师 2.jpg</a><span>12/18</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icpng.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/门户78.png">门户.png</a><span>12/18</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icxlsx.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/新建 Microsoft Excel 工作表79.xlsx">新建 Mi.xlsx</a><span>12/18</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icdocx.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/新建 Microsoft Word 文档80.docx">新建 Mi.docx</a><span>12/18</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icwma.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/行政组71/新消息81.mp3">新消息.wma</a><span>12/18</span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icpng.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/常用软件84/门户85.png">门户.png</a><span>2/19 </span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icxlsx.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/常用软件84/新建 Microsoft Excel 工作表 (2)87.xlsx">新建 Mi.xlsx</a><span>2/19 </span></li>
                                <li><i class="iconfont">
                                    <img src="/_layouts/15/images/icjs.gif"></i><a href="../sites/DigitalCampus/Library/DocLib/常用软件84/common88.js">commo.js</a><span>2/19 </span></li>--%>
                            </ul>
                        </dd>
                    </dl>
                </div>
            </div>


        </div>
        <script type="text/javascript">

            $(function () {
                InitNotice();
                MyResource();
                HotResource();
                BindCourse();
            })
            function ShowNotice(Title, Content, obj) {
                layer.tips('标题：' + Title + '</br>内容：' + Content, obj, {
                    tips: [2, '#3595CC']
                });
            }
            function MyResource() {
                var CreateUID = '<%=UserInfo.UniqueNo %>';
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "ResourceManage/ResourceInfoHander.ashx", "Func": "GetPageList", IsPage: "false", CreateUID: CreateUID, "IsFolder": "0" },
                    success: function OnSuccess(json) {
                        if (json.result.errNum.toString() == "0") {
                            var i = 0;
                            $(json.result.retData).each(function () {
                                if (i < 3) {
                                    if (i == 0) {
                                        $("#my_ziyuan").append('<ol id="ol1"></ol>');
                                    }
                                    $("#ol1").append('<li><i class="icon ico-' + this.postfix1 + '-min"></i><a href="' + this.FileUrl + '">' + this.Name + '</a><span>' + this.CreateTime + '</span></li>')
                                    i++;
                                }

                                else if (i >= 3 && i < 6) {
                                    if (i == 3) {
                                        $("#my_ziyuan").append('<ol id="ol2"></ol>');
                                    }

                                    $("#ol2").append('<li><i class="icon ico-' + this.postfix1 + '-min"></i></i><a href="' + this.FileUrl + '">' + this.Name + '</a><span>' + this.CreateTime + '</span></li>')
                                    i++;
                                }
                            })

                        }

                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }
            //课程信息
            function BindCourse() {

                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", IsPage: "false", StuNo: '<%=UserInfo.UniqueNo%>', "Status": "1" },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $(".newkc_list").empty();
                            var i = 0;
                            $(json.result.retData).each(function () {
                                if (i < 6) {
                                    var DefaultImage = "../images/course_default.jpg";
                                    var ShowName = "<a  style='cursor:pointer' onclick='SinUp(" + this.ID + ")'>报名</a>"
                                    if (this.stuNo.toString().length > 0) {
                                        ShowName = "<a class=\"course_enroll\" href='#'>已报名</a>";
                                    }
                                    var href = "/OnlineLearning/StuLessonDetail.aspx?itemid==" + this.ID + "&flag=1";

                                    var ul = " <ul class='fl'><div class=\"sb_fz01\" style=\" width:305px;cursor:pointer\"><img src=\"" + this.ImageUrl
                                    + "\" onerror=\"javascript:this.src='" + DefaultImage +
                                    "'\"><ol class=\"newkc_listxq\"><li><h2>" + this.Name +
                                    "</h2></li><li>" + this.BatchUserName + "</li><li>周一</li></ol></div><div class=\"sb_fz02\" style=\" width:305px;cursor:pointer\" onclick='Detail(\"" + href +
                                    "\")'><div class=\"lf_tp\"><img src='" + this.PhotoURL + "'><h3>" + this.BatchUserName + "</h3></div><div class=\"rf_xq\"><h3>" + this.Name + "</h3><p>" + this.CourseIntro
                                    + "</p></div></div><div class='ssclear'>" + ShowName + "</div></ul>";
                                    i++;
                                    $(".newkc_list").append(ul);
                                }
                            });
                        }
                    },
                    error: function (errMsg) {
                        alert('数据加载失败！');
                    }
                });
            }

            function HotResource() {
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "ResourceManage/PublicResoure.ashx", "Func": "GetPageList", IsPage: "false", "OrderBy": "ClickNum desc" },
                    success: function OnSuccess(json) {
                        if (json.result.errNum.toString() == "0") {
                            var i = 0;
                            $(json.result.retData).each(function () {
                                $("#ActiveDoc").append('<li><i class="icon ico-' + this.postfix1 + '-min"></i><a href="' + this.FileUrl + '">' + this.Name + '</a><span>' + this.CreateTime + '</span></li>')

                            })
                        }

                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });

            }
            //获取数据
            function InitNotice() {
                //初始化序号 
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "SystemSettings/NoticeManage.ashx", "Func": "GetData", IsPage: "false", "UserNo": '<%=UserInfo.UniqueNo%>', "Org": '<%=UserInfo.RegisterOrg%>'
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            var i = 1;
                            var j = 1;

                            $(json.result.retData).each(function () {

                                if (this.Type == "2") {
                                    //var Func = "ShowNotice('" + this.Title + "','" + this.Content + "', this)";
                                    var Func = "ShowNotice(" + this.ID + ", this)";
                                    if (i < 6) {
                                        var li = "<li class=\"ali\"><i>" + i + "</i><a href=\"#\" onclick=\"" + Func + "\">" + this.Title + "</a><span>" + this.CreateTime + " </span></li>";

                                        $("#schoolbulletin").append(li)
                                        i++;
                                    }
                                }
                                else {
                                    var Func = "ShowNotice(" + this.ID + ", this)";
                                    if (j < 6) {
                                        var li = "<li class=\"ali\"><i>" + j + "</i><a href=\"#\" onclick=\"" + Func + "\">" + this.Title + "</a><span>" + this.CreateTime + " </span></li>";
                                        $("#tongzhi").append(li);
                                        j++;
                                    }
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
            function ShowNotice(ID) {
                OpenIFrameWindow("公告详情", 'ShowNotice.aspx?ID=' + ID, '800px', '540px')
            }
        </script>
    </form>
</body>
</html>
