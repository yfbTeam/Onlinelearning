using SSSDAL;
using SSSIBLL;
using SSSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSBLL
{
    public partial class ModelManageService : BaseService<ModelManage>, IModelManageService
    {
        ModelManageDal dal = new ModelManageDal();

        public DataTable GetModelMenu(Hashtable ht, bool IsPage = true, string where = "")
        {
            int RowCount = 0;

            DataTable dt = dal.GetListByPage(ht, out RowCount, IsPage, where);
            return dt;
        }

        public JsonModel GetSubButtonByUrl(string purl, string uniqueNo)
        {
            DataTable modList = dal.GetSubButtonByUrl(purl, uniqueNo);

            return GetJsonModelByDataTable(modList);

            //try
            //{
            //    //定义JSON标准格式实体中
            //    JsonModel jsonModel = null;
            //    if (modList.Rows.Count <= 0)
            //    {
            //        jsonModel = new JsonModel()
            //        {
            //            errNum = 999,
            //            errMsg = "无数据",
            //            retData = ""
            //        };
            //        return jsonModel;
            //    }
            //    List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            //    list = new BLLCommon().DataTableToList(modList);
            //    jsonModel = new JsonModel()
            //    {
            //        errNum = 0,
            //        errMsg = "success",
            //        retData = list
            //    };
            //    return jsonModel;
            //}
            //catch (Exception ex)
            //{
            //    JsonModel jsonModel = new JsonModel()
            //    {
            //        errNum = 400,
            //        errMsg = ex.Message,
            //        retData = ""
            //    };
            //    return jsonModel;
            //}
        }
        public JsonModel AddModelMenu(ModelManage entity, string UserUniqueNo)
        {
            string result = dal.AddModelMenu(entity, UserUniqueNo);
            try
            {
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (result == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = ""
                    };
                    return jsonModel;
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = result,
                        retData = ""
                    };
                    return jsonModel;
                }
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
        public JsonModel DeleteModelMenu(int ID)
        {
            string result = dal.DeleteModelMenu(ID);
            try
            {
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (result == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = ""
                    };
                    return jsonModel;
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = result,
                        retData = ""
                    };
                    return jsonModel;
                }
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
        #region 获取所有同级导航
        public JsonModel GetSameLiveMenuByPid(string pid, string LinkUrl, string UserNo)
        {
            DataTable modList = dal.GetSameLiveMenuByPid(pid, LinkUrl,UserNo);

            return GetJsonModelByDataTable(modList);
           
        }
        #endregion
    }
}
