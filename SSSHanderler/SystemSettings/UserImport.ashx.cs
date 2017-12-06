﻿using SSSBLL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSHanderler.SystemSettings
{
    /// <summary>
    /// UserImport 的摘要说明
    /// </summary>
    public class UserImport : IHttpHandler
    {

        Plat_RoleOfUserService bll = new Plat_RoleOfUserService();
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        string sysAccountNo = ConfigHelper.GetConfigString("SysAccountNo");
        string u_handlerUrl = ConfigHelper.GetConfigString("Unified_HandlerUrl").SafeToString();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"].SafeToString();
            if (func == "UserAsync")
            {
                UserAsync(context);
            }
        }
        private void UserAsync(HttpContext context)
        {
            string ReturnResult = "";

            //string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
            //string urlbady = "Func=GetData&IsPage=false";
            //string PageUrl = urlHead + urlbady;
            string result = "{\"result\":{\"retData\":[{\"rowNum\":\"1\",\"Id\":\"1712\",\"UniqueNo\":\"6C868438-910B-40D0-8FF9-29F299E5B567\",\"UserType\":\"3\",\"Name\":\"杨琦\",\"Nickname\":\"杨琦\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015824215\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"2\",\"Id\":\"1711\",\"UniqueNo\":\"8F4C5224-EDD9-4644-8A78-5CB3B9085CF5\",\"UserType\":\"3\",\"Name\":\"李辰\",\"Nickname\":\"李辰\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823213\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"3\",\"Id\":\"1710\",\"UniqueNo\":\"AD6B33FF-D9B7-4180-836C-D777B4FE5383\",\"UserType\":\"3\",\"Name\":\"刘博东\",\"Nickname\":\"刘博东\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823212\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"4\",\"Id\":\"1709\",\"UniqueNo\":\"9FF76B48-E0E0-43C9-94FC-977BB4ED0E0D\",\"UserType\":\"3\",\"Name\":\"范思铭\",\"Nickname\":\"范思铭\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823117\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"5\",\"Id\":\"1708\",\"UniqueNo\":\"0C5D67E6-8612-4E21-AE9B-C4CF6A3D1887\",\"UserType\":\"3\",\"Name\":\"杨天宇\",\"Nickname\":\"杨天宇\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823104\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"6\",\"Id\":\"1707\",\"UniqueNo\":\"E45FE737-0217-4874-88F4-E56D8D96ECEF\",\"UserType\":\"3\",\"Name\":\"彭兴昊\",\"Nickname\":\"彭兴昊\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823111\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"7\",\"Id\":\"1706\",\"UniqueNo\":\"CD878118-1C39-4728-A8C4-B86F6B62D7C9\",\"UserType\":\"3\",\"Name\":\"赵佳亮\",\"Nickname\":\"赵佳亮\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834125\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"8\",\"Id\":\"1705\",\"UniqueNo\":\"5B2B776A-FF6A-4F30-B40A-7AA295B6311A\",\"UserType\":\"3\",\"Name\":\"徐闻谦\",\"Nickname\":\"徐闻谦\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834124\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"9\",\"Id\":\"1704\",\"UniqueNo\":\"7C273390-8BC2-4880-A51D-26355CEFC23A\",\"UserType\":\"3\",\"Name\":\"郗炫华\",\"Nickname\":\"郗炫华\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834123\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"10\",\"Id\":\"1703\",\"UniqueNo\":\"1776E722-00B6-47E4-9AE4-FBDBFC5AB455\",\"UserType\":\"3\",\"Name\":\"杨晨\",\"Nickname\":\"杨晨\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834122\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"11\",\"Id\":\"1702\",\"UniqueNo\":\"3AFB4923-C0C7-4F06-B8F3-4182CF90EA40\",\"UserType\":\"3\",\"Name\":\"赵梓昊\",\"Nickname\":\"赵梓昊\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834121\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"12\",\"Id\":\"1701\",\"UniqueNo\":\"AF60B940-A263-4DF5-8B11-7DDFCEA8D6C6\",\"UserType\":\"3\",\"Name\":\"李振轩\",\"Nickname\":\"李振轩\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834120\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"13\",\"Id\":\"1700\",\"UniqueNo\":\"12A458AA-191B-42BF-8898-4CB3E01AB7AC\",\"UserType\":\"3\",\"Name\":\"刘子嘉\",\"Nickname\":\"刘子嘉\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834119\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"14\",\"Id\":\"1699\",\"UniqueNo\":\"3A73E564-1C4B-4156-B2E4-C7034DD5A2F6\",\"UserType\":\"3\",\"Name\":\"孙傲\",\"Nickname\":\"孙傲\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834118\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"15\",\"Id\":\"1698\",\"UniqueNo\":\"BA7005EF-F8EA-4A15-84A1-EF17BC773BA5\",\"UserType\":\"3\",\"Name\":\"郭云际\",\"Nickname\":\"郭云际\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834117\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"16\",\"Id\":\"1697\",\"UniqueNo\":\"348145E1-3BF7-4D8C-AF77-018CBE06AE5A\",\"UserType\":\"3\",\"Name\":\"肖晴\",\"Nickname\":\"肖晴\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834116\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"17\",\"Id\":\"1696\",\"UniqueNo\":\"96D9531E-5C9E-42FA-BD00-9DA763EA1B3B\",\"UserType\":\"3\",\"Name\":\"衡彤钰\",\"Nickname\":\"衡彤钰\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834115\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"18\",\"Id\":\"1695\",\"UniqueNo\":\"6A201843-98AB-4DED-96EF-326F0A61B6F5\",\"UserType\":\"3\",\"Name\":\"梁嘉诚\",\"Nickname\":\"梁嘉诚\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834114\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"19\",\"Id\":\"1694\",\"UniqueNo\":\"D71A5F82-ED77-4569-988B-1DCC61A65C31\",\"UserType\":\"3\",\"Name\":\"范森斌\",\"Nickname\":\"范森斌\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834113\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"20\",\"Id\":\"1693\",\"UniqueNo\":\"57B80E42-02D6-4A80-A34B-94D66283EF7E\",\"UserType\":\"3\",\"Name\":\"李英卓\",\"Nickname\":\"李英卓\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834112\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"21\",\"Id\":\"1692\",\"UniqueNo\":\"2CB88D66-4E0D-47D5-8508-A22156383041\",\"UserType\":\"3\",\"Name\":\"马啸宇\",\"Nickname\":\"马啸宇\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834111\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"22\",\"Id\":\"1691\",\"UniqueNo\":\"EE1B3B72-002D-4BE3-945A-A98DB667627F\",\"UserType\":\"3\",\"Name\":\"马榕\",\"Nickname\":\"马榕\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834109\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"23\",\"Id\":\"1690\",\"UniqueNo\":\"4E8DEB04-B333-4C4E-BF79-A4ED946413B4\",\"UserType\":\"3\",\"Name\":\"秦梦欣\",\"Nickname\":\"秦梦欣\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834108\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"24\",\"Id\":\"1689\",\"UniqueNo\":\"074A156A-43E8-4951-B6DC-47AFCE2D95BA\",\"UserType\":\"3\",\"Name\":\"李昂\",\"Nickname\":\"李昂\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834107\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"25\",\"Id\":\"1688\",\"UniqueNo\":\"19E1F3BD-66C9-4BD0-B69B-D2F2BFC43F39\",\"UserType\":\"3\",\"Name\":\"张天一\",\"Nickname\":\"张天一\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834106\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"26\",\"Id\":\"1687\",\"UniqueNo\":\"AEF9DAF1-E205-4D5F-89A6-14F4974BAF84\",\"UserType\":\"3\",\"Name\":\"游畅\",\"Nickname\":\"游畅\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834105\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"27\",\"Id\":\"1686\",\"UniqueNo\":\"96DCC47B-20A3-472F-BFE6-A5086E89F119\",\"UserType\":\"3\",\"Name\":\"张思闻\",\"Nickname\":\"张思闻\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834104\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"28\",\"Id\":\"1685\",\"UniqueNo\":\"28C973AB-CBD7-4EEF-929A-FB4ADD375C44\",\"UserType\":\"3\",\"Name\":\"杜传\",\"Nickname\":\"杜传\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834103\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"29\",\"Id\":\"1684\",\"UniqueNo\":\"0CB57FB3-938E-4916-B1D6-E681ED3686F8\",\"UserType\":\"3\",\"Name\":\"杨思诺\",\"Nickname\":\"杨思诺\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834102\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"30\",\"Id\":\"1683\",\"UniqueNo\":\"201C1EF4-588B-4978-9256-4311E882F89B\",\"UserType\":\"3\",\"Name\":\"sinp01\",\"Nickname\":\"sinp01\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"sinp01\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"31\",\"Id\":\"1679\",\"UniqueNo\":\"9EB30161-9E3A-4D09-A967-538A8F6E3FF9\",\"UserType\":\"3\",\"Name\":\"陈炳然\",\"Nickname\":\"陈炳然\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"2017/3/1 0:00:00\",\"LoginName\":\"2016834101\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"http://192.168.1.3:8080/\",\"Email\":\"\"},{\"rowNum\":\"32\",\"Id\":\"1673\",\"UniqueNo\":\"00000000000000000X8\",\"UserType\":\"3\",\"Name\":\"临时0416\",\"Nickname\":\"临时0416\",\"Sex\":\"1\",\"Phone\":\"18254157367\",\"Birthday\":\"2017/1/17 0:00:00\",\"LoginName\":\"linshi0416\",\"Password\":\"e10adc3949ba59abbe56e057f20f883e\",\"IDCard\":\"130990199309091145\",\"HeadPic\":\"\",\"RegisterOrg\":\"1001\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"http://192.168.1.3:8080/\",\"Email\":\"\"},{\"rowNum\":\"33\",\"Id\":\"1672\",\"UniqueNo\":\"00000000000000000X\",\"UserType\":\"1\",\"Name\":\"超级管理员\",\"Nickname\":\"\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"admin\",\"Password\":\"564d9908cf33c34fe112c0b9d36dbe61\",\"IDCard\":\"00000000000000000X\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"}],\"errMsg\":\"success\",\"errNum\":0,\"status\":null}}";

            //string result = "{\"result\":{\"retData\":[{\"rowNum\":\"1\",\"Id\":\"1712\",\"UniqueNo\":\"6C868438-910B-40D0-8FF9-29F299E5B567\",\"UserType\":\"3\",\"Name\":\"杨琦\",\"Nickname\":\"杨琦\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015824215\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"2\",\"Id\":\"1711\",\"UniqueNo\":\"8F4C5224-EDD9-4644-8A78-5CB3B9085CF5\",\"UserType\":\"3\",\"Name\":\"李辰\",\"Nickname\":\"李辰\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823213\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"3\",\"Id\":\"1710\",\"UniqueNo\":\"AD6B33FF-D9B7-4180-836C-D777B4FE5383\",\"UserType\":\"3\",\"Name\":\"刘博东\",\"Nickname\":\"刘博东\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823212\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"4\",\"Id\":\"1709\",\"UniqueNo\":\"9FF76B48-E0E0-43C9-94FC-977BB4ED0E0D\",\"UserType\":\"3\",\"Name\":\"范思铭\",\"Nickname\":\"范思铭\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823117\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"5\",\"Id\":\"1708\",\"UniqueNo\":\"0C5D67E6-8612-4E21-AE9B-C4CF6A3D1887\",\"UserType\":\"3\",\"Name\":\"杨天宇\",\"Nickname\":\"杨天宇\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823104\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"6\",\"Id\":\"1707\",\"UniqueNo\":\"E45FE737-0217-4874-88F4-E56D8D96ECEF\",\"UserType\":\"3\",\"Name\":\"彭兴昊\",\"Nickname\":\"彭兴昊\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2015823111\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"7\",\"Id\":\"1706\",\"UniqueNo\":\"CD878118-1C39-4728-A8C4-B86F6B62D7C9\",\"UserType\":\"3\",\"Name\":\"赵佳亮\",\"Nickname\":\"赵佳亮\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834125\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"8\",\"Id\":\"1705\",\"UniqueNo\":\"5B2B776A-FF6A-4F30-B40A-7AA295B6311A\",\"UserType\":\"3\",\"Name\":\"徐闻谦\",\"Nickname\":\"徐闻谦\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834124\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"9\",\"Id\":\"1704\",\"UniqueNo\":\"7C273390-8BC2-4880-A51D-26355CEFC23A\",\"UserType\":\"3\",\"Name\":\"郗炫华\",\"Nickname\":\"郗炫华\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834123\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"10\",\"Id\":\"1703\",\"UniqueNo\":\"1776E722-00B6-47E4-9AE4-FBDBFC5AB455\",\"UserType\":\"3\",\"Name\":\"杨晨\",\"Nickname\":\"杨晨\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834122\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"11\",\"Id\":\"1702\",\"UniqueNo\":\"3AFB4923-C0C7-4F06-B8F3-4182CF90EA40\",\"UserType\":\"3\",\"Name\":\"赵梓昊\",\"Nickname\":\"赵梓昊\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834121\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"12\",\"Id\":\"1701\",\"UniqueNo\":\"AF60B940-A263-4DF5-8B11-7DDFCEA8D6C6\",\"UserType\":\"3\",\"Name\":\"李振轩\",\"Nickname\":\"李振轩\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834120\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"13\",\"Id\":\"1700\",\"UniqueNo\":\"12A458AA-191B-42BF-8898-4CB3E01AB7AC\",\"UserType\":\"3\",\"Name\":\"刘子嘉\",\"Nickname\":\"刘子嘉\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834119\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"14\",\"Id\":\"1699\",\"UniqueNo\":\"3A73E564-1C4B-4156-B2E4-C7034DD5A2F6\",\"UserType\":\"3\",\"Name\":\"孙傲\",\"Nickname\":\"孙傲\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834118\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"15\",\"Id\":\"1698\",\"UniqueNo\":\"BA7005EF-F8EA-4A15-84A1-EF17BC773BA5\",\"UserType\":\"3\",\"Name\":\"郭云际\",\"Nickname\":\"郭云际\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834117\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"16\",\"Id\":\"1697\",\"UniqueNo\":\"348145E1-3BF7-4D8C-AF77-018CBE06AE5A\",\"UserType\":\"3\",\"Name\":\"肖晴\",\"Nickname\":\"肖晴\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834116\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"17\",\"Id\":\"1696\",\"UniqueNo\":\"96D9531E-5C9E-42FA-BD00-9DA763EA1B3B\",\"UserType\":\"3\",\"Name\":\"衡彤钰\",\"Nickname\":\"衡彤钰\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834115\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"18\",\"Id\":\"1695\",\"UniqueNo\":\"6A201843-98AB-4DED-96EF-326F0A61B6F5\",\"UserType\":\"3\",\"Name\":\"梁嘉诚\",\"Nickname\":\"梁嘉诚\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834114\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"19\",\"Id\":\"1694\",\"UniqueNo\":\"D71A5F82-ED77-4569-988B-1DCC61A65C31\",\"UserType\":\"3\",\"Name\":\"范森斌\",\"Nickname\":\"范森斌\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834113\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"20\",\"Id\":\"1693\",\"UniqueNo\":\"57B80E42-02D6-4A80-A34B-94D66283EF7E\",\"UserType\":\"3\",\"Name\":\"李英卓\",\"Nickname\":\"李英卓\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834112\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"21\",\"Id\":\"1692\",\"UniqueNo\":\"2CB88D66-4E0D-47D5-8508-A22156383041\",\"UserType\":\"3\",\"Name\":\"马啸宇\",\"Nickname\":\"马啸宇\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834111\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"22\",\"Id\":\"1691\",\"UniqueNo\":\"EE1B3B72-002D-4BE3-945A-A98DB667627F\",\"UserType\":\"3\",\"Name\":\"马榕\",\"Nickname\":\"马榕\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834109\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"23\",\"Id\":\"1690\",\"UniqueNo\":\"4E8DEB04-B333-4C4E-BF79-A4ED946413B4\",\"UserType\":\"3\",\"Name\":\"秦梦欣\",\"Nickname\":\"秦梦欣\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834108\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"24\",\"Id\":\"1689\",\"UniqueNo\":\"074A156A-43E8-4951-B6DC-47AFCE2D95BA\",\"UserType\":\"3\",\"Name\":\"李昂\",\"Nickname\":\"李昂\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834107\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"25\",\"Id\":\"1688\",\"UniqueNo\":\"19E1F3BD-66C9-4BD0-B69B-D2F2BFC43F39\",\"UserType\":\"3\",\"Name\":\"张天一\",\"Nickname\":\"张天一\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834106\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"26\",\"Id\":\"1687\",\"UniqueNo\":\"AEF9DAF1-E205-4D5F-89A6-14F4974BAF84\",\"UserType\":\"3\",\"Name\":\"游畅\",\"Nickname\":\"游畅\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834105\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"27\",\"Id\":\"1686\",\"UniqueNo\":\"96DCC47B-20A3-472F-BFE6-A5086E89F119\",\"UserType\":\"3\",\"Name\":\"张思闻\",\"Nickname\":\"张思闻\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834104\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"28\",\"Id\":\"1685\",\"UniqueNo\":\"28C973AB-CBD7-4EEF-929A-FB4ADD375C44\",\"UserType\":\"3\",\"Name\":\"杜传\",\"Nickname\":\"杜传\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834103\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"29\",\"Id\":\"1684\",\"UniqueNo\":\"0CB57FB3-938E-4916-B1D6-E681ED3686F8\",\"UserType\":\"3\",\"Name\":\"杨思诺\",\"Nickname\":\"杨思诺\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"2016834102\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"30\",\"Id\":\"1683\",\"UniqueNo\":\"201C1EF4-588B-4978-9256-4311E882F89B\",\"UserType\":\"3\",\"Name\":\"sinp01\",\"Nickname\":\"sinp01\",\"Sex\":\"\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"sinp01\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"},{\"rowNum\":\"31\",\"Id\":\"1679\",\"UniqueNo\":\"9EB30161-9E3A-4D09-A967-538A8F6E3FF9\",\"UserType\":\"3\",\"Name\":\"陈炳然\",\"Nickname\":\"陈炳然\",\"Sex\":\"0\",\"Phone\":\"\",\"Birthday\":\"2017/3/1 0:00:00\",\"LoginName\":\"2016834101\",\"Password\":\"96e79218965eb72c92a549dd5a330112\",\"IDCard\":\"\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"http://192.168.1.3:8080/\",\"Email\":\"\"},{\"rowNum\":\"32\",\"Id\":\"1673\",\"UniqueNo\":\"00000000000000000X8\",\"UserType\":\"3\",\"Name\":\"临时0416\",\"Nickname\":\"临时0416\",\"Sex\":\"1\",\"Phone\":\"18254157367\",\"Birthday\":\"2017/1/17 0:00:00\",\"LoginName\":\"linshi0416\",\"Password\":\"e10adc3949ba59abbe56e057f20f883e\",\"IDCard\":\"130990199309091145\",\"HeadPic\":\"\",\"RegisterOrg\":\"1001\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"http://192.168.1.3:8080/\",\"Email\":\"\"},{\"rowNum\":\"33\",\"Id\":\"1672\",\"UniqueNo\":\"00000000000000000X\",\"UserType\":\"1\",\"Name\":\"超级管理员\",\"Nickname\":\"\",\"Sex\":\"1\",\"Phone\":\"\",\"Birthday\":\"\",\"LoginName\":\"admin\",\"Password\":\"564d9908cf33c34fe112c0b9d36dbe61\",\"IDCard\":\"00000000000000000X\",\"HeadPic\":\"\",\"RegisterOrg\":\"1000\",\"AuthenType\":\"2\",\"Address\":\"\",\"Remarks\":\"\",\"CreateUID\":\"\",\"EditUID\":\"\",\"IsEnable\":\"1\",\"IsDelete\":\"0\",\"CheckMsg\":\"\",\"AbsHeadPic\":\"\",\"Email\":\"\"}],\"errMsg\":\"success\",\"errNum\":0,\"status\":null}}";
// NetHelper.RequestPostUrl(PageUrl, urlbady);
            int starIndex = result.IndexOf(":") + 1;
            int endIndex = result.LastIndexOf("}");

            result = result.Substring(starIndex, endIndex - starIndex);

            jsonModel = jss.Deserialize<JsonModel>(result);
            DataTable dtb = new DataTable();
            for (int i = 0; i < ((object[])(jsonModel.retData)).Length; i++)
            {
                Dictionary<string, object> ht = (Dictionary<string, object>)(((object[])(jsonModel.retData))[i]);
                if (dtb.Columns.Count == 0)
                {
                    foreach (string key in ht.Keys)
                    {
                        dtb.Columns.Add(key, ht[key].GetType());//添加dt的列名
                    }
                }
                DataRow row = dtb.NewRow();
                foreach (string key in ht.Keys)
                {

                    row[key] = ht[key];//添加列值
                }
                dtb.Rows.Add(row);//添加一行
            }

            ReturnResult =bll.ImportUser(dtb);
            context.Response.Write(ReturnResult);
            context.Response.End();
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}