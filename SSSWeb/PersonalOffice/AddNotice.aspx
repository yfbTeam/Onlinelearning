<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddNotice.aspx.cs" Inherits="SSSWeb.PersonalOffice.AddNotice" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>通知公告</title>
    <link type="text/css" rel="stylesheet" href="/ZZSX/css/common.css" />
    <link type="text/css" rel="stylesheet" href="/ZZSX/css/style.css" />
    <link type="text/css" rel="stylesheet" href="/ZZSX/css/iconfont.css" />
    <link type="text/css" rel="stylesheet" href="/ZZSX/css/animate.css" />
    <link href="/ZZSX/css/style.css" rel="stylesheet" />
    <link href="../Scripts/layer/skin/layer.css" rel="stylesheet" />

    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/KindUeditor/kindeditor.js"></script>
    <script src="../Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="../Scripts/KindUeditor/lang/zh_CN.js"></script>

    <link href="../Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="../Scripts/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script src="../Scripts/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <script src="../Scripts/zTree/js/jquery.ztree.exedit-3.5.js"></script>
</head>
<body>
    <div class="MenuDiv New_announcement">
        <div class="people_choose none" >
            <h3 class="tit">可阅人<em class="xing">*</em></h3>
            <div class="content_zz">
                <ul id="treeEnter" class="ztree"></ul>

            </div>
        </div>
        <div class="form_right">
            <table class="tbEdit">
                <tbody>
                    <tr>
                        <td class="mi">标题<em class="xing">*</em></td>
                        <td class="ku">
                            <input name="" type="text" id="Title">
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">类别<em class="xing">*</em></td>
                        <td class="ku">
                            <select name="" id="Type">
                                <option value="1" selected="selected">系统通知</option>
                                <option value="2">学校公告</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">是否置顶</td>
                        <td class="ku">
                            <select name="" id="IsTop">
                                <option value="0">否</option>
                                <option value="1" selected="selected">是</option>

                            </select></td>
                    </tr>
                    <tr>
                        <td class="mi">发送对象</td>

                        <td class="ku">
                            <select name="" id="IsAll" onchange="UserType()">
                                <option value="0">部分用户</option>
                                <option value="1" selected="selected">全部用户</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">内容<em class="xing">*</em></td>
                        <td class="ku">
                            <textarea name="" id="content" class="content"></textarea>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
        <div class="clear"></div>

        <div class="t_btn">
            <input id="btnAdd" class="btn" onclick="Save()" type="button" value="保存">
        </div>
    </div>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        function UserType() {
            var IsAll = $("#IsAll").val();
            if (IsAll == "0") {
                $(".people_choose").show();
            }
            else {
                $(".people_choose").hide();
            }
        }
        function Save() {
            var zTree = $.fn.zTree.getZTreeObj("treeEnter");
          
            var nodes = []
            if (zTree != null) {
                nodes = zTree.getChangeCheckedNodes(true);
            }
            var IsAll = $("#IsAll").val();
            var Title = $("#Title").val();
            var Content = $("#content").val();

            var User = '';
            var Org = "";
            if (nodes.length == 0 && IsAll == "0") {
                layer.msg("请选择用户");
            }
            else {

                for (var i = 0; i < nodes.length; i++) {
                    var halfCheck = nodes[i].getCheckStatus();
                    if (!halfCheck.half && nodes[i].children != undefined) {
                        Org += nodes[i].id + ','
                    }
                    if (!halfCheck.half && nodes[i].children == undefined) {
                        if ((',' + Org).indexOf(',' + nodes[i].pId + ',') < 0) {
                            User += nodes[i].id + ','
                        }
                    }

                }
                User = User.substring(0, User.lastIndexOf(","));
                Org = Org.substring(0, Org.lastIndexOf(","));
                if (!Title) {
                    layer.msg("请输入标题");
                }
                else if (!Content) {
                    layer.msg("请输入内容");
                }
                else {
                    $.ajax({
                        url: "../Common.ashx",
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            "PageName": "SystemSettings/NoticeManage.ashx",
                            func: "AddNotice", Title: Title, Content: encodeURI(Content),
                            ReviwerOrgS: Org, ReviwerUserIDS: User, CreateUID: '<%=UserInfo.UniqueNo%>',
                            IsAll: $("#IsAll").val(), IsTop: $("#IsTop").val(), Type: $("#Type").val(), ID: UrlDate.ID
                        },
                        success: function (json) {
                            var result = json.result;
                            if (result.errNum == 0) {
                                parent.layer.msg('成功!');
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
        }
        var zNodes = [];

        var setting = {
            view: {
                //addHoverDom: addHoverDom,
                //removeHoverDom: removeHoverDom,
                selectedMulti: true
            },
            data: {
                keep: {
                    parent: true,
                    leaf: true
                },
                simpleData: {
                    enable: true
                }
            },
            check: {
                enable: true
            },
            callback: {
                //beforeDrag: beforeDrag,
                //beforeEditName: beforeEditName,
                //beforeRemove: beforeRemove,
                //beforeRename: beforeRename,
                //onRemove: onRemove,
                //onRename: onRename,
                //beforeClick: beforeClick,
                //onClick: onClick
            }

        };
        var log, className = "dark";
        function beforeClick(treeId, treeNode, clickFlag) {
            className = (className === "dark" ? "" : "dark");
            //showLog("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.name);
            return (treeNode.click != false);
        }

        $(function () {
            KindEditor.ready(function (K) {
                window.editor = K.create('#content', {
                    'uploadJson': '/CourseManage/Uploade.ashx?Func=SetNoticeImg',
                    //'formData': { Func: "SetNoticeImg" }, //参数
                    minWidth: '480px',
                    allowFileManager: false,//true时显示浏览服务器图片功能。
                    allowImageRemote: false,//网络图片
                    resizeType: 0,
                    items: [
                    'source', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', "strikethrough",
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'undo', 'redo', '|', 'emoticons', 'image', 'link'],
                    afterFocus: function () {
                        //self.edit = edit = this; var strIndex = self.edit.html().indexOf("请添加你的描述..."); if (strIndex != -1) { self.edit.html(self.edit.html().replace("请添加你的描述...", "")); }
                    },
                    //失去焦点事件
                    afterBlur: function () {
                        this.sync(); self.edit = edit = this; if (self.edit.isEmpty()) {
                            //self.edit.html("请添加你的描述...");
                        }
                    },
                    afterUpload: function (data) {
                        //if (data.result) {
                        //    //data.url 处理
                        //} else {

                        //}
                    },
                    afterError: function (str) {
                        //alert('error: ' + str);
                    }
                });
            });
            GetNave();
            if (UrlDate.ID == null || UrlDate.ID == undefined && UrlDate.ID == "") {
                //GetNave();
                //$(".people_choose").show();

            }
            else {
                //$(".people_choose").hide();
                GetNoticeByID();
            }
        })
        function GetNoticeByID() {
            var zTree = $.fn.zTree.getZTreeObj("treeEnter");

            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "SystemSettings/NoticeManage.ashx", "Func": "GetData", IsPage: "false", ID: UrlDate.ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#Title").val(this.Title);
                            $("#content").val(this.Content);//.children('span').attr("value", this.CourceType)
                            $("#IsAll").val(this.IsAll);
                            $("#IsTop").val(this.IsTop);
                            $("#Type").val(this.Type);
                            var IsAll = $("#IsAll").val();
                            if (IsAll == "0") {
                                $(".people_choose").show();
                                var zTree = $.fn.zTree.getZTreeObj("treeEnter");

                                var ids = this.ReviwerOrgS + ',' + this.ReviwerUserIDS;
                                var idsArry = ids.split(',');
                                for (var i = 0; i < idsArry.length; i++) {
                                    if (idsArry[i]!="") {
                                        var node = zTree.getNodeByParam("id", idsArry[i]);
                                        zTree.checkNode(node, true, true);

                                    }
                                }

                                //node.checked = true;
                                //this.ReviwerOrgS
                                //this.ReviwerUserIDS
                            }
                            else { $(".people_choose").hide(); }
                        });
                    }
                    else {

                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });

        }
        var dtJson = [];
        var pid = ",";
        //导航绑定
        function GetNave() {
            $.ajax({
                type: "post",
                url: "../SystemSettings/CommonInfo.ashx",
                data: { Func: "GetUserInfoData", "Ispage": "false", "IsStu": "false" },
                dataType: "json",
                async:false,
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {

                            if ((pid + ",").indexOf(',' + this.RegisterOrg + ',') < 0) {
                                var User = new Object();
                                User.id = this.RegisterOrg;
                                User.type = 2;
                                User.pId = 0;
                                User.name = this.OrgName;
                                dtJson.push(User);
                                pid += this.RegisterOrg + ","
                            }
                            if (pid.indexOf(this.RegisterOrg) > 0) {
                                var User1 = new Object();

                                User1.id = this.UniqueNo;
                                User1.type = 2;
                                User1.pId = this.RegisterOrg;
                                User1.name = this.Name;
                                dtJson.push(User1);
                            }
                        })
                    }
                    //var dtJson = [{ "id": 1, "root": "1", "pId": 0, "name": "教学" }, { "id": 5, "root": "5", "pId": 1, "name": "语文" }, { "id": 6, "root": "6", "pId": 1, "name": "数学" }, { "id": 7, "root": "7", "pId": 1, "name": "英语" }, { "id": 8, "root": "8", "pId": 1, "name": "计算机" }, { "id": 2, "root": "2", "pId": 0, "name": "招生" }, { "id": 9, "root": "9", "pId": 2, "name": "招生" }, { "id": 3, "root": "3", "pId": 0, "name": "社团" }, { "id": 10, "root": "10", "pId": 3, "name": "社团" }, { "id": 4, "root": "4", "pId": 0, "name": "活动" }, { "id": 11, "root": "11", "pId": 4, "name": "活动" }];
                    ////dtJson = $.parseJSON(dtJson);
                    $.fn.zTree.init($("#treeEnter"), setting, dtJson);
                    var treeObj = $.fn.zTree.getZTreeObj("treeEnter");
                    //treeObj.expandAll(true);
                },
                error: function (errMsg) {
                    alert('数据加载失败！');
                }
            });
        }

        function treeClick() {
            this.close();
        }
        //导航点击事件
        function onClick(event, treeId, treeNode, clickFlag) {
            //console.info(treeNode);
            fun_getCheckValue();
        }


    </script>
</body>
</html>
