using SSSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSIBLL
{
    public interface IBaseService<T> where T : class, new()
    {
        JsonModel Add(T entity);

        JsonModel Update(T entity, SqlTransaction trans = null);

        JsonModel DeleteFalse(int id);

        JsonModel DeleteBatchFalse(params int[] ids);

        JsonModel Delete(int id);

        JsonModel DeleteBatch(params string[] ids);

        JsonModel GetEntityById(int id);

        JsonModel GetEntityListByField(string filed, string value);
        JsonModel GetPage(Hashtable ht, bool IsPage = true, string Where = "");
        DataTable GetData(Hashtable ht, bool IsPage = true, string Where = "");

        bool GetInfoById(int id);

        JsonModel IsNameExists(string name, Int32 Id = 0, string fieldname = "Name", bool isJudgeSys = false);
    }
}
