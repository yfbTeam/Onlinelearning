<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="SSSWeb.CourseManage.CourseDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>我的课程</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link href="../css/sprite.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>

    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <link href="../Scripts/Webuploader/css/webuploader.css" rel="stylesheet" />

    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/KindUeditor/kindeditor-min.js"></script>
    <script src="../Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="../Scripts/KindUeditor/lang/zh_CN.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/PageBar.js"></script>    
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../Scripts/Common.js?parm=1.02"></script>
    <script src="../OnlineLearning/TopicAndComment.js"></script>
    <style>
        .test_lists li .test_lists_right .seedeletion span.closeshow {
            width: 24px;
            height: 24px;
            display: inline-block;
            border-radius: 50%;
            border: 2px solid #A1C8E6;
            line-height: 24px;
            text-align: center;
            cursor: pointer;
            font-size: 16px;
            color: #0A73C0;
            margin-left: 10px;
        }

        .test_lists li .homework_none {
            width: 100%;
        }

        .h-ico {
            display: inline-block;
            width: 20px;
            height: 20px;
            top: 7px;
            left: 0px;
            position: absolute;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script src="../js/menu_top.js"></script>
    <script id="tr_Cource" type="text/x-jquery-tmpl">

        <li class="clearfix">
            <div class="mycourse_img fl" style="cursor:pointer;" onclick="EditCource()">
                <img src="${ImageUrl}" alt=""  onerror="javascript:this.src='../images/course_default.jpg'"/>
             
            </div>
            <div class="fr mycourse_mes">
                <h1 class="mycourse_name" style="cursor:pointer;" onclick="EditCource()">${Name}</h1>
                <h2 class="clearfix">
                    <div class="fl lecturer">
                        讲师：
										<span>${BatchUserName} </span>
                    </div>
                    
                    <div class="fl class_venue">
                        上课场地：
										 <span>${StudyPlace}</span>
                    </div>
                  
                </h2>
                <div class="course_desc">
                    ${CourseIntro}               
                </div>
               
            </div>
        </li>

    </script>
    <script type="text/x-jquery-tmpl" id="li_Evalue">

        <li class="noteitem">
            <div class="notedit">
                <a class="img">
                    <img src="${PhotoURL}">
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <div class="assess note_user fl" id="${Evalue}" style="height: 24px;left:0;top:26px; ">
                            <span id="1"></span>
                            <span id="2"></span>
                            <span id="3"></span>
                            <span id="4"></span>
                            <span id="5"></span>
                        </div>
                        <%--<span class="note_user fl">${Evalue}

                        </span>--%>

                    </div>
                    <div class="notecnt" style="margin-top:25px;">
                        ${EvalueCountent}
                    </div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">
                            ${DateTimeConvert(CreateTime,'yyyy-MM-dd HH:mm')}
                        </div>

                    </div>

                </div>
            </div>
        </li>

    </script>
    <%--目录选项卡下的讨论列表的绑定--%>
    <script id="li_discuss" type="text/x-jquery-tmpl">
        <li class="clearfix" id="li_discuss_${Id}">
           <div class="discuss_img fl">
                <img src="${PhotoURL}" alt="" onerror="javascript:this.src='../images/discuss_img_01.jpg'"/>
                <p>${CreateName}</p>
            </div>
            <div class="discuss_description fl">
                <h2>
                    <a href="javascript:;">${Name}</a>
                    <span class="discuss_date fr">${CreateTime_Format}</span>
                </h2>
                <h1 class="clearfix">
                    <span class="movie fl">{{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                    </span>                    
                </h1>
                <h1 class="clearfix">
                     <div class="clearfix fl caozuo_none">
                                                                      
                    </div>
                    <div class="discuss-wrap fr">
                        <div class="fl comment">
                            <i class="icon icon-comment-alt"></i>
                            (<span id="span_discussreplaycount${Id}">0</span>)
                        </div>
                       
                        <div class="fl thumbs" onclick="ClickGood('${Id}','span_discussgoodcount${Id}');">
                            <i id="span_discussgoodcount${Id}_i" class="icon icon-thumbs-up" {{if GoodCount!=0}}style="color: #21A557;"{{/if}}></i>
                            <span>(<span id="span_discussgoodcount${Id}" isgoodclick="${IsGoodClick}">${GoodCount}</span>)</span>
                        </div>
                    </div>
                </h1>
            </div>
            <div style="clear: both;"></div>
            <div class="comment_wrap clearfix none">
                <ul class="commenta" id="comment_discuss${Id}"></ul>
                <div class="add_commentwrap">
                    <div class="add_comment">
                        <textarea id="commarea_discus${Id}" name="" rows="" cols="" placeholder="请添加你的评论..."></textarea>
                    </div>
                </div>
                <div class="editopt clearfix">
                    <a href="javascript:;" class="fr" onclick="javascript:AddTopic_Comment('${Id}','commarea_discus${Id}','ul_discuss','li_discuss',0,'comment_discuss','li_discusscomment','span_discussreplaycount');">评论</a>
                </div>
            </div>
        </li>
    </script>
    <script id="li_discusscomment" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="imga fl">
                <img src="${PhotoURL}" alt="" onerror="javascript:this.src='../images/discuss_img_01.jpg'" />
            </div>
            <div class="comment_contentwrap">
                <div class="comment_content">
                    <div class="comment_opt">
                        <span class="comment_name">${CreateName}</span>
                        <span class="comment_time">${CreateTime_Format}</span>
                       <%-- {{if IsCreate==1}}
                        <!--删除-->
                        <span class="del fr" onclick="DeleteTopic_Comment('${Id}','${TopicId}','ul_discuss',0,'comment_discuss','li_discusscomment','span_discussreplaycount');"><i class="icon  icon-trash"></i></span>
                        {{/if}} --%>
                    </div>
                    <div class="comment_desc">{{html Contents}}</div>
                </div>

            </div>
        </li>
    </script>

    <%--讨论列表的绑定--%>
    <script id="li_topic" type="text/x-jquery-tmpl">
        <li class="noteitem" id="li_topic_${Id}">
            <div class="notedit">
                <a href="javascript:;" class="img">
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='../images/discuss_img_01.jpg'" />
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">{{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                        </span>
                    </div>
                    <div class="notecnt">${Name}</div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">${CreateTime_Format}</div>
                    </div>
                    <div class="edit_delete mt5 clearfix">
                        <div class="clearfix fl caozuo_none">
                           <%-- {{if IsCreate==1}}
                            <div class="fl" style="color: #0b70bc" onclick="DeleteTopic(${Id},'true');">
                                <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>删除                                                                
                            </div>
                            {{/if}}   --%>                         
                        </div>
                        <div class="note_oper fr clearfix">
                            <div class="fl comment0">
                                <i class="icon icon-comment-alt"></i>
                                <span>(<span id="span_replaycount${Id}">0</span>)</span>
                            </div>
                           
                            <div class="fl thumbs" onclick="ClickGood('${Id}','span_goodcount${Id}');">
                                <i id="span_goodcount${Id}_i" class="icon icon-thumbs-up" {{if GoodCount!=0}}style="color: #21A557;"{{/if}}></i>
                                <span>(<span id="span_goodcount${Id}" isgoodclick="${IsGoodClick}">${GoodCount}</span>)</span>
                            </div>
                        </div>
                    </div>
                    <div class="comment_wrap none">
                        <ul class="commenta" id='comment_tp${Id}'></ul>
                        <div class="add_commentwrap">
                            <div class="add_comment">
                                <textarea id="commarea_${Id}" name="" rows="" cols="" placeholder="请添加你的评论..."></textarea>
                            </div>
                        </div>
                        <div class="editopt clearfix">
                            <a href="javascript:;" class="fr" onclick="javascript:AddTopic_Comment('${Id}','commarea_${Id}');">评论</a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </script>
    <script id="li_comment" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="imga fl">
                <img src="${PhotoURL}" alt="" onerror="javascript:this.src='../images/discuss_img_01.jpg'" />
            </div>
            <div class="comment_contentwrap">
                <div class="comment_content">
                    <div class="comment_opt">
                        <span class="comment_name">${CreateName}</span>
                        <span class="comment_time">${CreateTime_Format}</span>
                      <%--  {{if IsCreate==1}}
                        <!--删除-->
                        <span class="del fr" onclick="DeleteTopic_Comment('${Id}','${TopicId}');"><i class="icon  icon-trash"></i></span>
                        {{/if}} --%> 
                    </div>
                    <div class="comment_desc">{{html Contents}}</div>
                </div>
            </div>
        </li>
    </script>

    <%--笔记列表的绑定--%>
    <script id="li_note" type="text/x-jquery-tmpl">
        <li class="noteitem" id="li_note_${Id}">
            <div class="notedit">
                <a href="javascript:;" class="img">
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='../images/discuss_img_01.jpg'" />
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">{{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                        </span>
                    </div>
                    <div class="notecnt">${Name}</div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">${CreateTime_Format}</div>
                        
                    </div>
                    <div class="edit_delete mt5 clearfix">
                        <div class="clearfix fl caozuo_none">
                           <%-- {{if IsCreate==1}}--%>
                            <div class="fl" style="color: #0b70bc" onclick="DeleteTopic(${Id},'true',1,'ul_note');">
                                <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>删除                                                                
                            </div>
                            <%--{{/if}}     --%>                        
                        </div>
                        <div class="note_oper fr clearfix">
                            <div class="fl share" onclick="ChangeShareStatus('${Id}','img_share_${Id}','1');">
                                <i class="icon">
                                    <img id="img_share_${Id}" isshare="${IsShare}" src="${IsShare==0?'/images/share.png':'/images/share2.png'}" alt="" style="width: 100%" /></i>
                            </div>
                            <div class="fl comment1">
                                <i class="icon icon-comment-alt"></i>
                                <span>(<span id="span_notereplaycount${Id}">0</span>)</span>
                            </div>
                            <%--<div class="fl heart">
                                <i class="icon  icon-heart"></i>
                                <span>(1)</span>
                            </div>--%>
                            <div class="fl thumbs" onclick="ClickGood('${Id}','span_notegoodcount${Id}');">
                                <i id="span_notegoodcount${Id}_i" class="icon icon-thumbs-up" {{if GoodCount!=0}}style="color: #21A557;"{{/if}}></i>
                                <span>(<span id="span_notegoodcount${Id}" isgoodclick="${IsGoodClick}">${GoodCount}</span>)</span>
                            </div>
                        </div>
                    </div>
                    <!--回复信息隐藏-->
                    <div class="comment_wrap none">
                        <ul class="commenta" id='comment_note${Id}'></ul>
                        <div class="add_commentwrap">
                            <div class="add_comment">
                                <textarea id="commarea_note${Id}" name="" rows="" cols="" placeholder="请添加你的评论..."></textarea>
                            </div>
                        </div>
                        <div class="editopt clearfix">
                            <a href="javascript:;" class="fr" onclick="javascript:AddTopic_Comment('${Id}','commarea_note${Id}','ul_note','li_note',1,'comment_note','li_notecomment','span_notereplaycount');">评论</a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </script>
    <script id="li_notecomment" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="imga fl">
                <img src="${PhotoURL}" alt="" onerror="javascript:this.src='../images/discuss_img_01.jpg'" />
            </div>
            <div class="comment_contentwrap">
                <div class="comment_content">
                    <div class="comment_opt">
                        <span class="comment_name">${CreateName}</span>
                        <span class="comment_time">${CreateTime_Format}</span>
                        <%--{{if IsCreate==1}}--%>
                        <!--删除-->
                        <span class="del fr" onclick="DeleteTopic_Comment('${Id}','${TopicId}','ul_note',1,'comment_note','li_notecomment','span_notereplaycount');"><i class="icon  icon-trash"></i></span>
                        <%--{{/if}}  --%>
                    </div>
                    <div class="comment_desc">{{html Contents}}</div>
                </div>

            </div>
        </li>
    </script>
    <%--任务列表的绑定--%>
    <script id="li_task" type="text/x-jquery-tmpl">
        <li class="noteitem">
            <div class="notedit">
                <a href="javascript:;" class="img">
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='../images/discuss_img_01.jpg'" />
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">{{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                        </span>
                    </div>
                    <div class="notecnt" style="cursor: pointer;" onclick="LookTaskStatistics(${ID},'${Name}');">${Name}<span class="test_type ml10" style="padding: 0px 4px;">${TaskType}</span></div>
                    <div class="notecnt" style="cursor: pointer;" onclick="JumpToTask(${RelationID},'${RelName}','${TaskType}','${ChapterID}','${ComCount}','${RelOtherField}','self','tea');">
                        任务：${RelName}                   
                    ( 权重：${Weight} &emsp; <%--学生范围：${ClassStrName}--%>)                     
                    </div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">起止时间：${DateTimeConvert(StartTime,"yyyy-MM-dd HH:mm")}~${DateTimeConvert(EndTime,"yyyy-MM-dd HH:mm")}</div>
                        <div class="note_oper fr clearfix">
                            <%--<div class="fl">
                            <i class="icon icon-thumbs-up"></i>
                            <span>(1)</span>
                        </div>
                        <div class="fl comment3">
                            <i class="icon icon-comment-alt"></i>
                            <span>(1)</span>
                        </div>
                        <div class="fl">
                            <i class="icon  icon-heart"></i>
                            <span>(1)</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon-share"></i>
                            <span>(1)</span>
                        </div>--%>
                        </div>
                    </div>
                     <div class="edit_delete mt5 clearfix">
                        <div class="clearfix fl caozuo_none">
                           <%-- {{if IsCreate==1}}--%>
                            <div class="fl" style="color: #0b70bc" onclick="DeleteTask(${ID},'true');">
                               <i class="icon icon-trash" style="color:#0b70bc;display:inline-block;"></i>删除                                                             
                            </div>
                            <%--{{/if}} --%>
                        </div>
                    </div>
                    <div class="comment_wrap none">
                        <%--<ul class="commenta">
                        <li class="clearfix">
                            <img src="${PhotoURL}" alt="" onerror="javascript:this.src='../images/discuss_img_01.jpg'"/>
                            <div class="comment_contentwrap">
                                <div class="comment_content">
                                    <div class="comment_opt">
                                        <span class="comment_name">你好</span>
                                        <span class="comment_time">4月4号
                                        </span>
                                    </div>
                                    <div class="comment_desc">
                                        kjhj
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="clearfix">
                            <img src="${PhotoURL}" alt="" onerror="javascript:this.src='../images/discuss_img_01.jpg'"/>
                            <div class="comment_contentwrap">
                                <div class="comment_content">
                                    <div class="comment_opt">
                                        <span class="comment_name">你好</span>
                                        <span class="comment_time">4月4号
                                        </span>
                                    </div>
                                    <div class="comment_desc">
                                        kjhj
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>--%>
                        <div class="add_commentwrap">
                            <div class="add_comment">
                                <textarea name="" rows="" cols="">请添加你的评论...</textarea>
                            </div>
                        </div>
                        <div class="editopt clearfix">
                            <a href="javascript:;" class="fr">评论
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </script>
    <%--目录选项卡下的作业列表的绑定--%>
    <script id="li_catalogwork" type="text/x-jquery-tmpl">
        <li id="li_catalogwork_${Id}" class="clearfix">
            <div class="test_description fl">
                <h2><a href="javascript:;">${Name}</a></h2>
                <p>
                    <span>发布人：${CreateName}</span>
                    <span>发布时间：${DateTimeConvert(CreateTime,"yyyy-MM-dd HH:mm")}</span>
                </p>
               <div class="edit_delete mt5 clearfix">
                    <div class="clearfix fl caozuo_none">
                        <%--{{if IsCreate==1}}--%>
                           {{if WorkRelCount==0}}
                            <div class="fl mr10" style="color: #0b70bc;" onclick="EditWork(${Id},'${ChapterID}','${PointID}');">                                
                                <i class="icon icon-edit" style="color: #0b70bc; display: inline-block;"></i>编辑                                 
                            </div>
                            {{/if}}
                            <div class="fl" style="color: #0b70bc" onclick="DeleteWork(${Id});">
                                <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>删除                                                             
                            </div>
                       <%-- {{/if}} --%>
                    </div>
                </div>
            </div>
            <div class="test_lists_right fr clearfix">
                <div class="dates_a  pr" style="width: 220px">
                    <div class="seedeletion" style="margin-top: 0;">
                        <a href="javascript:;" class="homework fl" onclick="DownLoad('${Attachment}');"><i class="icon icon-download-alt" style="color: #fff;"></i>下载布置的作业</a>
                        <span class="closeshow fl">+</span>
                    </div>
                    <div class="data ">
                        提交截止时间：{{if IsCanCorrect==0}}<label style="color: red;">${EndTime_Format}</label>
                        {{else}}${EndTime_Format}{{/if}}
                    </div>
                </div>
            </div>
           
            <div class="homework_none none mt10 clearfix">
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>姓名</th>
                                <th>部门</th>                                
                                <th>提交时间</th>
                                <th>作业</th>
                                <th>是否批改</th>
                                <th>分数</th>
                                <th>成绩等级</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody name="tb_SecondList" id="tb_catelogworkrel_${Id}"></tbody>
                    </table>
                </div>
            </div>
        </li>
    </script>
    <%--目录选项卡下的作业列表二级信息的绑定--%>
    <script id="tr_catalogwork" type="text/x-jquery-tmpl">
        <tr>
            <td>${CreateName}</td>
            <td>${OrgName}</td>          
            <td>${DateTimeConvert(EidtTime,"yyyy-MM-dd HH:mm")}</td>
            <td><a onclick="DownLoad('${Attachment}');" style="cursor:pointer;">${CutFileName(Attachment,20)}</a></td>
            <td>{{if CorrectUID==''}}<span style="color: red;">否</span>{{else}}<span>是</span>{{/if}}</td>
            <td>${Score}</td>
            <td>${StoreLevel}</td>
            <td>
                <i class="icon icon-download-alt" onclick="DownLoad('${Attachment}');" style="color: #0b70bc;"></i>
                <i class="icon" onclick="CorrectWorkClick('${WorkId}',${Id});">
                    <img src="../images/shenpi.png" alt="" /></i>
            </td>
        </tr>
    </script>

    <%--作业列表的绑定--%>
    <script id="li_tabwork" type="text/x-jquery-tmpl">
        <li id="li_tabwork_${Id}">
            <div class="homework_mes clearfix">
                <div class="homework_mes_left fl">
                    <h2><a href="javascript:;" style="cursor: pointer;" onclick="LookWorkStatistics('${Id}','${Name}');">${Name}</a><span class="submit "><label id="lbl_commit_${Id}">${WorkRelCount}</label>人已提交</span><span class="nosubmit " style="cursor: pointer;" onclick="GetStuWorkCompleteInfo('${Id}');"><label id="lbl_nocommit_${Id}">0</label>人未提交</span>
                        <%--{{if IsCreate==1}}--%>
                        <div class="clearfix  dislb caozuo_none pr" style="font-size: 14px;">
                            {{if WorkRelCount==0}}
                            <div class="dislb mr10" style="color: #0b70bc" onclick="EditWork(${Id},'${ChapterID}','${PointID}');">                                
                                <i class="icon icon-edit" style="color: #0b70bc; display: inline-block;"></i>编辑                                 
                            </div>
                            {{/if}}
                            <div class="dislb" style="color: #0b70bc;" onclick="DeleteWork(${Id});">
                                <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>
                                删除
                            </div>
                        </div>
                        <%--{{/if}}  --%>                          
                    </h2>
                    <p>
                        <span>发布人：${CreateName}</span>
                        <span>发布时间：${DateTimeConvert(CreateTime,"yyyy-MM-dd HH:mm")}</span>
                        <span>提交截止时间：{{if IsCanCorrect==0}}<label style="color: red;">${EndTime_Format}</label>
                            {{else}}${EndTime_Format}{{/if}} </span>
                    </p>
                    
                </div>
                <div class="homework_mes_right fr" style="text-align: right;">
                    <div class="homework_mes_a">
                        <a href="javascript:;" class="homework " onclick="LookCurWork('${Id}');"><i class="icon icon-download-alt"></i>查看作业</a>
                        <span class="closeshow">+</span>
                    </div>
                    <div class="data">
                        {{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                    </div>
                </div>
            </div>
            <div class="homework_none none">
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>姓名</th>
                                <th>部门</th>                               
                                <th>提交时间</th>
                                <th>作业</th>
                                <th>是否批改</th>
                                <th>分数</th>
                                <th>成绩等级</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody name="tb_SecondList" id="tb_workrel_${Id}"></tbody>
                    </table>
                </div>
                <!--分页-->
                <%--<div class="page">
                    <a href="javascript:;">1</a>
                    <a href="javascript:;">2</a>
                    <a href="javascript:;">3</a>
                    <a href="javascript:;">4</a>
                    <a href="javascript:;">5</a>
                    <a href="javascript:;" class="on">6</a>
                    <a href="javascript:;">7</a>
                    <a href="javascript:;">8</a>
                    <a href="javascript:;">9</a>
                    <a href="javascript:;">10</a>
                    <a href="javascript:;" class="next">下一页</a>
                    <a href="javascript:;" class="end">尾页</a>
                </div>--%>
            </div>
        </li>
    </script>
    <%--作业列表二级信息的绑定--%>
    <script id="tr_work" type="text/x-jquery-tmpl">
        <tr>
            <td>${CreateName}</td>
            <td>${OrgName}</td>         
            <td>${DateTimeConvert(EidtTime,"yyyy-MM-dd HH:mm")}</td>
            <td><a onclick="DownLoad('${Attachment}');" style="cursor:pointer;">${CutFileName(Attachment,16)}</a></td>
            <td>{{if CorrectUID==''}}<span style="color: red;">否</span>{{else}}<span>是</span>{{/if}}</td>
            <td>${Score}</td>
            <td>${StoreLevel}</td>
            <td>
                <i class="icon icon-download-alt" onclick="DownLoad('${Attachment}');" style="color: #0b70bc;"></i>
                <i class="icon" onclick="CorrectWorkClick('${WorkId}',${Id});">
                    <img src="../images/shenpi.png" alt="" /></i>
            </td>
        </tr>
    </script>
    <style type="text/css">
        .note_oper .heart .icon, .discuss-wrap .heart .icon {
            color: #D84A27;
        }

        .homeworkb {
            display: block;
            float: left;
            width: 84px;
            height: 24px;
            padding: 0px;
        }

            .homeworkb .uploadify {
                left: 2px;
                top: 2px;
            }

            .homeworkb .uploadify-button {
                border: none;
                color: #fff;
                font-weight: normal;
                background: #1775BD;
                font-size: 14px;
            }

        .un_reposity .webuploader-pick {
            position: relative;
            background: none;
            padding: 0;
            line-height: 30px;
            cursor: pointer;
            width: 90px;
            height: 30px;
            color: #fff;
            text-align: center;
            overflow: hidden;
        }
    </style>
</head>
<body>
  
    <form id="form2" runat="server">
        <input type="hidden" id="ChapterID" value="" />
        <input type="hidden" id="HStuIDCard" value="" runat="server" />
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HClassID" runat="server" />
        <input type="hidden" id="Hid_ClassID" value="" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../AppManage/Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/coursesystem.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul id="Menu">
                         <li class="active"><a href="../CourseManage/CourceManage.aspx">课程管理</a></li>
                        <li><a href="../CourseManage/StuManage.aspx?Type=1">进度查看</a></li>

                    </ul>
                   <%--  <ul id="Title2" style="display:none;">
                    <li><a href="../PersonalSpace/CourseManIndex.aspx">课程首页</a></li>
                    <li><a href="../PersonalSpace/PersonalSpace_Student.aspx#course-2">在学课程</a></li>
                    <li class="active"><a href="../PersonalSpace/PersonalSpace_Student.aspx#course-3">我负责的课程</a></li>
                    <li><a href="../PersonalSpace/ApplyCerty.aspx">证书申请</a></li>
                    </ul>--%>
                </nav>
                <div class="search_account fr clearfix">
                    <ul class="account_area fl">
                       
                        <li>
                            <a href="javascript:;" class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=UserInfo.AbsHeadPic%>" />
                                </div>
                                <h2><%=UserInfo.Name%></h2>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr ">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="myexam1 bordshadrad">
               
                <!--面包屑-->
                <div class="crumbs">
                    <a id="Mycource"  style="cursor:pointer;" onclick="javascript:window.history.go(-1)">课程管理</a>
                    <span>></span>
                    <a href="#" id="CourceName"></a>
                </div>
                <div class="mycourse">
                    <ul class="mycourse_lists" id="tb_MyCource" style="height:314px;">
                    </ul>
                </div>
                <!---->
                <%--<div class="coursedetail_nav">
                    <a href="javascript:;" class="on">课程内容</a>
                    <a href="javascript:;" onclick="GetDiscussDataPage(1, 5);">讨论</a>
                    <a href="javascript:;" onclick="GetNoteDataPage(1, 5);">笔记</a>
                    <a href="javascript:;" onclick="GetTaskDataPage(1, 5);">任务</a>
                    <a href="javascript:;" onclick="GetWorkDataPage(1,5);">作业</a>
                    <a href="javascript:;" onclick="GetEvalueDataPage(1,5);">评价</a>

                </div>--%>
                <div class="shadow">
                </div>
            </div>
        </div>
        <div class="width coursedetail_wrap mb10 bordshadrad">
            <div class="coursedetail clearfix pr" style="display: block;">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <div class="coursedetail_items fl">
                    <div class="detail_items_title" style="cursor: pointer;" onclick="addLeftMenu(0,0,this,'menu_side')">
                        课程目录(+)
                    </div>
                    <ul class="item_sides" id="menu_side"></ul>
                </div>

                <div class="coursedetail_right">
                   
                    <h1 class="course_detail clearfix">
                        <div class="fl on">
                            <i class="icon icon_course"></i>
                            <span>视频（<em id="CountVideo">0</em>）</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon_resource"></i>
                            <span>文件（<em id="CountResource">0</em>）</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon_discuss"></i>
                            <span>讨论（<em id="CountTopic">0</em>）</span>
                        </div>
                       
                        <div class="fl">
                            <i class="icon">
                                <img src="../images/homework1.png" /></i>
                            <span>作业（<em id="CountWork">0</em>）</span>
                        </div>

                    </h1>
                    <div class="course_detail_listswrap">
                        <div>
                            <div class="stytem_select_right fr">
                                <a href="javascript:;" onclick="AddWeike(1)" id="UploadVidieo" style="cursor: pointer; padding:8px 17px;">上传视频</a>
                                <a onclick="SelResource(1)"  id="SelVidieo" style="cursor: pointer;  padding:8px 17px;">选择视频</a>
                            </div>
                            <div class="clear">
                            </div>
                            <ul class="course_detail_lists clearfix" id="weike">
                            </ul>
                        </div>
                        <div class="none">
                            <div class="stytem_select_right fr">
                                <a onclick="SelResource(0)" style="cursor: pointer; padding:8px 17px;" id="SelFile">选择资源</a>
                                
                                <div onclick="$('#uploadify').click();" style="border-radius: 2px; background: #1472b9; top: 67px; width: 90px; height: 30px; text-align: center; right: 125px; color: rgb(255, 255, 255); font-size: 12px; display: block; position: absolute; z-index: 2; cursor: pointer;" class="un_reposity">
                                    <div id="filePicker">上传资源</div>
                                </div>
                                <style>
                                    .un_reposity .uploadify-button {
                                        border: none;
                                        background: #1472b9;
                                        font-size: 14px;
                                        color: #fff;
                                        height: 30px;
                                        border-radius: 2px;
                                    }
                                </style>
                            </div>
                            <div class="clear"></div>
                            <ul class="repository_lists mt20" id="Resource">
                            </ul>

                        </div>
                        <div class="none">
                            <ul class="discuss_lists" id="ul_discuss">
                            </ul>
                        </div>
                        <%--<div class="none">
                            <div class="stytem_select_right fr">
                                <a href="javascript:void(0);" onclick="AddTask();" style="cursor: pointer;"><i class="icon icon-plus"></i>新增任务</a>
                            </div>
                            <div class="clear"></div>
                            <ul class="test_lists exam_lists testing" id="Task">
                            </ul>
                        </div>--%>
                        <div class="none">                            
                            <div class="clear"></div>
                            <%--<ul class="test_lists exam_lists testing clearfix" id="ul_catalogwork"></ul>
                             <div class="knowledge_points none">
                                <h1 class="knowledge_title">知识点</h1>
                                <div class="points clearfix" id="div_workknowedge"><a href="javascript:;">暂无知识点！</a></div>
                            </div>--%>
                            <h1 class="course_detail clearfix" style="border-bottom:0;">
                                <a href="javascript:void(0);" onclick="LookCourseWork_Click();" class="btn" style="cursor:pointer;width:150px;float:right;height:30px;border:none;line-height:30px;background:#1775BD;">查看员工提交作业信息</a>
                                <a href="javascript:void(0);" id="a_AddWork" onclick="AddWork();" class="btn" style="cursor: pointer;float:right;height:30px;border:none;line-height:30px;background:#1775BD;margin-right:10px;">发布作业</a>
                            </h1>
                            <ul class="homework_lists" id="ul_tabwork">
                                <li style="border: none;">暂无作业！</li>
                            </ul>
                            <!--分页-->
                            <%--<div class="page">
                                <span id="pageBar_work"></span>
                            </div>--%>
                        </div>

                    </div>
                </div>
            </div>
            <%--<div class="coursedetail clearfix pr none" id="taolun">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--讨论-->
                <div class="discuss_wrap">
                    <div class="note_title">
                        <span class="fl">讨论区</span>
                        <div class="search_exam fr mt5 pr">
                            <input type="text" name="txt_topicTitle" id="txt_topicTitle" value="" onblur="GetDiscussDataPage(1, 5);" placeholder="请输入讨论标题" />
                            <i class="icon  icon-search" style="top: 16px;"></i>
                        </div>
                    </div>
                    
                    <div class="discuss_listswrap">
                        <ul id="ul_topic">
                            <li>暂无讨论！</li>
                        </ul>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="coursedetail clearfix pr none" id="biji">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--笔记-->
                <div class="note_wrap">
                    <div class="note_title">
                        <span class="fl">笔记</span>
                        <div class="search_exam fr mt5 pr">
                            <input type="text" name="txt_noteTitle" id="txt_noteTitle" value="" onblur="GetNoteDataPage(1, 5);" placeholder="请输入笔记标题" />
                            <i class="icon  icon-search" style="top: 16px;"></i>
                        </div>
                    </div>
                    <div class="discuss_listswrap">
                        <ul id="ul_note">
                            <li>暂无笔记！</li>
                        </ul>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar_note"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="coursedetail clearfix pr none" id="renwu">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--任务-->
                <div class="work_wrap">
                    <div class="note_title">
                        <span class="fl">任务</span><div class="search_exam fl ml10 pr">
                            <input type="text" name="txt_taskTitle" id="txt_taskTitle" value="" onblur="GetTaskDataPage(1, 5);" placeholder="请输入任务标题" />
                            <i class="icon  icon-search" style="top: 16px;"></i>
                        </div>
                    </div>
                    
                    <div class="discuss_listswrap">
                        <ul id="ul_task">
                            <li>暂无任务！</li>
                        </ul>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar_task"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="coursedetail clearfix pr coursedetaila" id="zuoye">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--作业-->
                <div>
                    <div class="note_title">
                         <span class="fl">作业</span>
                        <div class="search_exam fr pr mt5">
                            <input type="text" name="txt_workname" id="txt_workname" value="" onblur="GetWorkDataPage(1,5);" placeholder="请输入作业标题" />
                            <i class="icon  icon-search"></i>
                            
                        </div>
                        <div class="search_exam fr pr mt5" style="margin-right:10px;">
                            <input type="text" name="txt_chaptername" id="txt_chaptername" value="" onblur="GetWorkDataPage(1,5);" placeholder="请输入目录名称" />
                            <i class="icon  icon-search"></i>
                        </div>
                    </div>
                   
                </div>
            </div>
            <div class="coursedetail clearfix pr none" id="pingjia">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--讨论-->
                <div class="discuss_wrap">
                    <div class="note_title">
                        <span class="fl">评论列表</span><div class="search_exam fl ml10 pr">
                        </div>
                    </div>

                    <div class="discuss_listswrap">
                        <ul id="ul_Evalue">
                            <li>暂无评价！</li>
                        </ul>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar_Evalue"></span>
                        </div>
                    </div>
                </div>
            </div>--%>
        </div>
        <div id="div_stuContent" class="course_learned fr bordshadrad pr" style="display: none; width: 500px;">
            <p class="learned_title"></p>
            <div class="class_selectwrap">
                <ul class="class_select" id="ul_stuContent"></ul>
            </div>
        </div>

        <a href="#"  style="display:none" download="#"><span id="PostCourseStatic">666</span> </a>
    </form>
    <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/system.js"></script>
        <script src="../Scripts/Webuploader/dist/webuploader.js"></script>

    <script type="text/javascript">



        var UrlDate = new GetUrlDate();

        //修改课程
        function EditCource(id) {
            OpenIFrameWindow('修改课程', 'CourceAdd_NG.aspx?ID=' + UrlDate.itemid, '630px', '540px');
        }

        var upworkid = UrlDate.tabconid || "";
        var cabindex = UrlDate.cab || 0;
        //choose($('.select'));
        //作业折叠
        $('.homework_lists li').find('.closeshow').click(function () {
            var thisparent = $(this).parents('.homework_mes');
            thisparent.next().stop().slideToggle().end().parent().siblings().find('.homework_none').slideUp().end().find(".closeshow").text("+");
            var t = $(this).text();
            $(this).text((t == "+" ? "-" : "+"));
        })
        $('#ul_catalogwork li').find('.closeshow').click(function () {
            var thisparent = $(this).parents('.test_lists_right ');
            thisparent.next().stop().slideToggle().end().parent().siblings().find('.homework_none').slideUp().end().find(".closeshow").text("+");
            var t = $(this).text();
            $(this).text((t == "+" ? "-" : "+"));
        })
        //讨论 笔记目录切换
        $('.coursedetail_nav a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            $('.coursedetail_wrap>div').eq(n).show().siblings().hide();
        })
        //微课 资源 tab切换
        $('.course_detail>div').click(function () {
            $(this).addClass('on').siblings().removeClass();
            var n = $(this).index();
            $('.course_detail_listswrap>div').eq(n).show().siblings().hide();
        })


        $(function () {
            GetSameLiveMenu(document.referrer, '<%=UserInfo.UniqueNo%>', '');

            InitTab();
            //if (UrlDate.Type == "2") {
            //    $("#Title2").show();
            //}
            //else {
            //    $("#Title1").show();
            //}
            if (UrlDate.Position == "Topic") {
                $(".icon_discuss").parent().addClass('on').siblings().removeClass();
                $('.course_detail_listswrap>div').eq(2).show().siblings().hide();

            }
            getData(1, 10);
            uploadFile();
        })

            function InitTab() {
                //选中目录处导航
                $('.course_detail>div:eq(' + cabindex + ')').addClass('on').siblings().removeClass('on');
                $('.course_detail_listswrap>div').eq(cabindex).show().siblings().hide();
            }
            function MenuSide() {  //折叠菜单
                $("#div_knowcontent").hide();

                $('#menu_side').find('li:has(ul)').children('div').click(function () {
                    ClearActiveClass();
                    var $next = $(this).next('ul');
                    if ($next.is(':hidden')) {
                        $(this).parent().siblings().removeClass('active');
                        $(this).parent().addClass('active');
                        $next.stop().slideDown();
                        if ($(this).parent('li').siblings('li').children('ul').is(':visible')) {
                            $(this).parent("li").siblings("li").find("h1").removeClass('active');
                            $(this).parent("li").siblings("li").find("ul").slideUp();
                        }
                    } else {
                        $(this).parent().removeClass('active');
                        $next.stop().slideUp();
                        $(this).next("ul").children("li").find("ul").slideUp();
                        $(this).next("ul").children("li").removeClass('active');
                    }
                    var CrentClass = $(this).attr("class");
                    var id1 = "";
                    var id2 = "";
                    var id3 = "";
                    var ChapterID = "";
                    if (CrentClass == "item_chapter") {
                        id1 = $(this).attr("id").toString().substring(3);
                        ChapterID = id1;
                        //knowStatus = "hide";
                    }
                    else if (CrentClass == "item_knot") {
                        id1 = $(this).parent().parent().prev("div").attr("id").toString().substring(3);
                        id2 = $(this).attr("id").toString().substring(3);
                        ChapterID = id1 + "|" + id2;
                        // knowStatus = "hide";
                    }
                    else {
                        id1 = $(this).parent().parent().parent().parent().prev("div").attr("id").toString().substring(3);
                        id2 = $(this).parent().parent().prev("div").attr("id").toString().substring(3);
                        id3 = $(this).attr("id").toString().substring(3);
                        ChapterID = id1 + "|" + id2 + "|" + id3;
                        //knowStatus = "show";
                    }
                    $("#ChapterID").val(ChapterID);
                    //DisplayKnowledge();
                    BindWeikeResource();
                    BindPutongResource();
                    BindTopic();
                    GetWorkData();
                    uploadFile();
                })

                knotContentHover($('.item_knot'));
                knotContentHover($('.item_content'));
                knotContentHover($('.item_chapter'));
            }
            function knotContentHover(obj) {
                obj.hover(function () {
                    $(this).children('div').show();
                }, function () {
                    $(this).children('div').hide();
                });
            }
            /*
            function DisplayKnowledge() {
                //if (knowStatus == "hide") {
                //    $("#div_knowcontent").hide();
                //    $("#a_AddWork").hide();
                //    catawork_knowedgeid = "";
                //    GetWorkData();
                //} else {
                $("#div_knowcontent").show();
                $("#a_AddWork").show();
                BindKnowledge();
                //}
            }*/
            //取消左侧导航选中事件
            function ClearActiveClass() {
                $("#menu_side li").removeClass("active");
                $("#menu_side li ul li").removeClass("active");
                $("#menu_side  li ul li ul l").removeClass("active");
            }
            var isPower = 1;
            //获取数据
            function getData(startIndex, pageSize) {
                //初始化序号 
                pageNum = (startIndex - 1) * pageSize + 1;
                //name = name || '';
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, ID: UrlDate.itemid },
                    success: OnSuccess,
                    error: OnError
                });
            }
            function OnSuccess(json) {
                if (json.result.errNum.toString() == "0") {
                    $(".nocourse_wrap").css("display", "none");
                    $(".mycourse").css("display", "");

                    $("#tb_MyCource").html('');
                    $("#tr_Cource").tmpl(json.result.retData.PagedData).appendTo("#tb_MyCource");
                    $("#CourceName").html($(".mycourse_name").html());
                    ////加入访问率分析代码////
                    var items = json.result.retData.PagedData;
                    //if (items != null && items.length > 0) {
                    //    addMonnitor(0, items[0].ID, items[0].Name, 0, $("#HUserName").val(), $("#HUserIdCard").val());
                    //}
                    ///////
                    studyTheCourseStaff_Count = items[0].CourseSels;
                    if (UrlDate.nav_index) {
                        $('.coursedetail_nav a').eq(UrlDate.nav_index).click();
                    }
                    Chapator('');
                    BindWeikeResource();
                    BindPutongResource();
                    BindTopic();
                    //GetWorkData();
                    //BindExamPaper();
                    //$("#menu_side").html(chapterDiv);
                    MenuSide();
                }
                else {
                    $("#tb_MyCource").html('<li style="text-align:center">您无权限访问该课程！</li>');
                    isPower = 0;
                }
                hoverEnlarge($('.mycourse_lists li .mycourse_img img'));
            }
            function OnError(XMLHttpRequest, textStatus, errorThrown) {
                $("#tb_MyCource").html('<li style="text-align:center">' + json.result.errMsg.toString() + '</li>');
                isPower = 0;
            }

            // 绑定章节数据
            var chapterDiv = "";
            var i = 0
            var j = 0;
            //var jsonChapator;
            //var knowStatus = "hide";
            function Chapator(pid) {
                $("#menu_side").html("");
                // knowStatus = "hide";
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "Chapator", "CourseID": UrlDate.itemid },
                    success: function (json) {
                        //jsonChapator = json;
                        BindChapator("0", "0", json, pid);
                        $("#menu_side").html(chapterDiv);
                        $("#" + CurDivid).parents("ul").show();

                        //DisplayKnowledge();
                        GetWorkData();
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
                if (chapterDiv.length == 0) {
                    $("#UploadVidieo").hide();
                    $("#SelVidieo").hide();
                    $("#SelFile").hide();
                    $(".un_reposity").hide();
                    $("#a_AddWork").hide();
                    //layer.msg("无目录数据");
                }
                else {
                    $("#UploadVidieo").show();
                    $("#SelVidieo").show();
                    $("#SelFile").show();
                    $(".un_reposity").show();
                    $("#a_AddWork").show();
                }
                //   getData(1, 10);
            }
            var CurDivid = '';
            function BindChapator(pid, perPid, json, Addpid) {
                var Itemclass = "item_content"
                if (perPid == "0" && pid != "0") {
                    Itemclass = "item_knot";
                }
                if (perPid == "0" && pid == "0") {
                    Itemclass = "item_chapter";
                }
                if (json.result.errNum.toString() == "0") {
                    if (Addpid != "") {
                        if (pid == Addpid) {
                            CurDivid = "div" + pid;
                            chapterDiv += "<ul style='display:block'>";
                        }
                        else {
                            if (pid != "0") {
                                chapterDiv += "<ul style='display:none'>";
                            }
                        }
                    }
                    else {
                        if (pid != "0" && perPid == "0" && i == 1) {
                            chapterDiv += "<ul style='display:block'>";
                        }
                        if (pid != "0" && perPid == "0" && i > 1) {
                            chapterDiv += "<ul style='display:none'>";
                        }
                        if (pid != "0" && perPid > 0 && j == 1) {
                            chapterDiv += "<ul style='display:block'>";
                        }
                        if (pid != "0" && perPid > 0 && j > 1) {
                            chapterDiv += "<ul style='display:none'>";
                        }
                    }
                    $(json.result.retData).each(function () {
                        var Type = 0;
                        var divid = "div" + this.ID;
                        if (Itemclass == "item_content") {
                            Type = 4;
                        }
                        var caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick='addLeftMenu(" +
                            this.ID + "," + pid + ", this,\"" + divid + "\"," + Type + ")'>添加</a><a href=\"javascript:void(0)\" onclick=\"EditMenu(this," +
                            this.ID + ",'" + this.Name + "')\">编辑</a><a href=\"javascript:void(0)\" onclick=\"DelMenu(" + this.ID +
                            "," + this.Pid + ")\">删除</a><a href=\"javascript:void(0)\" onclick=\"SortMenu(" + this.ID + ",'up')\">上移</a><a href=\"javascript:void(0)\" onclick=\"SortMenu(" + this.ID +
                            ",'down')\">下移</a></div>";
                        if (Itemclass == "item_content") {
                            caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick=\"EditMenu(this," + this.ID + ",'" + this.Name +
                                "')\">编辑</a>" + "<a href=\"javascript:void(0)\" onclick=\"DelMenu(" + this.ID + "," + this.Pid + ")\">删除</a><a href=\"javascript:void(0)\" onclick=\"SortMenu(" + this.ID + ",'up')\">上移</a><a href=\"javascript:void(0)\" onclick=\"SortMenu(" + this.ID +
                            ",'down')\">下移</a></div>";
                        }

                        if (pid == "0" && this.Pid == pid) {
                            if (i == 0 && Addpid == "") {
                                $("#ChapterID").val(this.ID);

                                chapterDiv += "<li class='active'>";
                            }
                            else {
                                if (this.ID == Addpid) {
                                    chapterDiv += "<li class='active'>";
                                }
                                else {
                                    chapterDiv += "<li>";
                                }
                            }
                            chapterDiv += "<div class=\"item_chapter\" id='" + divid + "'><span>" + this.Name +
                                "</span>" + caozuo + "<i class=\"icon  icon-angle-down\"></i></div>";
                            i++;
                            BindChapator(this.ID, this.Pid, json, Addpid);
                            chapterDiv += "</li>";
                        }
                        if (pid != "0" && this.Pid == pid) {
                            if (this.ID == Addpid) {
                                chapterDiv += "<li class='active'>";
                            }
                            else {
                                chapterDiv += "<li>";
                            }
                            chapterDiv += "<div class=\"" + Itemclass + "\" id='" + divid + "'><span>" + this.Name + "</span>" + caozuo + "</div>"
                            j++;
                            BindChapator(this.ID, this.Pid, json, Addpid);
                            chapterDiv += "</li>"
                        }
                    })
                    if (pid != "0") {
                        chapterDiv += "</ul>";
                    }
                }
                else {
                    //layer.msg(json.result.errMsg);
                }
            }
            function addLeftMenu(id, pid, em, divid, Type) {
                var type = 3;
                var className = "item_content";
                if (pid == 0) {
                    if (id == 0) {
                        type = 1;
                        className = "item_chapter";
                    }
                    else {
                        type = 2;
                        className = "item_knot";
                    }
                }
                var length = 0;
                if (Type == 4) {
                    length = $("#KnowleagPoint input").length;
                    type = 4;
                }
                else {
                    length = $('#menu_side input').length
                }
                if (length == 0) {
                    var v = "<input type='text' value=''  maxlength='20' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"Menu" + id +
    "\"/> <i class=\"icon icon-ok tishi true_t\" style=\"margin: 0px 0px 0px 6px; color: #87c352; float: left;cursor:pointer;\" onclick=\"AddNewMenu('" + id + "',''," + type +
    ")\"></i> <i class=\"icon icon-remove tishi fault_t\" style=\"margin: 0px 0px 0px 6px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"DelCurrentAddMenu(this)\"></i>";

                    if (Type == 4) {
                        $(".points").prepend("<span id='span0'>" + v + "</span>");
                    }
                    else {
                        var html = "<li id='li0'><div  class=\"" + className + "\"> <span>" + v + "</span></div></li><div style=\"clear: both;\"></div>";
                        if (id > 0) {
                            $("#" + divid).next("ul").prepend(html);
                        }
                        else {
                            $("#" + divid).prepend(html);
                        }
                    }
                    $('#menu_side input').parents('ul').show();
                }
                else {
                    layer.msg("有未完成操作");
                    $('#menu_side input').parents('ul').show();
                    $('#menu_side input').focus();
                }
                stopEvent();
            }
            function DelCurrentAddMenu(e) {
                $("#li0").remove();
                $("#span0").remove();

                stopEvent();
            }
            function EditMenu(em, id, name, e) {
                var title = $(em).parent().parent().children("span").html();
                if (name == title) {
                    var v = "<input type='text' value='" + title + "'  maxlength='20' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + id +
            "\"/> <i class=\"icon icon-ok tishi true_t\" style=\"margin: 0px 0px 0px 6px; color: #87c352; float: left;cursor:pointer;\" onclick=\"EditMenuName(this,'" + id + "')\"></i> <i class=\"icon icon-remove tishi fault_t\" style=\"margin: 0px 0px 0px 6px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"EditNameQ(this,'" + name +
            "')\"></i>";
                }
                $(em).parent().parent().children("span").html(v);
                stopEvent();
                //$(em).parents("li").find(".docu_name").removeAttr("onclick");
                // 取消事件冒泡
                var e = arguments.callee.caller.arguments[0] || event; // 若省略此句，下面的e改为event，IE运行可以，但是其他浏览器就不兼容
                if (e && e.stopPropagation) {
                    // this code is for Mozilla and Opera
                    e.stopPropagation();
                } else if (window.event) {
                    // this code is for IE
                    window.event.cancelBubble = true;
                }

            }
            function EditMenuName(em, id, e) {
                var name = $("#txt" + id).val();
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "reMenuName", ID: id, "NewName": name },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            layer.msg("重命名成功");
                            chapterDiv = "";
                            Chapator(id);
                            MenuSide();
                        }
                        else { layer.msg('重命名失败！'); }
                    },
                    error: function (errMsg) {
                        layer.msg('重命名失败！');
                        $(em).parent().parent().children("span").html(oldname);
                    }
                });
                stopEvent();
            }
            //取消修改文件名称
            function EditNameQ(em, name, e) {
                //$(em).parents(".item_chapter").children("span").html(name);
                $(em).parent().parent().children("span").html(name);
                stopEvent();
            }
            //添加导航
            function AddNewMenu(id, e, type) {
                var CourseID = UrlDate.itemid;
                var FileName = $("#Menu" + id + "").val();
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "AddNewMenu", CourseID: CourseID, FileName: FileName, Pid: id, type: type, IdCard: $("#HUserIdCard").val() },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            layer.msg("导航添加成功");
                            var ChildLen = document.getElementById("menu_side").getElementsByTagName("li").length
                            if (ChildLen == 0) {
                                $("#UploadVidieo").show();
                                $("#SelVidieo").show();
                                $("#SelFile").show();
                                $(".un_reposity").show();
                                $("#a_AddWork").show();
                            }
                            chapterDiv = "";
                            i = 0;
                            j = 0;
                            Chapator(id);
                            //作业
                            GetWorkData();
                            MenuSide();
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (errMsg) {
                        layer.msg('导航添加失败！');
                    }
                });
                stopEvent();
            }
            function DelMenu(id, pid) {
                if (confirm("确定要删除当前目录吗？")) {

                    $.ajax({
                        url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "DelMenu", ID: id },
                        success: function (json) {
                            if (json.result.errNum.toString() == "0") {
                                layer.msg("导航删除成功");
                                chapterDiv = "";
                                Chapator(pid);
                                MenuSide();
                            }
                            else {
                                layer.msg(json.result.errMsg);
                            }
                        },
                        error: function (errMsg) {
                            layer.msg('导航删除失败！');
                        }
                    });
                    stopEvent();
                }
            }

            function SortMenu(ID, Type) {
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "SortMenu", ID: ID, Type: Type },
                    success: function (json) {
                        var curindex = 0;
                        if (json.result.errNum.toString() == "0") {
                            layer.msg("修改成功！");
                            chapterDiv = "";
                            Chapator(ID);
                            MenuSide();
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }

            function Show(id) {
                OpenIFrameWindow('视频预览', 'ShowMove.aspx?ID=' + id, '700px', '500px');
            }
            //微课资源
            function BindWeikeResource() {
                var ChapterID = $("#ChapterID").val();

                $("#weike").children().remove();
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    dataType: "json",
                    data: { "PageName": "CourseManage/CouseResource.ashx", "Func": "GetResourceList", CourceID: UrlDate.itemid, IsVideo: 1, ChapterID: ChapterID },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#CountVideo").html(json.result.retData.length);
                            $(json.result.retData).each(function () {
                                var li = " <li><div class=\"course_detail_img\"><img src=\"" + this.VidoeImag + "\" onerror=\"javascript:this.src='../images/viedo_default.jpg'\"/></div><p class=\"course_detail_name\">" +
                                   this.Name + "</p><div class=\"course_detail_bg none\"><i class=\"icon icon-edit\" onclick=\"EditVideo(" + this.ID
                                   + ",'" + this.Name + "','" + this.VidoeImag + "','" + this.FileUrl + "')\" style=\"position:absolute;right:20px;top:4px;width:16px;height:16px;color:#fff;\"></i><i class=\"icon icon-trash\" onclick=\"Delvideo(0," + this.ID
                                   + ")\" style=\"position:absolute;right:4px;top:4px;width:16px;height:16px;color:#fff;\"></i><a onclick=\"Show('" + this.ID + "');\" class='icon-play-circle' style='font-size:50px;'></a></div></li>";
                                $("#weike").append(li);
                            })
                        }
                        else {
                            //layer.msg(json.result.errMsg);
                            $("#CountVideo").html("0");
                        }
                        $('.course_detail_lists li').hover(function () {
                            $(this).find('.course_detail_bg').fadeIn();
                        }, function () {
                            $(this).find('.course_detail_bg').fadeOut();
                        })
                    },
                    error: function (errMsg) {
                        layer.msg('导航删除失败！');
                    }

                });
            }
            function EditVideo(id, Name, ImageUrl, FileUrl) {
                OpenIFrameWindow("视频属性修改", "EditWeike.aspx?ID=" + id + "&Name=" + encodeURI(Name) + "&ImageUrl=" + ImageUrl + "&FileUrl=" + FileUrl, "320px", "320px");
            }
            //删除微课资源
            function Delvideo(type, id) {
                if (confirm("确定要删除资源吗？")) {
                    $.ajax({
                        url: "Uploade.ashx",//random" + Math.random(),//方法所在页面和方法名
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: { "Func": "DelWeike", DelID: id },
                        success: function (json) {
                            if (json.result.errNum.toString() == "0") {
                                layer.msg("删除成功");
                                if (type == "1") {
                                    BindPutongResource();
                                }
                                else {
                                    BindWeikeResource();
                                }
                            }
                            else { layer.msg('删除失败！'); }
                        },
                        error: function (errMsg) {
                            layer.msg(errMsg);
                        }
                    });
                }
            }
            //普通资源
            function BindPutongResource() {
                var ChapterID = $("#ChapterID").val();

                $("#Resource").children().remove();
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "CourseManage/CouseResource.ashx", "Func": "GetResourceList", CourceID: UrlDate.itemid, IsVideo: 0, ChapterID: ChapterID },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#CountResource").html(json.result.retData.length);
                            $(json.result.retData).each(function () {

                                var li = " <li class=\"clearfix\"><i class=\"ico-" + this.postfix.toString().substring(1) + "-min h-ico\"></i><p class=\"repository_name fl\" style='margin-left:15px;'>" +
                    this.Name + this.postfix + "</p><div class=\"repository_download none\" onclick=\"DownLoad('" + this.FileUrl +
                    "');\"> <i class=\"icon icon-download-alt\"></i> </div><div class=\"repository_download none\" style='left:63%' onclick=\"Delvideo(1,'" + this.ID +
                    "');\">  <i class=\"icon icon-trash\"></i></div><span class=\"repository_date fr\">" +
                    this.CreateTime + "</span></li>";
                                $("#Resource").append(li);
                            })
                        }
                        else {
                            //layer.msg(json.result.errMsg);
                            $("#CountResource").html("0");
                        }
                        $('.repository_lists>li').hover(function () {
                            $(this).find('.repository_download').show();
                        }, function () {
                            $(this).find('.repository_download').hide();
                        });
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                });
            }
            function LookTaskStatistics(taskid, taskname) {
                window.open("/CourseManage/Course_TaskStatistics.aspx?taskid=" + taskid + "&coursetype=" + $(".course_type").attr("typevalue") + "&taskname=" + encodeURIComponent(taskname) + "&courseid=" + UrlDate.itemid);
            }
            function AddWeike(IsVideo) {
                var ChapterID = $("#ChapterID").val();
                if (ChapterID == "") {
                    layer.msg("请选择课程目录");
                }
                else {
                    var CourceID = UrlDate.itemid
                    var UserIdCard = $("#HUserIdCard").val()
                    OpenIFrameWindow('新增微课', 'AddWeike.aspx?CourceID=' + CourceID + "&ChapterID=" + $("#ChapterID").val() + "&IsVideo=" + IsVideo + "&UserIdCard=" + UserIdCard, '800px', '650px');
                }
            }
            function SelResource(IsVideo) {
                var CourceID = UrlDate.itemid
                var ChapterID = $("#ChapterID").val();
                if (ChapterID == "") {
                    layer.msg("请选择课程目录");
                }
                else {
                    //OpenIFrameWindow('选择资源', '../ResourceManage/SelResource.aspx?CourceID=' + CourceID + "&ChapterID=" + $("#ChapterID").val() + "&IsVideo=" + IsVideo, '960px', '70%');
                    OpenIFrameWindow('选择资源', '../ResourceManage/SelResouceFromPubResouce.aspx?CourceID=' + CourceID + "&ChapterID=" + $("#ChapterID").val() + "&IsVideo=" + IsVideo, '960px', '70%');


                }
            }


            //评论
            function BindTopic() {
                $("#ul_discuss").children().remove();
                GetTopicDataNotPage(0, "ul_discuss", "li_discuss", "comment_discuss", "li_discusscomment", "span_discussreplaycount");
            }
            function AddTask() {
                OpenIFrameWindow('新增任务', 'Course_TaskAdd.aspx?itemid=0&courseid=' + UrlDate.itemid + '&coursetype=' + $(".course_type").attr("typevalue") + '&ChapterID=' + $("#ChapterID").val(), '600px', '480px');
            }
            function AddWork() {
                var pointid = 0;// $("#KnowleagPoint .on").attr("knowid");
                //if (pointid == undefined || !pointid.length) {
                //    layer.msg("请选中知识点！");
                //    return;
                //}
                OpenIFrameWindow('发布作业', '../OnlineLearning/Course_WorkEdit.aspx?itemid=0&courseid=' + UrlDate.itemid + '&coursetype=' + $(".course_type").attr("typevalue") + '&ChapterID=' + $("#ChapterID").val() + '&pointid=' + pointid, '500px', '410px');
            }
            function EditWork(itemid, chapterID, pointid) {
                OpenIFrameWindow('编辑作业', '../OnlineLearning/Course_WorkEdit.aspx?itemid=' + itemid + '&courseid=' + UrlDate.itemid + '&coursetype=' + $(".course_type").attr("typevalue") + '&ChapterID=' + chapterID + '&pointid=' + pointid, '500px', '410px');
            }
            $('.filtercri>a').click(function () {
                $(this).addClass('on').siblings().removeClass('on');
            });
            var user_pagetype = "tea";

            function LookCourseWork_Click() {
                OpenIFrameWindow('查看提交作业信息', '../OnlineLearning/LookStuWorkStatistics.aspx?courseid=' + UrlDate.itemid + "&coursetype=" + $(".course_type").attr("typevalue"), '600px', '520px')
            }


            /*文件上传*/
            function uploadFile() {
                var CourceID = UrlDate.itemid
                WebUploader.create({
                    pick: '#filePicker',
                    formData: { Func: "UplodWeik", Type: 2, CourceID: CourceID, ChapterID: $("#ChapterID").val(), IsVideo: 0 },
                    accept: {
                        title: 'Images',
                        extensions: 'docx,doc,ppt,pptx,pdf,caj,txt,rar,zip,jpg,gif,png,jpeg,xls,xlsx,mp4,mp3,flv,mpeg,mav,mpg',
                        mimeTypes: 'image/!*'
                    },
                    auto: true,
                    chunked: false,
                    chunkSize: 512 * 1024,
                    server: '/CourseManage/UploadHtml5.ashx',
                    // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
                    disableGlobalDnd: true,
                    fileNumLimit: 100,
                    fileSizeLimit: 200 * 1024 * 1024,    // 200 M
                    fileSingleSizeLimit: 50 * 1024 * 1024    // 50 M
                })
               .on('uploadSuccess', function (file, response) {
                   BindPutongResource();
               }).onError = function (code) {
                   switch (code) {
                       case 'exceed_size':
                           alert('文件大小超出');
                           break;

                       case 'interrupt':
                           alert('上传暂停');
                           break;

                       default:
                           alert('错误: ' + code);
                           break;
                   }
               };
            }


    </script>
       
</body>
</html>
