using SSSDAL;
using SSSIBLL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSBLL
{
    public partial class Plat_MenuInfoService
    {
        Plat_MenuInfoDal dal = new Plat_MenuInfoDal();
        #region 获得首页左侧导航处菜单信息
        /// <summary>
        /// 获得首页左侧导航处菜单信息
        /// </summary>
        /// <returns></returns>
        public DataTable GetLeftNavigationMenu(string systemkey, string useridcard, string pid = "0")
        {
            return dal.GetLeftNavigationMenu(useridcard, pid);
        }
        #endregion

        #region 获得权限设置处菜单信息
        /// <summary>
        /// 获得权限设置处菜单信息
        /// </summary>
        /// <returns></returns>
        public DataTable GetPermissionMenu(string roleid)
        {
            return dal.GetPermissionMenu(roleid);
        }
        #endregion

        #region 根据pid和身份证号查找菜单
        /// <summary>
        /// 根据pid和身份证号查找菜单
        /// </summary>
        /// <returns></returns>
        public JsonModel GetMenuByPidAndIDCard(string useridcard, string pid)
        {
            BLLCommon common = new BLLCommon();
            try
            {

                DataTable modList = dal.GetMenuByPidAndIDCard(useridcard, pid);

                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList == null || modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 100,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = common.DataTableToList(modList);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = list
                };

                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #endregion
    }
}
