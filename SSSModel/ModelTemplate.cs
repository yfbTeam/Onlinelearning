  
using System;
namespace SSSModel
{    

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_Resource
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CouseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourcesID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsVideo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsAllowDown { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StuRange { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string VidoeImag { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_Selstuinfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StuNo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///0 未完成；1完成 
		/// </summary>
		public Byte? IsFinish { get; set; }
		/// <summary>
		///完成时间 
		/// </summary>
		public DateTime? FinishTime { get; set; }
		/// <summary>
		///最后学习时间 
		/// </summary>
		public DateTime? LastStudyTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_TaskInfo
    {

		/// <summary>
		///课程(章节)任务 主键 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///任务名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///课程编号 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		///章节编号 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		///关联表ID 
		/// </summary>
		public int? RelationID { get; set; }
		/// <summary>
		///学生范围 
		/// </summary>
		public string StuRange { get; set; }
		/// <summary>
		///开始时间 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		///结束时间 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		///任务类型 0学资源(默认)；1试卷；2讨论；3作业；4调查问卷 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		///权重 
		/// </summary>
		public int? Weight { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class crm_log
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? t_users { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string t_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string action { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? s_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string s_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class FeedBack_EnterpriseInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LoginName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string PassWord { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ContactMan { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ContactPhone { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Sort { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Email { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class cust_customer
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? cust_parent_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string cust_name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? cust_type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? cust_level { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string cust_address { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string cust_location { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? cust_users { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string cust_usersname { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? cust_followdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? cust_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? cust_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? cust_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? cust_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string cust_isdelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class cust_linkman
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? link_cust_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_department { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_position { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? link_level { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_sex { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? link_birthday { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_phonenumber { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_telephone { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_email { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? link_users { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_usersname { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? link_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? link_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? link_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? link_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string link_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_Answer
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExamId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? QuestionId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PaperId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_Examination
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExampaperID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Marker { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AnswerBeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AnswerEndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class FeedBack_EnterJob
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EnterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_ObjQuestion
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Catagory { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Klpoint { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionA { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionB { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionC { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionD { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionE { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionF { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Analysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsShowAnalysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_Paper
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Klpoint { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Book { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Catagory { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? FullScore { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExamTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ClassId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? WorkBeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? WorkEndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsRelease { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Evaluate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_PaperExam
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PaperId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AnswerBeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AnswerEndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Marker { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? MarkerTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_PaperObjQ
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PaperId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TypeName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionA { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionB { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionC { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionD { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionE { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionF { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Analysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsShowAnalysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? OrderId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_PaperSubQ
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PaperId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TypeName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Analysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsShowAnalysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? OrderId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class FeedBack_DepartmentStu
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StuNo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EnterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? JobID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ScoreResult { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IdentifidMsg { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EndTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_QuestionType
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? QType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_SubQuestion
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Catagory { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Klpoint { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Analysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsShowAnalysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Order_DishMenu
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UseDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? ScaleID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? DishID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class follow_up
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? follow_userid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string follow_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? follow_cust_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? follow_link_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? follow_date { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string follow_content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? follow_type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string follow_status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? follow_remaindate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string follow_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? follow_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? follow_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? follow_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string follow_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string follow_remark { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string follow_address { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ModelCatogory
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SortNum { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ModelManage
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ModelName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OpenType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ModelCss { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string iconCss { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LinkUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? OrderNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Boolean? IsMenu { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuType { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Order_TimeScale
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string BeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class MyResource
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///网盘ID 
		/// </summary>
		public int? PID { get; set; }
		/// <summary>
		///文件名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///是否文件夹 
		/// </summary>
		public int? IsFolder { get; set; }
		/// <summary>
		///文件地址 
		/// </summary>
		public string FileUrl { get; set; }
		/// <summary>
		///文件大小 
		/// </summary>
		public int? FileSize { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIcon { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string code { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string postfix { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIconBig { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class MyResource_CapacityAll
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? BaseLen { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Order_Dish
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Photo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? HotDegree { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Price { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Description { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class MyResource_CapacityEach
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AddLen { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class param_rule
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string rule_title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string rule_value { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? rule_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? rule_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? rule_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? rule_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string rule_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string rule_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class picture
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string pic_en_table { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string pic_cn_table { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? pic_table_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string pic_url { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? pic_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? pic_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? pic_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? pic_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string pic_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string pic_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Grade
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///年级名称 
		/// </summary>
		public string GradeName { get; set; }
		/// <summary>
		///学段ID 
		/// </summary>
		public int? PeriodID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///备注 
		/// </summary>
		public string Remarks { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Order_DishType
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_GradeOfSubject
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///年级ID 
		/// </summary>
		public int? GradeID { get; set; }
		/// <summary>
		///科目ID 
		/// </summary>
		public int? SubjectID { get; set; }
		/// <summary>
		///学校ID 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Order_UserOrder
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? ScaleID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? DishID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Peaces { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ResourceType
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Postfixs { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EditUser { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CatagoryID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? CourceType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? StuMaxCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseSels { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CourseIntro { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? StudyTerm { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApplyAttr { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StudyPlace { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Grade { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsOpen { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LecturerName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SelMinNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SelMaxNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? WeekID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Period
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///学段名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_PeriodOfSubject
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///学段ID 
		/// </summary>
		public int? PeriodID { get; set; }
		/// <summary>
		///科目ID 
		/// </summary>
		public int? SubjectID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Order_Canteen
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AddressMsg { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Notice { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Photo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string BeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_RoleOfMenu
    {

		/// <summary>
		///角色菜单关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///角色Id 
		/// </summary>
		public int? RoleId { get; set; }
		/// <summary>
		///菜单Id 
		/// </summary>
		public int? MenuId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_RoleOfUser
    {

		/// <summary>
		///角色用户关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///角色Id 
		/// </summary>
		public int? RoleId { get; set; }
		/// <summary>
		///用户身份证号 
		/// </summary>
		public string UserIDCard { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Recruit_Info
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string InfoNo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Photo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string SchoolName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EnrollmentPlan { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? BeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string HotLine { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EnrollMents { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Introduce { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Chapter
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ChapterDescription { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Code { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Sort { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_SchoolOfPeriod
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///学校ID 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///学段ID 
		/// </summary>
		public int? PeriodID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Notice
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ReviwerUserIDS { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ReviwerOrgS { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///1系统通知2学校公告 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsAll { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsTop { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Student
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///身份证件号 
		/// </summary>
		public string IDCard { get; set; }
		/// <summary>
		///学号 
		/// </summary>
		public string SchoolNO { get; set; }
		/// <summary>
		///登录账号 
		/// </summary>
		public string LoginName { get; set; }
		/// <summary>
		///学校ID 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///用户状态 0 启用 1禁用 
		/// </summary>
		public Byte? State { get; set; }
		/// <summary>
		///姓名 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///性别 0男 1女 
		/// </summary>
		public Byte? Sex { get; set; }
		/// <summary>
		///出生日期 
		/// </summary>
		public DateTime? Birthday { get; set; }
		/// <summary>
		///年龄 
		/// </summary>
		public Byte? Age { get; set; }
		/// <summary>
		///照片 
		/// </summary>
		public string Photo { get; set; }
		/// <summary>
		///年级ID 
		/// </summary>
		public int? GradeID { get; set; }
		/// <summary>
		///现住址 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		///最近登录时间 
		/// </summary>
		public DateTime? LatelyLoginTime { get; set; }
		/// <summary>
		///登录IP 
		/// </summary>
		public string LoginIP { get; set; }
		/// <summary>
		///登录标识码 
		/// </summary>
		public string LoginKey { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///备注 
		/// </summary>
		public string Remarks { get; set; }
		/// <summary>
		///昵称 
		/// </summary>
		public string Nickname { get; set; }
		/// <summary>
		///班级ID 
		/// </summary>
		public int? ClassID { get; set; }
		/// <summary>
		///系统Key 
		/// </summary>
		public string SystemKey { get; set; }
		/// <summary>
		///密码 
		/// </summary>
		public string Password { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///联系电话 
		/// </summary>
		public string Phone { get; set; }
		/// <summary>
		///邮箱 
		/// </summary>
		public string Email { get; set; }
		/// <summary>
		///固定电话 
		/// </summary>
		public string fixPhone { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Subject
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///科目名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Teacher
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///身份证件号 
		/// </summary>
		public string IDCard { get; set; }
		/// <summary>
		///用户账号 
		/// </summary>
		public string LoginName { get; set; }
		/// <summary>
		///学校Id 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///用户状态  0启用 1禁用 
		/// </summary>
		public Byte? State { get; set; }
		/// <summary>
		///工号 
		/// </summary>
		public string JobNumber { get; set; }
		/// <summary>
		///姓名 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///性别 0男 1女 
		/// </summary>
		public Byte? Sex { get; set; }
		/// <summary>
		///出生日期 
		/// </summary>
		public DateTime? Birthday { get; set; }
		/// <summary>
		///照片 
		/// </summary>
		public string Photo { get; set; }
		/// <summary>
		///现住址 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		///联系电话 
		/// </summary>
		public string Phone { get; set; }
		/// <summary>
		///备注 
		/// </summary>
		public string Remarks { get; set; }
		/// <summary>
		///最近登录时间 
		/// </summary>
		public DateTime? LatelyLoginTime { get; set; }
		/// <summary>
		///登录IP地址 
		/// </summary>
		public string LoginIP { get; set; }
		/// <summary>
		///登录标识码 
		/// </summary>
		public string LoginKey { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///年龄 
		/// </summary>
		public Byte? Age { get; set; }
		/// <summary>
		///昵称 
		/// </summary>
		public string Nickname { get; set; }
		/// <summary>
		///系统Key 
		/// </summary>
		public string SystemKey { get; set; }
		/// <summary>
		///密码 
		/// </summary>
		public string Password { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///邮箱 
		/// </summary>
		public string Email { get; set; }
		/// <summary>
		///简介 
		/// </summary>
		public string BriefIntroduction { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Textbook
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///教材名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///版本ID 
		/// </summary>
		public int? VersionID { get; set; }
		/// <summary>
		///科目ID 
		/// </summary>
		public int? SubjectID { get; set; }
		/// <summary>
		///学段ID 
		/// </summary>
		public int? PeriodID { get; set; }
		/// <summary>
		///年级ID 
		/// </summary>
		public int? GradeID { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Recruit_Stu
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string InfoNo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Sex { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ContactPhone { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public float? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string GraduSchol { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Intrested { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Msg { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_TextbookCatalog
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///目录名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///上级ID 
		/// </summary>
		public int? PID { get; set; }
		/// <summary>
		///教材ID 
		/// </summary>
		public int? TextbooxID { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_TextbookVersion
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///版本名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class praise
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? praise_table_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string praise_type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? praise_userid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string praise_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? praise_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? praise_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? praise_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? praise_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string praise_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string praise_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Resources_Open
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? DownCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CatagoryID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ChapterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClickCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EvalueCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsOpen { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CheckMessage { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? FileSize { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIcon { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string postfix { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileGroup { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EvalueResult { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsVideo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIconBig { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CheckUsers { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string code { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsFolder { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Appoint_TimeManagement
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///使用状态 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string BeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TimeIntervalId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class pub_param
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string pub_title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? pub_parentid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? pub_value { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? pub_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? pub_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? pub_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? pub_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string pub_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string pub_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Role
    {

		/// <summary>
		///角色表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///角色名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///是否删除 0正常1删除2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class remind
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? rem_userid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? rem_date { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string rem_content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string rem_status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string rem_isopen { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? rem_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? rem_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? rem_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? rem_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string rem_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string rem_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class remind_setting
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? remind_userid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? remind_date { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string remind_type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? remind_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? remind_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? remind_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? remind_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string remind_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string remind_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Resource
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///网盘ID 
		/// </summary>
		public int? PID { get; set; }
		/// <summary>
		///文件名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///是否文件夹 
		/// </summary>
		public int? IsFolder { get; set; }
		/// <summary>
		///文件地址 
		/// </summary>
		public string FileUrl { get; set; }
		/// <summary>
		///文件大小 
		/// </summary>
		public int? FileSize { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIcon { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string code { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string postfix { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIconBig { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class share
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? table_id { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class sign_in
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? sign_userid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sign_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? sign_date { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? sign_cust_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sign_location { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sign_address { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? sign_offset { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sign_x { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sign_y { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? sign_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? sign_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? sign_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? sign_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sign_isdelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class SingActiveTime
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string WeekValue { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string BeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Appoint_AssetManagement
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AssetModel { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Number { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AdressName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UseUnits { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? WarrantyDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Principal { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AcquisitionDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string SourceEquipment { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? UseStatus { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class SomeTableClick
    {

		/// <summary>
		///某些表的点击情况 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///关联表Id 
		/// </summary>
		public int? RelationId { get; set; }
		/// <summary>
		///类型 0 视频资源表（默认）；1 讨论表 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		///观看时间 
		/// </summary>
		public float? WatchTime { get; set; }
		/// <summary>
		///总时长 
		/// </summary>
		public float? TotalTime { get; set; }
		/// <summary>
		///观看的最长时间 
		/// </summary>
		public float? LongTime { get; set; }
		/// <summary>
		///第一次点击时间 
		/// </summary>
		public DateTime? ClickTime { get; set; }
		/// <summary>
		///最后一次点击时间 
		/// </summary>
		public DateTime? LastTime { get; set; }
		/// <summary>
		///点击次数 
		/// </summary>
		public int? ClickNum { get; set; }
		/// <summary>
		///是否看完过 0 未看完（默认）；1 看完 
		/// </summary>
		public Byte? IsLookEnd { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Appoint_ResourceReservation
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ReSourceInfoId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ReSourceClassId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AppoIntmentTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TimeInterval { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string School { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Branch { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Telephone { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string PitchNumber { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LimitPeople { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AppoIntmentPeople { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? ApprovalStutus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApprovalOpinion { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Remark { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Applicant { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Reason { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AppoIntmentBeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AppoIntmentEndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IDCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApprovalPeople { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourceID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Appoint_ResourceReservationCla
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? UseStatus { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class statistic
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_users { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string s_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string s_remark { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_linkman_count { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_sign_count { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_bf_count { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_wrokplan { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_followup_count { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_workreport_count { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_comment { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_cust_customer_count { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_follow_up_all { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? s_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? s_creator { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Appoint_ResourceReservationInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourceId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Floor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Room { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string School { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Branch { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Area { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Galleryful { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Image { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CarDriver { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? ApprovalStutus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ResourceTypeName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OpenTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ClosedTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Model { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LicensePlate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string SeatNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Status { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class statistic_detail
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? sd_users { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sd_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sd_type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sd_week { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? sd_count { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string sd_content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? sd_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? sd_creator { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Appoint_ResourceReservationManagement
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourceTypeId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TimeIntervalId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Appoint_ResourceTimeMappingId
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourceId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TimeIntervalId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///是否删除(0 正常;1 删除) 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Schedule
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? StartDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EndDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AllDay { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? isEndTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Sys_UserInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public Byte? UserType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Sex { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LoginName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UniqueNo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? AuthenType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Appoint_TimeInterval
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourceId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TimeIntervalName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TimeManagementId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///使用状态 
		/// </summary>
		public Byte? UseStatus { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Favorites
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///0 课程展示 ；1 课程详情 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RelationID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Href { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Topic
    {

		/// <summary>
		///论题表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///课程编号 
		/// </summary>
		public int? CouseID { get; set; }
		/// <summary>
		///章节编号 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		///论题名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///论题内容 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		///0 讨论（默认）；1 笔记 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		///点击量 
		/// </summary>
		public int? ClickCount { get; set; }
		/// <summary>
		///GoodCount 
		/// </summary>
		public int? GoodCount { get; set; }
		/// <summary>
		///是否置顶 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsTop { get; set; }
		/// <summary>
		///是否优秀 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsGood { get; set; }
		/// <summary>
		///是否共享 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsShare { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class audio
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string audio_en_table { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string audio_cn_table { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? audio_table_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string audio_url { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? audio_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? audio_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? audio_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? audio_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string audio_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string audio_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Topic_Comment
    {

		/// <summary>
		///评论表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///论题Id 
		/// </summary>
		public int? TopicId { get; set; }
		/// <summary>
		///父级评论Id 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		///评论内容 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateCourse
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CertificateID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Topic_GoodClick
    {

		/// <summary>
		///点赞表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///关联表Id 
		/// </summary>
		public int? RelationId { get; set; }
		/// <summary>
		///类型 0 讨论表（默认）；1 评价表 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateExam
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CertificateID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExamID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public float? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class User_Model_Rel
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserIDCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateList
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Identifier { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IDCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CompleteTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IssuingUnit { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IssuedWebSite { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CertificateID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApplyMessage { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Attachment { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class UserSinLog
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsEffective { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateManage
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Attachment { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ResourcesInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? DownCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CatagoryID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClickCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EvalueCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsOpen { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CheckMessage { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? FileSize { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIcon { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string postfix { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileGroup { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EvalueResult { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsVideo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIconBig { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class UserSkin
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string SkinImage { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateModol
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ModelImage { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class workplan
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? wp_userid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string wp_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string wp_title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string wp_content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? wp_plandate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? wp_reminddate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? wp_cust_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? wp_link_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string wp_status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? wp_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? wp_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? wp_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? wp_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string wp_isdelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ClassCourse
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///班级编号 
		/// </summary>
		public int? ClassID { get; set; }
		/// <summary>
		///课程编号 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class workreport
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? report_userid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? report_type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? report_startdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? report_enddate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_plan { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_reader { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_sender { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? report_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? report_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? report_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? report_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_remark { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_status { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ClickDetail
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourcesID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? ClickTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? LastTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClickNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///1:点击2评价3下载 
		/// </summary>
		public Byte? ClickType { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class v_share
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? work_report_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? report_startdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? report_enddate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_plan { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string report_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? report_type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? report_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? report_userid { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class comment
    {

		/// <summary>
		/// 
		/// </summary>
		public long? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? com_table_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string com_type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? com_parent_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string com_content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? com_userid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string com_username { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? com_createdate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? com_creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? com_updatedate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? com_updateuser { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string com_isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string com_remark { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Catagory
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Evalue
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CouseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ChapterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Evalue { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EvalueCountent { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Percent
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///值 
		/// </summary>
		public string Value { get; set; }
		/// <summary>
		///百分比重 
		/// </summary>
		public int? Percentage { get; set; }
		/// <summary>
		///是否展示 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsShow { get; set; }
		/// <summary>
		///是否统计 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsStatistics { get; set; }
		/// <summary>
		///sql语句 
		/// </summary>
		public string SqlStr { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_TaskRel
    {

		/// <summary>
		///课程(章节)任务关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///任务ID 
		/// </summary>
		public int? TaskID { get; set; }
		/// <summary>
		///是否完成 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsComplete { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Work
    {

		/// <summary>
		///作业表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///课程编号 
		/// </summary>
		public int? CouseID { get; set; }
		/// <summary>
		///章节编号 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		///知识点id 
		/// </summary>
		public int? PointID { get; set; }
		/// <summary>
		///作业名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///作业要求 
		/// </summary>
		public string Requirement { get; set; }
		/// <summary>
		///开始时间 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		///截止时间 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		///附件 
		/// </summary>
		public string Attachment { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_WeekSet
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string WeekIDs { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string WeekNames { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_WorkCorrectRel
    {

		/// <summary>
		///作业批改关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///作业Id 
		/// </summary>
		public int? WorkId { get; set; }
		/// <summary>
		///作业内容 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		///分数 
		/// </summary>
		public int? Score { get; set; }
		/// <summary>
		///分数状态(1优；2良；3中；4差) 
		/// </summary>
		public Byte? ScoreStatus { get; set; }
		/// <summary>
		///批改内容 
		/// </summary>
		public string CorrectContent { get; set; }
		/// <summary>
		///批改人 
		/// </summary>
		public string CorrectUID { get; set; }
		/// <summary>
		///批改时间 
		/// </summary>
		public DateTime? CorrectTime { get; set; }
		/// <summary>
		///附件 
		/// </summary>
		public string Attachment { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }
}
