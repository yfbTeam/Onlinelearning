using SSSDAL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSBLL
{
    public partial class MyResource_CapacityAllService
    {
        MyResource_CapacityAllDal dal = new MyResource_CapacityAllDal();
        public JsonModel UpdateBase(string BaseLen)
        {


            JsonModel jsonModel = null;
            try
            {
                int result = dal.UpdateBase(BaseLen);
                if (result > 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = result
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "操作失败！",
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        public JsonModel GetAllUserInfo(string CreateUID)
        {
            DataTable dt = dal.GetAllUserInfo(CreateUID);
            return GetJsonModelByDataTable(dt);
        }
    }
}
