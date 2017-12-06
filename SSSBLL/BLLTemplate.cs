using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSSUtility;
using SSSDAL;
using SSSModel;
using SSSIBLL;
namespace SSSBLL
{

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_ResourceService:BaseService<Couse_Resource>,ICouse_ResourceService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_ResourceDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_SelstuinfoService:BaseService<Couse_Selstuinfo>,ICouse_SelstuinfoService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_SelstuinfoDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_TaskInfoService:BaseService<Couse_TaskInfo>,ICouse_TaskInfoService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_TaskInfoDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class crm_logService:BaseService<crm_log>,Icrm_logService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getcrm_logDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class FeedBack_EnterpriseInfoService:BaseService<FeedBack_EnterpriseInfo>,IFeedBack_EnterpriseInfoService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetFeedBack_EnterpriseInfoDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class cust_customerService:BaseService<cust_customer>,Icust_customerService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getcust_customerDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class cust_linkmanService:BaseService<cust_linkman>,Icust_linkmanService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getcust_linkmanDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_AnswerService:BaseService<Exam_Answer>,IExam_AnswerService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_AnswerDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_ExaminationService:BaseService<Exam_Examination>,IExam_ExaminationService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_ExaminationDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class FeedBack_EnterJobService:BaseService<FeedBack_EnterJob>,IFeedBack_EnterJobService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetFeedBack_EnterJobDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_ObjQuestionService:BaseService<Exam_ObjQuestion>,IExam_ObjQuestionService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_ObjQuestionDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_PaperService:BaseService<Exam_Paper>,IExam_PaperService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_PaperDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_PaperExamService:BaseService<Exam_PaperExam>,IExam_PaperExamService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_PaperExamDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_PaperObjQService:BaseService<Exam_PaperObjQ>,IExam_PaperObjQService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_PaperObjQDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_PaperSubQService:BaseService<Exam_PaperSubQ>,IExam_PaperSubQService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_PaperSubQDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class FeedBack_DepartmentStuService:BaseService<FeedBack_DepartmentStu>,IFeedBack_DepartmentStuService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetFeedBack_DepartmentStuDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_QuestionTypeService:BaseService<Exam_QuestionType>,IExam_QuestionTypeService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_QuestionTypeDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_SubQuestionService:BaseService<Exam_SubQuestion>,IExam_SubQuestionService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_SubQuestionDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Order_DishMenuService:BaseService<Order_DishMenu>,IOrder_DishMenuService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetOrder_DishMenuDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class follow_upService:BaseService<follow_up>,Ifollow_upService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getfollow_upDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class ModelCatogoryService:BaseService<ModelCatogory>,IModelCatogoryService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetModelCatogoryDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class ModelManageService:BaseService<ModelManage>,IModelManageService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetModelManageDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Order_TimeScaleService:BaseService<Order_TimeScale>,IOrder_TimeScaleService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetOrder_TimeScaleDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class MyResourceService:BaseService<MyResource>,IMyResourceService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetMyResourceDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class MyResource_CapacityAllService:BaseService<MyResource_CapacityAll>,IMyResource_CapacityAllService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetMyResource_CapacityAllDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Order_DishService:BaseService<Order_Dish>,IOrder_DishService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetOrder_DishDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class MyResource_CapacityEachService:BaseService<MyResource_CapacityEach>,IMyResource_CapacityEachService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetMyResource_CapacityEachDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class param_ruleService:BaseService<param_rule>,Iparam_ruleService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getparam_ruleDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class pictureService:BaseService<picture>,IpictureService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetpictureDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_GradeService:BaseService<Plat_Grade>,IPlat_GradeService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_GradeDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Order_DishTypeService:BaseService<Order_DishType>,IOrder_DishTypeService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetOrder_DishTypeDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_GradeOfSubjectService:BaseService<Plat_GradeOfSubject>,IPlat_GradeOfSubjectService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_GradeOfSubjectDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Order_UserOrderService:BaseService<Order_UserOrder>,IOrder_UserOrderService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetOrder_UserOrderDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourceTypeService:BaseService<ResourceType>,IResourceTypeService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourceTypeDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class CourseService:BaseService<Course>,ICourseService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourseDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_PeriodService:BaseService<Plat_Period>,IPlat_PeriodService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_PeriodDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_PeriodOfSubjectService:BaseService<Plat_PeriodOfSubject>,IPlat_PeriodOfSubjectService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_PeriodOfSubjectDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Order_CanteenService:BaseService<Order_Canteen>,IOrder_CanteenService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetOrder_CanteenDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_RoleService:BaseService<Plat_Role>,IPlat_RoleService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_RoleDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_RoleOfMenuService:BaseService<Plat_RoleOfMenu>,IPlat_RoleOfMenuService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_RoleOfMenuDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_RoleOfUserService:BaseService<Plat_RoleOfUser>,IPlat_RoleOfUserService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_RoleOfUserDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Recruit_InfoService:BaseService<Recruit_Info>,IRecruit_InfoService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRecruit_InfoDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_ChapterService:BaseService<Course_Chapter>,ICourse_ChapterService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_ChapterDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_SchoolOfPeriodService:BaseService<Plat_SchoolOfPeriod>,IPlat_SchoolOfPeriodService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_SchoolOfPeriodDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class System_NoticeService:BaseService<System_Notice>,ISystem_NoticeService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_NoticeDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_StudentService:BaseService<Plat_Student>,IPlat_StudentService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_StudentDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_SubjectService:BaseService<Plat_Subject>,IPlat_SubjectService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_SubjectDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Recruit_StuService:BaseService<Recruit_Stu>,IRecruit_StuService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRecruit_StuDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_TeacherService:BaseService<Plat_Teacher>,IPlat_TeacherService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_TeacherDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_TextbookService:BaseService<Plat_Textbook>,IPlat_TextbookService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_TextbookDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_TextbookCatalogService:BaseService<Plat_TextbookCatalog>,IPlat_TextbookCatalogService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_TextbookCatalogDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_TextbookVersionService:BaseService<Plat_TextbookVersion>,IPlat_TextbookVersionService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_TextbookVersionDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class praiseService:BaseService<praise>,IpraiseService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetpraiseDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Resources_OpenService:BaseService<Resources_Open>,IResources_OpenService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResources_OpenDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Appoint_TimeManagementService:BaseService<Appoint_TimeManagement>,IAppoint_TimeManagementService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAppoint_TimeManagementDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class pub_paramService:BaseService<pub_param>,Ipub_paramService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getpub_paramDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class remindService:BaseService<remind>,IremindService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetremindDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class remind_settingService:BaseService<remind_setting>,Iremind_settingService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getremind_settingDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourceService:BaseService<Resource>,IResourceService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourceDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class shareService:BaseService<share>,IshareService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetshareDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class sign_inService:BaseService<sign_in>,Isign_inService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getsign_inDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class SingActiveTimeService:BaseService<SingActiveTime>,ISingActiveTimeService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSingActiveTimeDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Appoint_AssetManagementService:BaseService<Appoint_AssetManagement>,IAppoint_AssetManagementService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAppoint_AssetManagementDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class SomeTableClickService:BaseService<SomeTableClick>,ISomeTableClickService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSomeTableClickDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Appoint_ResourceReservationService:BaseService<Appoint_ResourceReservation>,IAppoint_ResourceReservationService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAppoint_ResourceReservationDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Appoint_ResourceReservationClaService:BaseService<Appoint_ResourceReservationCla>,IAppoint_ResourceReservationClaService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAppoint_ResourceReservationClaDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class statisticService:BaseService<statistic>,IstatisticService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetstatisticDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Appoint_ResourceReservationInfoService:BaseService<Appoint_ResourceReservationInfo>,IAppoint_ResourceReservationInfoService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAppoint_ResourceReservationInfoDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class statistic_detailService:BaseService<statistic_detail>,Istatistic_detailService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getstatistic_detailDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Appoint_ResourceReservationManagementService:BaseService<Appoint_ResourceReservationManagement>,IAppoint_ResourceReservationManagementService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAppoint_ResourceReservationManagementDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Appoint_ResourceTimeMappingIdService:BaseService<Appoint_ResourceTimeMappingId>,IAppoint_ResourceTimeMappingIdService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAppoint_ResourceTimeMappingIdDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class ScheduleService:BaseService<Schedule>,IScheduleService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetScheduleDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Sys_UserInfoService:BaseService<Sys_UserInfo>,ISys_UserInfoService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSys_UserInfoDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Appoint_TimeIntervalService:BaseService<Appoint_TimeInterval>,IAppoint_TimeIntervalService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAppoint_TimeIntervalDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class System_FavoritesService:BaseService<System_Favorites>,ISystem_FavoritesService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_FavoritesDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class TopicService:BaseService<Topic>,ITopicService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTopicDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class audioService:BaseService<audio>,IaudioService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetaudioDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Topic_CommentService:BaseService<Topic_Comment>,ITopic_CommentService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTopic_CommentDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateCourseService:BaseService<CertificateCourse>,ICertificateCourseService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateCourseDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Topic_GoodClickService:BaseService<Topic_GoodClick>,ITopic_GoodClickService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTopic_GoodClickDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateExamService:BaseService<CertificateExam>,ICertificateExamService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateExamDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class User_Model_RelService:BaseService<User_Model_Rel>,IUser_Model_RelService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetUser_Model_RelDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateListService:BaseService<CertificateList>,ICertificateListService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateListDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class UserSinLogService:BaseService<UserSinLog>,IUserSinLogService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetUserSinLogDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateManageService:BaseService<CertificateManage>,ICertificateManageService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateManageDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourcesInfoService:BaseService<ResourcesInfo>,IResourcesInfoService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourcesInfoDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class UserSkinService:BaseService<UserSkin>,IUserSkinService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetUserSkinDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateModolService:BaseService<CertificateModol>,ICertificateModolService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateModolDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class workplanService:BaseService<workplan>,IworkplanService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetworkplanDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class ClassCourseService:BaseService<ClassCourse>,IClassCourseService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetClassCourseDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class workreportService:BaseService<workreport>,IworkreportService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetworkreportDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class ClickDetailService:BaseService<ClickDetail>,IClickDetailService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetClickDetailDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class v_shareService:BaseService<v_share>,Iv_shareService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.Getv_shareDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class commentService:BaseService<comment>,IcommentService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetcommentDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_CatagoryService:BaseService<Course_Catagory>,ICourse_CatagoryService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_CatagoryDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_EvalueService:BaseService<Course_Evalue>,ICourse_EvalueService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_EvalueDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_PercentService:BaseService<Course_Percent>,ICourse_PercentService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_PercentDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_TaskRelService:BaseService<Course_TaskRel>,ICourse_TaskRelService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_TaskRelDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_WorkService:BaseService<Course_Work>,ICourse_WorkService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_WorkDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_WeekSetService:BaseService<Course_WeekSet>,ICourse_WeekSetService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_WeekSetDal();
        }
    }	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_WorkCorrectRelService:BaseService<Course_WorkCorrectRel>,ICourse_WorkCorrectRelService
    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_WorkCorrectRelDal();
        }
    }	
}