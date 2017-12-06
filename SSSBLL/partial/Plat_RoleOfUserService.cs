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
    public partial class Plat_RoleOfUserService : BaseService<Plat_RoleOfUser>, IPlat_RoleOfUserService
    {
        Plat_RoleOfUserDal dal = new Plat_RoleOfUserDal();
        #region 删除关系数据， 删单条
        /// <summary>
        /// 删除关系数据， 删单条
        /// </summary>
        /// <returns>返回 JsonModel</returns>
        public JsonModel DeleteUserRelation(Plat_RoleOfUser roleu)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = dal.DeleteUserRelation(roleu);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
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
        #endregion

        #region 数据导入
        /// <summary>
        /// 数据导入
        /// </summary>
        /// <returns></returns>
        public string ImportUser(DataTable dt)
        {
            string result = dal.ImportUser(dt);
            return result;         
        }

        #endregion

        #region 设置角色菜单
        /// <summary>
        /// 设置角色菜单
        /// </summary>
        /// <param name="roleid">角色id</param>
        /// <param name="menuids">菜单ids字符串，以逗号连接</param>
        /// <returns>返回 影响行数</returns>
        public JsonModel SetRoleMenu(string roleid, string menuids)
        {
            //定义JSON标准格式实体中
            JsonModel jsonModel = new JsonModel();
            try
            {
                //事务
                using (SqlTransaction trans = dal.GetTran())
                {
                    try
                    {
                        bool isdel = new Plat_RoleOfMenuDal().Delete(new Plat_RoleOfMenu(), "RoleId", Convert.ToInt32(roleid), trans);//删除旧的角色菜单关系
                        string[] idArray = menuids.Split(',');
                        int count = 0;
                        foreach (string menuid in idArray)
                        {
                            Plat_RoleOfMenu rm = new Plat_RoleOfMenu();
                            rm.RoleId = Convert.ToInt32(roleid);
                            rm.MenuId = Convert.ToInt32(menuid);
                            int result = new Plat_RoleOfMenuDal().Add(rm, trans);
                            if (result > 0)
                            {
                                count++;
                            }
                        }
                        if (idArray.Length != count)
                        {
                            trans.Rollback();//回滚
                            jsonModel = new JsonModel()
                            {
                                errNum = 1,
                                errMsg = "fial",
                                retData = "操作失败"
                            };
                            return jsonModel;
                        }
                        else
                        {
                            trans.Commit();//提交
                        }
                    }
                    catch (Exception)
                    {
                        trans.Rollback();//回滚
                        throw;
                    }
                }
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = "操作成功"
                };
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
        #endregion
        public string GetUserIDByRole(string RoleID)
        {
           return dal.GetUserIDByRole(RoleID);
        }
        public string GetUserOfAdmin()
        {
            string ReurnResult = dal.GetUserOfAdmin();
            return ReurnResult;
        }
    }
}
