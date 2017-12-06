<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModelAdd.aspx.cs" Inherits="SSSWeb.AppManage.ModelAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />

    <title></title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="css/colorpicker.css" rel="stylesheet" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>
    <script src="Scripts/jquery.js"></script>
    <script src="Scripts/colorpicker.js"></script>

    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            $('#picker').farbtastic('#color');
            CatoryModel();
            if (UrlDate.ID != undefined) {
                getData();
            }
        });
        function CatoryModel() {
            $("#ModelType").html("");
            $.ajax({
                url: "../Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "ModelCatogory", "Status": "1" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#ModelType").append("<option value='" + this.ID + "'>" + this.Name + "</option>");
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
        function AddModol() {
            var ModelName = $("#ModelName").val();
            var ModelType = $("#ModelType").val();
            var OpenType = $("#OpenType").val();
            var ModelCss = $("#color").val();
            var iconCss = $("#icoName").val();
            var LinkUrl = $("#LinkUrl").val();
            var OrderNum = $("#OrderNum").val();
            var ID = UrlDate.ID;
            var Pid = UrlDate.Pid;

            if (ID == "undefined" || ID == undefined) {
                ID = "";
            }
            if (!ModelName.length || ModelType == "") {
                layer.msg("请填写完模块名称,选择模块分类！");
            }
            else {
                $.ajax({
                    url: "../Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "Func": "AddModol",
                        ID: ID,
                        ModelName: ModelName,
                        ModelType: ModelType,
                        OpenType: OpenType,
                        ModelCss: ModelCss,
                        iconCss: iconCss,
                        LinkUrl: LinkUrl,
                        OrderNum: OrderNum,
                        MenuType: $("#MenuType").val(),
                        Pid: Pid,
                        UniqueNo: "<%=UserInfo.UniqueNo%>"


                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            parent.layer.msg('操作成功!');
                            parent.getData(1, 10);
                            parent.CloseIFrameWindow();
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
        function getData() {

            $.ajax({
                url: "../Hander/ModelHander.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "GetModelList", ID: UrlDate.ID, Ispage: 'false' },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#ModelName").val(this.ModelName);
                            $("#ModelType").val(this.ModelType);
                            $("#OpenType").val(this.OpenType);
                            $("#ModelCss").val(this.ModelCss);
                            $("#icoName").val(this.iconCss);
                            $("#LinkUrl").val(this.LinkUrl);
                            $("#color").val(this.ModelCss);
                            $("#OrderNum").val(this.OrderNum);

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
        function ChangeShow() {
            if ($("#MenuType").val() == "2") {
                $(".fr").hide();
                $("#bgColor").hide();
            }
            else {
                $(".fr").show();
                $("#bgColor").show();
            }
        }

    </script>

</head>
<body style="background: #fff">
    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="fl" style="width: 50%;">
                        <div class="course_form_select clearfix">
                            <label for="">菜单类型：</label>
                            <select id="MenuType" onchange="ChangeShow()">
                                <option value="1" selected="selected">菜单</option>
                                <option value="2">按钮</option>

                            </select>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">菜单名称：</label>
                            <input type="text" placeholder="菜单名称" class="text" id="ModelName" value="" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">菜单排序：</label>
                            <input type="text" placeholder="菜单排序" class="text" id="OrderNum" value="0" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">链接地址：</label>
                            <input type="text" placeholder="链接地址" class="text" id="LinkUrl" value="" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix" style="margin-top: 90px;" id="bgColor">
                            <label for="">背景颜色：</label>

                            <input type="text" id="color" name="color" value="#123456" style="background-color: rgb(72, 86, 18); color: rgb(255, 255, 255);" class="text" />

                        </div>
                    </div>
                    <div class="fr" style="width: 50%;">
                        <div class="course_form_select clearfix">
                            <label for="">模块分类：</label>
                            <select id="ModelType">
                            </select>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_select clearfix">
                            <label for="">打开方式：</label>
                            <select id="OpenType">
                                <option value="_self">当前页</option>
                                <option value="_blank" selected="selected">新页面</option>
                            </select>
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_select clearfix">
                            <label for="">图标名称：</label>
                            <select id="icoName">
                                <option value="ziyuanku" selected="selected">资源库</option>
                                <option value="zichanguanli">资产管控</option>
                                <option value="shebei">设备保修</option>
                                <option value="renshidangan-copy">人事档案</option>
                                <option value="bangongyongpin">办公用品</option>
                                <option value="kaoping">综合考评</option>
                                <option value="gongzichaxun">工资查询</option>
                                <option value="qingjia">请假管理</option>
                                <option value="adress_num">即时通讯</option>
                                <option value="yunpan">教师云盘</option>
                                <option value="xiaoxizhongxin">信件中心</option>
                                <option value="lease-resv-2home">设备预约</option>
                                <option value="ziyuanku">门户系统</option>
                                <option value="tongzhigonggao">通知通告</option>
                                <option value="ziyuanku">学生成长</option>
                                <option value="ziyuan">资源预定</option>
                                <option value="duanxin">短信平台</option>
                                <option value="17wenjuandiaocha">问卷调查</option>
                                <option value="xxzx">消息中心</option>
                                <option value="icon50">电子档案</option>
                                <option value="shanxiyidongduankaoqinjiankongzhishikushouye03">教研学习</option>
                                <option value="icon50">教师成长档案</option>
                                <option value="keyan01">科研管理</option>
                                <option value="kqqj">教师考勤</option>
                                <option value="xietong">协同备课</option>
                                <option value="gongwenbaoxian">公文管理</option>
                                <option value="shangpinshengou">物品申购</option>
                                <option value="tubiaofuben80">资金审批</option>
                                <option value="zhibananpai">值班申报</option>
                                <option value="wodeyiqiatong">校园一卡通</option>
                                <option value="ziyuanku1">标准资源库</option>
                                <option value="ziyuanguanli">资源管理</option>
                                <option value="ziyuanzu">校本资源库</option>
                                <option value="kechengguanli">课程管理</option>
                                <option value="heduishijuan">在线组卷</option>
                                <option value="genghuanhuiji">学籍管理</option>
                                <option value="renwukecheng">开课管理</option>
                                <option value="xuanke">在线选课</option>
                                <option value="jiaowuguanli">考务管理</option>
                                <option value="review">网上阅卷</option>
                                <option value="shujufenxi">成绩分析</option>
                                <option value="pingjia">教学评价</option>
                                <option value="chengzhang">学生成长</option>
                                <option value="shouquanguanli">认证中心</option>
                                <option value="menhuguanli">门户管理</option>
                                <option value="guanfangrenzheng">数据中心</option>
                                <option value="fenxibaobiao">校决策分析</option>
                                <option value="xuanke">学习中心</option>
                                <option value="yuanchengjiaoxue">远程教学平台</option>
                                <option value="xuexiao">学校</option>

                            </select>
                            <%--<input type="text" placeholder="图标名称" class="text" id="iconCss" />--%>
                            <i class="stars"></i>
                        </div>

                        <div id="picker" style="width: 195px; height: 195px; padding-left: 40px;"></div>
                    </div>
                    <div class="clear"></div>
                    <div class="course_form_select clearfix" style="text-align: center; margin-top: 20px;">
                        <a class="course_btn confirm_btn" onclick="AddModol()" id="btnCreate">确定</a>
                    </div>

                </div>
            </div>
        </div>
    </form>


</body>
</html>
