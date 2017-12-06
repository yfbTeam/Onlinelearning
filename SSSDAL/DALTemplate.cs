using SSSIDAL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace SSSDAL
{


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Couse_ResourceDal:BaseDal<Couse_Resource>,ICouse_ResourceDal
         {


         }	

        public partial class DalFactory
        {
            public static ICouse_ResourceDal GetCouse_ResourceDal()
            {
                return new Couse_ResourceDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Couse_SelstuinfoDal:BaseDal<Couse_Selstuinfo>,ICouse_SelstuinfoDal
         {


         }	

        public partial class DalFactory
        {
            public static ICouse_SelstuinfoDal GetCouse_SelstuinfoDal()
            {
                return new Couse_SelstuinfoDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Couse_TaskInfoDal:BaseDal<Couse_TaskInfo>,ICouse_TaskInfoDal
         {


         }	

        public partial class DalFactory
        {
            public static ICouse_TaskInfoDal GetCouse_TaskInfoDal()
            {
                return new Couse_TaskInfoDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class crm_logDal:BaseDal<crm_log>,Icrm_logDal
         {


         }	

        public partial class DalFactory
        {
            public static Icrm_logDal Getcrm_logDal()
            {
                return new crm_logDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class FeedBack_EnterpriseInfoDal:BaseDal<FeedBack_EnterpriseInfo>,IFeedBack_EnterpriseInfoDal
         {


         }	

        public partial class DalFactory
        {
            public static IFeedBack_EnterpriseInfoDal GetFeedBack_EnterpriseInfoDal()
            {
                return new FeedBack_EnterpriseInfoDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class cust_customerDal:BaseDal<cust_customer>,Icust_customerDal
         {


         }	

        public partial class DalFactory
        {
            public static Icust_customerDal Getcust_customerDal()
            {
                return new cust_customerDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class cust_linkmanDal:BaseDal<cust_linkman>,Icust_linkmanDal
         {


         }	

        public partial class DalFactory
        {
            public static Icust_linkmanDal Getcust_linkmanDal()
            {
                return new cust_linkmanDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Exam_AnswerDal:BaseDal<Exam_Answer>,IExam_AnswerDal
         {


         }	

        public partial class DalFactory
        {
            public static IExam_AnswerDal GetExam_AnswerDal()
            {
                return new Exam_AnswerDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Exam_ExaminationDal:BaseDal<Exam_Examination>,IExam_ExaminationDal
         {


         }	

        public partial class DalFactory
        {
            public static IExam_ExaminationDal GetExam_ExaminationDal()
            {
                return new Exam_ExaminationDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class FeedBack_EnterJobDal:BaseDal<FeedBack_EnterJob>,IFeedBack_EnterJobDal
         {


         }	

        public partial class DalFactory
        {
            public static IFeedBack_EnterJobDal GetFeedBack_EnterJobDal()
            {
                return new FeedBack_EnterJobDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Exam_ObjQuestionDal:BaseDal<Exam_ObjQuestion>,IExam_ObjQuestionDal
         {


         }	

        public partial class DalFactory
        {
            public static IExam_ObjQuestionDal GetExam_ObjQuestionDal()
            {
                return new Exam_ObjQuestionDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Exam_PaperDal:BaseDal<Exam_Paper>,IExam_PaperDal
         {


         }	

        public partial class DalFactory
        {
            public static IExam_PaperDal GetExam_PaperDal()
            {
                return new Exam_PaperDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Exam_PaperExamDal:BaseDal<Exam_PaperExam>,IExam_PaperExamDal
         {


         }	

        public partial class DalFactory
        {
            public static IExam_PaperExamDal GetExam_PaperExamDal()
            {
                return new Exam_PaperExamDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Exam_PaperObjQDal:BaseDal<Exam_PaperObjQ>,IExam_PaperObjQDal
         {


         }	

        public partial class DalFactory
        {
            public static IExam_PaperObjQDal GetExam_PaperObjQDal()
            {
                return new Exam_PaperObjQDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Exam_PaperSubQDal:BaseDal<Exam_PaperSubQ>,IExam_PaperSubQDal
         {


         }	

        public partial class DalFactory
        {
            public static IExam_PaperSubQDal GetExam_PaperSubQDal()
            {
                return new Exam_PaperSubQDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class FeedBack_DepartmentStuDal:BaseDal<FeedBack_DepartmentStu>,IFeedBack_DepartmentStuDal
         {


         }	

        public partial class DalFactory
        {
            public static IFeedBack_DepartmentStuDal GetFeedBack_DepartmentStuDal()
            {
                return new FeedBack_DepartmentStuDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Exam_QuestionTypeDal:BaseDal<Exam_QuestionType>,IExam_QuestionTypeDal
         {


         }	

        public partial class DalFactory
        {
            public static IExam_QuestionTypeDal GetExam_QuestionTypeDal()
            {
                return new Exam_QuestionTypeDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Exam_SubQuestionDal:BaseDal<Exam_SubQuestion>,IExam_SubQuestionDal
         {


         }	

        public partial class DalFactory
        {
            public static IExam_SubQuestionDal GetExam_SubQuestionDal()
            {
                return new Exam_SubQuestionDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Order_DishMenuDal:BaseDal<Order_DishMenu>,IOrder_DishMenuDal
         {


         }	

        public partial class DalFactory
        {
            public static IOrder_DishMenuDal GetOrder_DishMenuDal()
            {
                return new Order_DishMenuDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class follow_upDal:BaseDal<follow_up>,Ifollow_upDal
         {


         }	

        public partial class DalFactory
        {
            public static Ifollow_upDal Getfollow_upDal()
            {
                return new follow_upDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class ModelCatogoryDal:BaseDal<ModelCatogory>,IModelCatogoryDal
         {


         }	

        public partial class DalFactory
        {
            public static IModelCatogoryDal GetModelCatogoryDal()
            {
                return new ModelCatogoryDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class ModelManageDal:BaseDal<ModelManage>,IModelManageDal
         {


         }	

        public partial class DalFactory
        {
            public static IModelManageDal GetModelManageDal()
            {
                return new ModelManageDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Order_TimeScaleDal:BaseDal<Order_TimeScale>,IOrder_TimeScaleDal
         {


         }	

        public partial class DalFactory
        {
            public static IOrder_TimeScaleDal GetOrder_TimeScaleDal()
            {
                return new Order_TimeScaleDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class MyResourceDal:BaseDal<MyResource>,IMyResourceDal
         {


         }	

        public partial class DalFactory
        {
            public static IMyResourceDal GetMyResourceDal()
            {
                return new MyResourceDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class MyResource_CapacityAllDal:BaseDal<MyResource_CapacityAll>,IMyResource_CapacityAllDal
         {


         }	

        public partial class DalFactory
        {
            public static IMyResource_CapacityAllDal GetMyResource_CapacityAllDal()
            {
                return new MyResource_CapacityAllDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Order_DishDal:BaseDal<Order_Dish>,IOrder_DishDal
         {


         }	

        public partial class DalFactory
        {
            public static IOrder_DishDal GetOrder_DishDal()
            {
                return new Order_DishDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class MyResource_CapacityEachDal:BaseDal<MyResource_CapacityEach>,IMyResource_CapacityEachDal
         {


         }	

        public partial class DalFactory
        {
            public static IMyResource_CapacityEachDal GetMyResource_CapacityEachDal()
            {
                return new MyResource_CapacityEachDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class param_ruleDal:BaseDal<param_rule>,Iparam_ruleDal
         {


         }	

        public partial class DalFactory
        {
            public static Iparam_ruleDal Getparam_ruleDal()
            {
                return new param_ruleDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class pictureDal:BaseDal<picture>,IpictureDal
         {


         }	

        public partial class DalFactory
        {
            public static IpictureDal GetpictureDal()
            {
                return new pictureDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_GradeDal:BaseDal<Plat_Grade>,IPlat_GradeDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_GradeDal GetPlat_GradeDal()
            {
                return new Plat_GradeDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Order_DishTypeDal:BaseDal<Order_DishType>,IOrder_DishTypeDal
         {


         }	

        public partial class DalFactory
        {
            public static IOrder_DishTypeDal GetOrder_DishTypeDal()
            {
                return new Order_DishTypeDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_GradeOfSubjectDal:BaseDal<Plat_GradeOfSubject>,IPlat_GradeOfSubjectDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_GradeOfSubjectDal GetPlat_GradeOfSubjectDal()
            {
                return new Plat_GradeOfSubjectDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Order_UserOrderDal:BaseDal<Order_UserOrder>,IOrder_UserOrderDal
         {


         }	

        public partial class DalFactory
        {
            public static IOrder_UserOrderDal GetOrder_UserOrderDal()
            {
                return new Order_UserOrderDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class ResourceTypeDal:BaseDal<ResourceType>,IResourceTypeDal
         {


         }	

        public partial class DalFactory
        {
            public static IResourceTypeDal GetResourceTypeDal()
            {
                return new ResourceTypeDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class CourseDal:BaseDal<Course>,ICourseDal
         {


         }	

        public partial class DalFactory
        {
            public static ICourseDal GetCourseDal()
            {
                return new CourseDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_PeriodDal:BaseDal<Plat_Period>,IPlat_PeriodDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_PeriodDal GetPlat_PeriodDal()
            {
                return new Plat_PeriodDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_PeriodOfSubjectDal:BaseDal<Plat_PeriodOfSubject>,IPlat_PeriodOfSubjectDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_PeriodOfSubjectDal GetPlat_PeriodOfSubjectDal()
            {
                return new Plat_PeriodOfSubjectDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Order_CanteenDal:BaseDal<Order_Canteen>,IOrder_CanteenDal
         {


         }	

        public partial class DalFactory
        {
            public static IOrder_CanteenDal GetOrder_CanteenDal()
            {
                return new Order_CanteenDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_RoleDal:BaseDal<Plat_Role>,IPlat_RoleDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_RoleDal GetPlat_RoleDal()
            {
                return new Plat_RoleDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_RoleOfMenuDal:BaseDal<Plat_RoleOfMenu>,IPlat_RoleOfMenuDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_RoleOfMenuDal GetPlat_RoleOfMenuDal()
            {
                return new Plat_RoleOfMenuDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_RoleOfUserDal:BaseDal<Plat_RoleOfUser>,IPlat_RoleOfUserDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_RoleOfUserDal GetPlat_RoleOfUserDal()
            {
                return new Plat_RoleOfUserDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Recruit_InfoDal:BaseDal<Recruit_Info>,IRecruit_InfoDal
         {


         }	

        public partial class DalFactory
        {
            public static IRecruit_InfoDal GetRecruit_InfoDal()
            {
                return new Recruit_InfoDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Course_ChapterDal:BaseDal<Course_Chapter>,ICourse_ChapterDal
         {


         }	

        public partial class DalFactory
        {
            public static ICourse_ChapterDal GetCourse_ChapterDal()
            {
                return new Course_ChapterDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_SchoolOfPeriodDal:BaseDal<Plat_SchoolOfPeriod>,IPlat_SchoolOfPeriodDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_SchoolOfPeriodDal GetPlat_SchoolOfPeriodDal()
            {
                return new Plat_SchoolOfPeriodDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class System_NoticeDal:BaseDal<System_Notice>,ISystem_NoticeDal
         {


         }	

        public partial class DalFactory
        {
            public static ISystem_NoticeDal GetSystem_NoticeDal()
            {
                return new System_NoticeDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_StudentDal:BaseDal<Plat_Student>,IPlat_StudentDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_StudentDal GetPlat_StudentDal()
            {
                return new Plat_StudentDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_SubjectDal:BaseDal<Plat_Subject>,IPlat_SubjectDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_SubjectDal GetPlat_SubjectDal()
            {
                return new Plat_SubjectDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Recruit_StuDal:BaseDal<Recruit_Stu>,IRecruit_StuDal
         {


         }	

        public partial class DalFactory
        {
            public static IRecruit_StuDal GetRecruit_StuDal()
            {
                return new Recruit_StuDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_TeacherDal:BaseDal<Plat_Teacher>,IPlat_TeacherDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_TeacherDal GetPlat_TeacherDal()
            {
                return new Plat_TeacherDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_TextbookDal:BaseDal<Plat_Textbook>,IPlat_TextbookDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_TextbookDal GetPlat_TextbookDal()
            {
                return new Plat_TextbookDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_TextbookCatalogDal:BaseDal<Plat_TextbookCatalog>,IPlat_TextbookCatalogDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_TextbookCatalogDal GetPlat_TextbookCatalogDal()
            {
                return new Plat_TextbookCatalogDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Plat_TextbookVersionDal:BaseDal<Plat_TextbookVersion>,IPlat_TextbookVersionDal
         {


         }	

        public partial class DalFactory
        {
            public static IPlat_TextbookVersionDal GetPlat_TextbookVersionDal()
            {
                return new Plat_TextbookVersionDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class praiseDal:BaseDal<praise>,IpraiseDal
         {


         }	

        public partial class DalFactory
        {
            public static IpraiseDal GetpraiseDal()
            {
                return new praiseDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Resources_OpenDal:BaseDal<Resources_Open>,IResources_OpenDal
         {


         }	

        public partial class DalFactory
        {
            public static IResources_OpenDal GetResources_OpenDal()
            {
                return new Resources_OpenDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Appoint_TimeManagementDal:BaseDal<Appoint_TimeManagement>,IAppoint_TimeManagementDal
         {


         }	

        public partial class DalFactory
        {
            public static IAppoint_TimeManagementDal GetAppoint_TimeManagementDal()
            {
                return new Appoint_TimeManagementDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class pub_paramDal:BaseDal<pub_param>,Ipub_paramDal
         {


         }	

        public partial class DalFactory
        {
            public static Ipub_paramDal Getpub_paramDal()
            {
                return new pub_paramDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class remindDal:BaseDal<remind>,IremindDal
         {


         }	

        public partial class DalFactory
        {
            public static IremindDal GetremindDal()
            {
                return new remindDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class remind_settingDal:BaseDal<remind_setting>,Iremind_settingDal
         {


         }	

        public partial class DalFactory
        {
            public static Iremind_settingDal Getremind_settingDal()
            {
                return new remind_settingDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class ResourceDal:BaseDal<Resource>,IResourceDal
         {


         }	

        public partial class DalFactory
        {
            public static IResourceDal GetResourceDal()
            {
                return new ResourceDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class shareDal:BaseDal<share>,IshareDal
         {


         }	

        public partial class DalFactory
        {
            public static IshareDal GetshareDal()
            {
                return new shareDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class sign_inDal:BaseDal<sign_in>,Isign_inDal
         {


         }	

        public partial class DalFactory
        {
            public static Isign_inDal Getsign_inDal()
            {
                return new sign_inDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class SingActiveTimeDal:BaseDal<SingActiveTime>,ISingActiveTimeDal
         {


         }	

        public partial class DalFactory
        {
            public static ISingActiveTimeDal GetSingActiveTimeDal()
            {
                return new SingActiveTimeDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Appoint_AssetManagementDal:BaseDal<Appoint_AssetManagement>,IAppoint_AssetManagementDal
         {


         }	

        public partial class DalFactory
        {
            public static IAppoint_AssetManagementDal GetAppoint_AssetManagementDal()
            {
                return new Appoint_AssetManagementDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class SomeTableClickDal:BaseDal<SomeTableClick>,ISomeTableClickDal
         {


         }	

        public partial class DalFactory
        {
            public static ISomeTableClickDal GetSomeTableClickDal()
            {
                return new SomeTableClickDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Appoint_ResourceReservationDal:BaseDal<Appoint_ResourceReservation>,IAppoint_ResourceReservationDal
         {


         }	

        public partial class DalFactory
        {
            public static IAppoint_ResourceReservationDal GetAppoint_ResourceReservationDal()
            {
                return new Appoint_ResourceReservationDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Appoint_ResourceReservationClaDal:BaseDal<Appoint_ResourceReservationCla>,IAppoint_ResourceReservationClaDal
         {


         }	

        public partial class DalFactory
        {
            public static IAppoint_ResourceReservationClaDal GetAppoint_ResourceReservationClaDal()
            {
                return new Appoint_ResourceReservationClaDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class statisticDal:BaseDal<statistic>,IstatisticDal
         {


         }	

        public partial class DalFactory
        {
            public static IstatisticDal GetstatisticDal()
            {
                return new statisticDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Appoint_ResourceReservationInfoDal:BaseDal<Appoint_ResourceReservationInfo>,IAppoint_ResourceReservationInfoDal
         {


         }	

        public partial class DalFactory
        {
            public static IAppoint_ResourceReservationInfoDal GetAppoint_ResourceReservationInfoDal()
            {
                return new Appoint_ResourceReservationInfoDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class statistic_detailDal:BaseDal<statistic_detail>,Istatistic_detailDal
         {


         }	

        public partial class DalFactory
        {
            public static Istatistic_detailDal Getstatistic_detailDal()
            {
                return new statistic_detailDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Appoint_ResourceReservationManagementDal:BaseDal<Appoint_ResourceReservationManagement>,IAppoint_ResourceReservationManagementDal
         {


         }	

        public partial class DalFactory
        {
            public static IAppoint_ResourceReservationManagementDal GetAppoint_ResourceReservationManagementDal()
            {
                return new Appoint_ResourceReservationManagementDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Appoint_ResourceTimeMappingIdDal:BaseDal<Appoint_ResourceTimeMappingId>,IAppoint_ResourceTimeMappingIdDal
         {


         }	

        public partial class DalFactory
        {
            public static IAppoint_ResourceTimeMappingIdDal GetAppoint_ResourceTimeMappingIdDal()
            {
                return new Appoint_ResourceTimeMappingIdDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class ScheduleDal:BaseDal<Schedule>,IScheduleDal
         {


         }	

        public partial class DalFactory
        {
            public static IScheduleDal GetScheduleDal()
            {
                return new ScheduleDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Sys_UserInfoDal:BaseDal<Sys_UserInfo>,ISys_UserInfoDal
         {


         }	

        public partial class DalFactory
        {
            public static ISys_UserInfoDal GetSys_UserInfoDal()
            {
                return new Sys_UserInfoDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Appoint_TimeIntervalDal:BaseDal<Appoint_TimeInterval>,IAppoint_TimeIntervalDal
         {


         }	

        public partial class DalFactory
        {
            public static IAppoint_TimeIntervalDal GetAppoint_TimeIntervalDal()
            {
                return new Appoint_TimeIntervalDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class System_FavoritesDal:BaseDal<System_Favorites>,ISystem_FavoritesDal
         {


         }	

        public partial class DalFactory
        {
            public static ISystem_FavoritesDal GetSystem_FavoritesDal()
            {
                return new System_FavoritesDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class TopicDal:BaseDal<Topic>,ITopicDal
         {


         }	

        public partial class DalFactory
        {
            public static ITopicDal GetTopicDal()
            {
                return new TopicDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class audioDal:BaseDal<audio>,IaudioDal
         {


         }	

        public partial class DalFactory
        {
            public static IaudioDal GetaudioDal()
            {
                return new audioDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Topic_CommentDal:BaseDal<Topic_Comment>,ITopic_CommentDal
         {


         }	

        public partial class DalFactory
        {
            public static ITopic_CommentDal GetTopic_CommentDal()
            {
                return new Topic_CommentDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class CertificateCourseDal:BaseDal<CertificateCourse>,ICertificateCourseDal
         {


         }	

        public partial class DalFactory
        {
            public static ICertificateCourseDal GetCertificateCourseDal()
            {
                return new CertificateCourseDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Topic_GoodClickDal:BaseDal<Topic_GoodClick>,ITopic_GoodClickDal
         {


         }	

        public partial class DalFactory
        {
            public static ITopic_GoodClickDal GetTopic_GoodClickDal()
            {
                return new Topic_GoodClickDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class CertificateExamDal:BaseDal<CertificateExam>,ICertificateExamDal
         {


         }	

        public partial class DalFactory
        {
            public static ICertificateExamDal GetCertificateExamDal()
            {
                return new CertificateExamDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class User_Model_RelDal:BaseDal<User_Model_Rel>,IUser_Model_RelDal
         {


         }	

        public partial class DalFactory
        {
            public static IUser_Model_RelDal GetUser_Model_RelDal()
            {
                return new User_Model_RelDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class CertificateListDal:BaseDal<CertificateList>,ICertificateListDal
         {


         }	

        public partial class DalFactory
        {
            public static ICertificateListDal GetCertificateListDal()
            {
                return new CertificateListDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class UserSinLogDal:BaseDal<UserSinLog>,IUserSinLogDal
         {


         }	

        public partial class DalFactory
        {
            public static IUserSinLogDal GetUserSinLogDal()
            {
                return new UserSinLogDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class CertificateManageDal:BaseDal<CertificateManage>,ICertificateManageDal
         {


         }	

        public partial class DalFactory
        {
            public static ICertificateManageDal GetCertificateManageDal()
            {
                return new CertificateManageDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class ResourcesInfoDal:BaseDal<ResourcesInfo>,IResourcesInfoDal
         {


         }	

        public partial class DalFactory
        {
            public static IResourcesInfoDal GetResourcesInfoDal()
            {
                return new ResourcesInfoDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class UserSkinDal:BaseDal<UserSkin>,IUserSkinDal
         {


         }	

        public partial class DalFactory
        {
            public static IUserSkinDal GetUserSkinDal()
            {
                return new UserSkinDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class CertificateModolDal:BaseDal<CertificateModol>,ICertificateModolDal
         {


         }	

        public partial class DalFactory
        {
            public static ICertificateModolDal GetCertificateModolDal()
            {
                return new CertificateModolDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class workplanDal:BaseDal<workplan>,IworkplanDal
         {


         }	

        public partial class DalFactory
        {
            public static IworkplanDal GetworkplanDal()
            {
                return new workplanDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class ClassCourseDal:BaseDal<ClassCourse>,IClassCourseDal
         {


         }	

        public partial class DalFactory
        {
            public static IClassCourseDal GetClassCourseDal()
            {
                return new ClassCourseDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class workreportDal:BaseDal<workreport>,IworkreportDal
         {


         }	

        public partial class DalFactory
        {
            public static IworkreportDal GetworkreportDal()
            {
                return new workreportDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class ClickDetailDal:BaseDal<ClickDetail>,IClickDetailDal
         {


         }	

        public partial class DalFactory
        {
            public static IClickDetailDal GetClickDetailDal()
            {
                return new ClickDetailDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class v_shareDal:BaseDal<v_share>,Iv_shareDal
         {


         }	

        public partial class DalFactory
        {
            public static Iv_shareDal Getv_shareDal()
            {
                return new v_shareDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class commentDal:BaseDal<comment>,IcommentDal
         {


         }	

        public partial class DalFactory
        {
            public static IcommentDal GetcommentDal()
            {
                return new commentDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Course_CatagoryDal:BaseDal<Course_Catagory>,ICourse_CatagoryDal
         {


         }	

        public partial class DalFactory
        {
            public static ICourse_CatagoryDal GetCourse_CatagoryDal()
            {
                return new Course_CatagoryDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Course_EvalueDal:BaseDal<Course_Evalue>,ICourse_EvalueDal
         {


         }	

        public partial class DalFactory
        {
            public static ICourse_EvalueDal GetCourse_EvalueDal()
            {
                return new Course_EvalueDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Course_PercentDal:BaseDal<Course_Percent>,ICourse_PercentDal
         {


         }	

        public partial class DalFactory
        {
            public static ICourse_PercentDal GetCourse_PercentDal()
            {
                return new Course_PercentDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Course_TaskRelDal:BaseDal<Course_TaskRel>,ICourse_TaskRelDal
         {


         }	

        public partial class DalFactory
        {
            public static ICourse_TaskRelDal GetCourse_TaskRelDal()
            {
                return new Course_TaskRelDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Course_WorkDal:BaseDal<Course_Work>,ICourse_WorkDal
         {


         }	

        public partial class DalFactory
        {
            public static ICourse_WorkDal GetCourse_WorkDal()
            {
                return new Course_WorkDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Course_WeekSetDal:BaseDal<Course_WeekSet>,ICourse_WeekSetDal
         {


         }	

        public partial class DalFactory
        {
            public static ICourse_WeekSetDal GetCourse_WeekSetDal()
            {
                return new Course_WeekSetDal();
            }
	    }


	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class Course_WorkCorrectRelDal:BaseDal<Course_WorkCorrectRel>,ICourse_WorkCorrectRelDal
         {


         }	

        public partial class DalFactory
        {
            public static ICourse_WorkCorrectRelDal GetCourse_WorkCorrectRelDal()
            {
                return new Course_WorkCorrectRelDal();
            }
	    }
}