using SSSDAL;
using SSSIBLL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSBLL
{
    public partial class CertificateManageService : BaseService<CertificateManage>, ICertificateManageService
    {
        CertificateManageDal dal = new CertificateManageDal();
        public string PlatCertificateAdd(string Name, string Course, string UserIdCard, string ModelID)
        {
            return dal.PlatCertificateAdd(Name, Course, UserIdCard, ModelID);
        }
        public string PlatCertificateEdit(string Name, string Course, string UserIdCard, string ModelID, int ID)
        {
            return dal.PlatCertificateEdit(Name, Course, UserIdCard, ModelID, ID);
        }
        public string PlatCertificateDel(string UserIdCard, int ID)
        {
            return dal.PlatCertificateDel(UserIdCard, ID);
        }
        public string Apply(string CertificateID, string IDCard)
        {
            return dal.Apply(CertificateID, IDCard);
        }
    }
}
