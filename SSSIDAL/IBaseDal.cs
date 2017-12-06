using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSIDAL
{
    public interface IBaseDal<T> where T : class, new()
    {
        int Add(T entity);

        //int Insert(T entity);

        bool Update(T entity, SqlTransaction trans = null);

        bool DeleteFalse(T entity, int id);

        int DeleteBatchFalse(T entity, params int[] ids);

        bool Delete(T entity, int id);

        int DeleteBatch(T entity, params string[] ids);

        T GetEntityById(T entity, int id);
        bool GetInfoById(T entity, int id);
        DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "");
        bool IsNameExists(T entity, string name, Int32 Id, string fieldname, bool isJudgeSys);
        List<T> GetEntityListByField(T entity, string filed, string value);
    }
}
