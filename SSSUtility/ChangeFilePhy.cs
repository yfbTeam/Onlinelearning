using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SSSUtility
{
    public class ChangeFilePhy
    {

        public static string widthOfFile = "800";                       //flv文件的宽度 
        public static string heightOfFile = "450";
        /*
          /*-y（覆盖输出文件，即如果1.***文件已经存在的话，不经提示就覆盖掉了） 
-i "1.avi"（输入文件是和ffmpeg在同一目录下的1.avi文件，可以自己加路径，改名字） 
-title "Test"（在PSP中显示的影片的标题） 
-vcodec xvid（使用XVID编码压缩视频，不能改的） 
-s 368x208（输出的分辨率为368x208，注意片源一定要是16:9的不然会变形） 
-r 29.97（帧数，一般就用这个吧） 
-b 1500（视频数据流量，用-b xxxx的指令则使用固定码率，数字随便改，1500以上没效果；还可以用动态码率如：-qscale 4和-qscale 6，4的质量比6高） 
-acodec aac（音频编码用AAC） 
-ac 2（声道数1或2） 
-ar 24000（声音的采样频率，好像PSP只能支持24000Hz） 
-ab 128（音频数据流量，一般选择32、64、96、128） 
-vol 200（200%的音量，自己改） 
-f psp（输出psp专用格式） 
-muxvb 768（好像是给PSP机器识别的码率，一般选择384、512和768，我改成1500，PSP就说文件损坏了） 
"1.***"（输出文件名，也可以加路径改文件名） */

        //flv文件的高度 
        #region 运行FFMpeg的视频解码，(这里是绝对路径)(视频互转)
        /// <returns>成功:返回图片虚拟地址;   失败:返回空字符串</returns> 
        /// <summary>
        /// 运行FFMpeg的视频解码，(这里是绝对路径) 转换文件并保存在指定文件夹下面(这里是绝对路径) 
        /// </summary>
        /// <param name="fileName">上传视频文件的路径（原文件）</param>
        /// <param name="playFile">转换后的文件的路径（网络播放文件）</param>
        /// <param name="ffmpeg">ffmpeg.exe文件路径</param>
        public void ChangeFile(string fileName, string playFile, string ffmpeg, string ChangeType)
        {
            //取得ffmpeg.exe的路径,路径配置在Web.Config中,如:<add   key="ffmpeg"   value="E:aspx1ffmpeg.exe"   />    
            if ((!System.IO.File.Exists(ffmpeg)) || (!System.IO.File.Exists(fileName)))
            {
                return;
            }
            //获得图片和(.flv)文件相对路径/最后存储到数据库的路径,如:/Web/User1/00001.jpg    
            string flv_file = System.IO.Path.ChangeExtension(playFile, ".mp4");
            //截图的尺寸大小,配置在Web.Config中,如:<add   key="CatchFlvImgSize"   value="240x180"   />    
            // string FlvImgSize = sizeOfImg;
            ProcessStartInfo FilestartInfo = new ProcessStartInfo(ffmpeg);
            FilestartInfo.WindowStyle = ProcessWindowStyle.Hidden;
            //FilestartInfo.Arguments = " -i " + fileName + " -ab 56 -ar 22050 -b 1500 -r 15 -s " + widthOfFile + "x" + heightOfFile + " " + flv_file;
            if (ChangeType == "video")
            {
                FilestartInfo.Arguments = " -i " + fileName + " -ab 128 -ar 22050 -qscale 6 -r 29.97 -s " + widthOfFile + "x" + heightOfFile + " " + flv_file;
            }
            else
            {
                FilestartInfo.Arguments = " -i " + fileName + " " + flv_file;
            }

            //ImgstartInfo.Arguments = "   -i   " + fileName + "   -y   -f   image2   -t   0.05   -s   " + FlvImgSize + "   " + flv_img; 
            try
            {
                //转换 
                Process.Start(FilestartInfo);
            }
            catch (Exception ex)
            {
                string errMsg = ex.Message;
                LogService.WriteErrorLog(errMsg);
            }

        }

        #endregion

        
    }
}
