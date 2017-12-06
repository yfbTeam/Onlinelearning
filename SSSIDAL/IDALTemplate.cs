using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSSUtility;
using SSSModel;
using System.Configuration;
namespace SSSIDAL
{

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_ResourceDal: IBaseDal<Couse_Resource>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_SelstuinfoDal: IBaseDal<Couse_Selstuinfo>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_TaskInfoDal: IBaseDal<Couse_TaskInfo>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Icrm_logDal: IBaseDal<crm_log>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IFeedBack_EnterpriseInfoDal: IBaseDal<FeedBack_EnterpriseInfo>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Icust_customerDal: IBaseDal<cust_customer>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Icust_linkmanDal: IBaseDal<cust_linkman>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_AnswerDal: IBaseDal<Exam_Answer>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_ExaminationDal: IBaseDal<Exam_Examination>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IFeedBack_EnterJobDal: IBaseDal<FeedBack_EnterJob>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_ObjQuestionDal: IBaseDal<Exam_ObjQuestion>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_PaperDal: IBaseDal<Exam_Paper>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_PaperExamDal: IBaseDal<Exam_PaperExam>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_PaperObjQDal: IBaseDal<Exam_PaperObjQ>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_PaperSubQDal: IBaseDal<Exam_PaperSubQ>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IFeedBack_DepartmentStuDal: IBaseDal<FeedBack_DepartmentStu>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_QuestionTypeDal: IBaseDal<Exam_QuestionType>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_SubQuestionDal: IBaseDal<Exam_SubQuestion>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IOrder_DishMenuDal: IBaseDal<Order_DishMenu>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Ifollow_upDal: IBaseDal<follow_up>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IModelCatogoryDal: IBaseDal<ModelCatogory>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IModelManageDal: IBaseDal<ModelManage>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IOrder_TimeScaleDal: IBaseDal<Order_TimeScale>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IMyResourceDal: IBaseDal<MyResource>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IMyResource_CapacityAllDal: IBaseDal<MyResource_CapacityAll>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IOrder_DishDal: IBaseDal<Order_Dish>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IMyResource_CapacityEachDal: IBaseDal<MyResource_CapacityEach>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Iparam_ruleDal: IBaseDal<param_rule>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IpictureDal: IBaseDal<picture>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_GradeDal: IBaseDal<Plat_Grade>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IOrder_DishTypeDal: IBaseDal<Order_DishType>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_GradeOfSubjectDal: IBaseDal<Plat_GradeOfSubject>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IOrder_UserOrderDal: IBaseDal<Order_UserOrder>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourceTypeDal: IBaseDal<ResourceType>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourseDal: IBaseDal<Course>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_PeriodDal: IBaseDal<Plat_Period>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_PeriodOfSubjectDal: IBaseDal<Plat_PeriodOfSubject>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IOrder_CanteenDal: IBaseDal<Order_Canteen>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_RoleDal: IBaseDal<Plat_Role>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_RoleOfMenuDal: IBaseDal<Plat_RoleOfMenu>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_RoleOfUserDal: IBaseDal<Plat_RoleOfUser>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IRecruit_InfoDal: IBaseDal<Recruit_Info>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_ChapterDal: IBaseDal<Course_Chapter>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_SchoolOfPeriodDal: IBaseDal<Plat_SchoolOfPeriod>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_NoticeDal: IBaseDal<System_Notice>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_StudentDal: IBaseDal<Plat_Student>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_SubjectDal: IBaseDal<Plat_Subject>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IRecruit_StuDal: IBaseDal<Recruit_Stu>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_TeacherDal: IBaseDal<Plat_Teacher>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_TextbookDal: IBaseDal<Plat_Textbook>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_TextbookCatalogDal: IBaseDal<Plat_TextbookCatalog>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPlat_TextbookVersionDal: IBaseDal<Plat_TextbookVersion>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IpraiseDal: IBaseDal<praise>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResources_OpenDal: IBaseDal<Resources_Open>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAppoint_TimeManagementDal: IBaseDal<Appoint_TimeManagement>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Ipub_paramDal: IBaseDal<pub_param>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IremindDal: IBaseDal<remind>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Iremind_settingDal: IBaseDal<remind_setting>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourceDal: IBaseDal<Resource>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IshareDal: IBaseDal<share>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Isign_inDal: IBaseDal<sign_in>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISingActiveTimeDal: IBaseDal<SingActiveTime>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAppoint_AssetManagementDal: IBaseDal<Appoint_AssetManagement>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISomeTableClickDal: IBaseDal<SomeTableClick>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAppoint_ResourceReservationDal: IBaseDal<Appoint_ResourceReservation>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAppoint_ResourceReservationClaDal: IBaseDal<Appoint_ResourceReservationCla>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IstatisticDal: IBaseDal<statistic>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAppoint_ResourceReservationInfoDal: IBaseDal<Appoint_ResourceReservationInfo>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Istatistic_detailDal: IBaseDal<statistic_detail>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAppoint_ResourceReservationManagementDal: IBaseDal<Appoint_ResourceReservationManagement>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAppoint_ResourceTimeMappingIdDal: IBaseDal<Appoint_ResourceTimeMappingId>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IScheduleDal: IBaseDal<Schedule>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISys_UserInfoDal: IBaseDal<Sys_UserInfo>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAppoint_TimeIntervalDal: IBaseDal<Appoint_TimeInterval>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_FavoritesDal: IBaseDal<System_Favorites>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITopicDal: IBaseDal<Topic>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IaudioDal: IBaseDal<audio>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITopic_CommentDal: IBaseDal<Topic_Comment>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateCourseDal: IBaseDal<CertificateCourse>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITopic_GoodClickDal: IBaseDal<Topic_GoodClick>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateExamDal: IBaseDal<CertificateExam>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IUser_Model_RelDal: IBaseDal<User_Model_Rel>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateListDal: IBaseDal<CertificateList>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IUserSinLogDal: IBaseDal<UserSinLog>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateManageDal: IBaseDal<CertificateManage>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourcesInfoDal: IBaseDal<ResourcesInfo>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IUserSkinDal: IBaseDal<UserSkin>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateModolDal: IBaseDal<CertificateModol>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IworkplanDal: IBaseDal<workplan>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IClassCourseDal: IBaseDal<ClassCourse>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IworkreportDal: IBaseDal<workreport>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IClickDetailDal: IBaseDal<ClickDetail>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface Iv_shareDal: IBaseDal<v_share>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IcommentDal: IBaseDal<comment>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_CatagoryDal: IBaseDal<Course_Catagory>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_EvalueDal: IBaseDal<Course_Evalue>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_PercentDal: IBaseDal<Course_Percent>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_TaskRelDal: IBaseDal<Course_TaskRel>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_WorkDal: IBaseDal<Course_Work>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_WeekSetDal: IBaseDal<Course_WeekSet>
    {
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_WorkCorrectRelDal: IBaseDal<Course_WorkCorrectRel>
    {
		
    }
}