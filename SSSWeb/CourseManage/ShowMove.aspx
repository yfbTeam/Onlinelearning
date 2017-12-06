<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowMove.aspx.cs" Inherits="SSSWeb.CourseManage.ShowMove" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <%--<script src="http://html5media.googlecode.com/svn/trunk/src/html5media.min.js"></script>--%>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.01"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="weike" style="height:400px;">
            <%--<video src="/PubFolder/微课/1、倒计时的UI设计.mp4" controls="controls" width="520" height="400"/>--%>
        </div>
    </form>
</body>
<script src="../Scripts/sewise-player/sewise.player.min.js"></script>
<script type="text/javascript">
    var UrlDate = new GetUrlDate();  
    $(function () {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: { "PageName": "CourseManage/CouseResource.ashx", "Func": "getWeikeByID", ID: UrlDate.ID },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        var extindex = this.AbsFileUrl.lastIndexOf('.');
                        var curtype = this.AbsFileUrl.substring(extindex + 1);
                        var befurl = this.AbsFileUrl.substring(0, extindex + 1);
                        SewisePlayer.setup({
                            server: "vod",
                            type: curtype,
                            videourl: befurl + curtype,
                            lang: 'zh_CN',
                            poster: "../images/video.png",
                            skin: "vodFoream",
                            topbardisplay: "disable",
                            fallbackurls: {
                                mp4: befurl + "mp4",
                                ogg: befurl + "ogg",
                                webm: befurl + "webm",
                                m3u8: befurl + "m3u8"
                            }
                        }, "weike");
                        //SewisePlayer.toPlay(this.AbsFileUrl, "", 0, true)
                        //$("#weike").html("<video width=\"570\" height=\"330\" src=\"" + this.FileUrl + "\" poster=\"" + this.vidoeImag + "\" autoplay=\"autoplay\" preload=\"none\" controls=\"controls\"></video>");
                    })
                }
                else {
                    layer.msg(json.result.errMsg);
                }

            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        })
    })
</script>
</html>

