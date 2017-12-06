using SSSIDAL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSDAL
{
    public partial class CertificateManageDal : BaseDal<CertificateManage>, ICertificateManageDal
    {
        #region 添加平台证书
        /// <summary>
        /// 添加平台证书
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string PlatCertificateAdd(string Name, string Course, string UserIdCard, string ModelID)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Name",Name),
                                       new SqlParameter("@Course", Course),
                                       new SqlParameter("@UserIdCard",UserIdCard),
                                       new SqlParameter("@ModelID",ModelID)
                                   };
            object obj = SQLHelp.ExecuteScalar("AddPlatCertificate", CommandType.StoredProcedure, param);
            string result = "添加成功";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion

        #region 修改平台证书
        /// <summary>
        /// 修改平台证书
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string PlatCertificateEdit(string Name, string Course, string UserIdCard, string ModelID, int ID)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Name",Name),
                                       new SqlParameter("@Course", Course),
                                      
                                       new SqlParameter("@UserIdCard",UserIdCard),
                                       new SqlParameter("@ModelID",ModelID),
                                       new SqlParameter("@ID",ID),
                                   };
            object obj = SQLHelp.ExecuteScalar("EditPlatCertificate", CommandType.StoredProcedure, param);
            string result = "修改成功";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion

        #region 删除平台证书
        /// <summary>
        /// 删除平台证书
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string PlatCertificateDel(string UserIdCard,int ID)
        {
            SqlParameter[] param = {                                     
                                       new SqlParameter("@UserIdCard",UserIdCard),
                                       new SqlParameter("@ID",ID),
                                   };
            object obj = SQLHelp.ExecuteScalar("DelPlatCertificate", CommandType.StoredProcedure, param);
            string result = "删除成功";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion
        
        public string Apply(string CertificateID, string IDCard)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@CertificateID",CertificateID),
                                       new SqlParameter("@IDCard",IDCard)
                                   };
            object obj = SQLHelp.ExecuteScalar("CertApply", CommandType.StoredProcedure, param);
            string result = "";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
    }
}
