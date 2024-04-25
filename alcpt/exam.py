from datetime import datetime, timedelta
import random

from django.shortcuts import render, redirect

from django.views.decorators.http import require_http_methods
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.db import IntegrityError

from alcpt.managerfuncs import testmanager
from alcpt.decorators import permission_check
from alcpt.proclamation import notify
from alcpt.achievement.achievement import exam_special_achievement
from alcpt.definitions import UserType, QuestionType, QuestionTypeCounts, ExamType
from alcpt.models import User, Exam, TestPaper, Group, Question, Proclamation, AnswerSheet, Answer, Achievement, ExamResult
from alcpt.email import notification_mail
from alcpt.exceptions import *
from django.views.generic import View
from alcpt.views import OnlineUserStat
from django.utils.decorators import method_decorator

@method_decorator(permission_check(UserType.TestManager),name='get')
class ExamListView(View,OnlineUserStat):
    
    template_name='exam/exam_list.html'
    
    def do_content_works(self,request):
        now = datetime.now()
        exams = Exam.objects.filter(is_public=True)
        page = request.GET.get('page', 1)
        paginator = Paginator(exams, 10)
        try:
            examList = paginator.page(page)
        except PageNotAnInteger:
            examList = paginator.page(1)
        except EmptyPage:
            examList = paginator.page(paginator.num_pages)
        return dict(exams=exams,
                    examList=examList,
                    paginator=paginator,
                    now=now)


@method_decorator(permission_check(UserType.TestManager),name='get')
class ExamCreateView(View,OnlineUserStat):

    template_name='exam/exam_create.html'

    def do_content_works(self,request):
        special_exam_achievements = Achievement.objects.all().filter(category=0)
        exam_names = [_.name for _ in Exam.objects.all()]
        testpapers = TestPaper.objects.filter(is_testpaper=True, valid=True)
        groups = Group.objects.all()
        dateList = []
        now_date = datetime.now().strftime('%Y-%m-%d')
        now_datetime=datetime.now()
        dateList.append(now_date)
        for i in range(20):
            now_date = datetime.strptime(now_date, '%Y-%m-%d')
            now_date = now_date + timedelta(days=1)
            now_date = now_date.strftime('%Y-%m-%d')
            dateList.append(now_date)
        hourList = []
        for i in range(24):
            hourList.append(str(i))
        minuteList = []
        for i in range(0, 60):
            if i % 5 == 0:
                minuteList.append(str(i))
        return dict(exam_names=exam_names,
                    testpapers=testpapers,
                    groups=groups,
                    dateList=dateList,
                    hourList=hourList,
                    minuteList=minuteList)
    
    def post(self,request):
        date = request.POST.get('start_time_date')
        hour = request.POST.get('start_time_hour')
        minute = request.POST.get('start_time_minute')
        start_time = date + " " + hour + ":" + minute
        
        now_datetime=datetime.now()
        selected_datetime = datetime.strptime(start_time, '%Y-%m-%d %H:%M')
        if selected_datetime < now_datetime:
            messages.error(request, "Unvalid time.")
            return redirect('exam_create')
        
        duration = request.POST.get('duration')
        started_time = datetime.strptime(str(start_time), '%Y-%m-%d %H:%M')
        finish_time = datetime.strptime(str(start_time), '%Y-%m-%d %H:%M') + timedelta(minutes=int(duration))

        testpaper = TestPaper.objects.get(id=int(request.POST.get('selected_testpaper')))
        selected_group = Group.objects.get(id=int(request.POST.get('selected_group')))
        
        try:
            exam_name = request.POST.get('exam_name')
            Exam.objects.get(name = exam_name)
            messages.error(request, "Failed created, exam name had been used.")
            return redirect('exam_create')
        except:
            exam_name = request.POST.get('exam_name')
            exam = Exam.objects.create(name=exam_name,
                                       exam_type=ExamType.Exam.value[0],
                                       start_time=start_time,
                                       created_time=datetime.now(),
                                       duration=duration,
                                       finish_time=finish_time,
                                       testpaper=testpaper,
                                       is_public=True,
                                       created_by=request.user)
            testpaper.is_used = True
            testpaper.save()
            notification_mail_content = "You will start " + exam.name + "\n" + \
                                        "Start Time: " + start_time + "\n" + \
                                        "Duration: " + duration + " minutes.\n" + \
                                        "Please notice the time, do not forget it.\n\n" + \
                                        "This is an automatic notification mail from system, " \
                                        "please do not reply directly.\n" + \
                                        "Thanks for your cooperation, hope you get good grades."
            for testee in selected_group.member.all():
                exam.testeeList.add(testee)
                exam.save()
                AnswerSheet.objects.create(exam=exam, user=testee)
                answer_sheet = AnswerSheet.objects.get(exam=exam, user=testee)
                exams = Exam.objects.get(id=exam.id)
                all_questions = list(exams.testpaper.question_list.all())
                random.shuffle(all_questions)
                for question in all_questions:
                    Answer.objects.create(answer_sheet=answer_sheet, question=question)
            proclamation_content = "Start Time: " + start_time + "\n" + \
                                   "Duration: " + duration + " minutes.\n"
            notify(title=exam.name,
                   text=proclamation_content,
                   is_read=False,
                   is_public=False,
                   announcer=request.user,
                   exam_id=exam.id,
                   report_id=0,
                   users=list(User.objects.filter(exam__testeeList__exam=exam).distinct()))
            
            if ExamResult.objects.filter(exam=exam.id).exists() == False:
                ExamResult.objects.create(exam=exam,testee_num=len(exam.testeeList.all()))
            
            messages.success(request, "Successfully created a new exam.")
            return redirect('exam_list')


@method_decorator(permission_check(UserType.TestManager),name='get')
class ExamContentView(View,OnlineUserStat):
    
    template_name='exam/exam_content.html'
    
    def do_content_works(self,request,exam_id):
        try:
            exam = Exam.objects.get(id=exam_id)
        except ObjectDoesNotExist:
            messages.error(request, "Exam does not exist.")
        return dict(exam=exam)

@method_decorator(permission_check(UserType.TestManager),name='get')
class ExamEditView(View, OnlineUserStat):
    
    template_name = 'exam/exam_edit.html'
    
    def do_content_works(self,request,exam_id):
        try:
            exam = Exam.objects.get(id=exam_id)
            # if exam.start_time < datetime.now():
            #     messages.error(request, "Exam has started, cannot be edited.")
            #     return redirect('exam_list')
            
            testpapers = TestPaper.objects.filter(is_testpaper=True, valid=True)
            groups = Group.objects.all()

            original_date = exam.start_time.strftime('%Y-%m-%d')
            original_hour = exam.start_time.strftime('%H')
            original_minute = exam.start_time.strftime('%M')
            
            dateList = []
            now_date = datetime.now().strftime('%Y-%m-%d')
            dateList.append(now_date)
            for i in range(20):
                now_date = datetime.strptime(now_date, '%Y-%m-%d')
                now_date = now_date + timedelta(days=1)
                now_date = now_date.strftime('%Y-%m-%d')                    
                dateList.append(now_date)

            hourList = []
            for i in range(24):
                hourList.append(str(i))

            minuteList = [0]
            for i in range(1, 60):
                if i % 5 == 0:
                    minuteList.append(str(i))
            context={'exam':exam,
                     'testpapers':testpapers,
                     'groups':groups,
                     'dateList':dateList,
                     'hourList':hourList,
                     'minuteList':minuteList}
            return context
        
        except ObjectDoesNotExist:
            messages.error(request, "Exam does not exist, exam id - {}".format(exam_id))
            return redirect('exam_list')
        
    def post(self,request,exam_id):
        try:
            exam = Exam.objects.get(id=exam_id)
            
            exam_name = request.POST.get('exam_name')
            date = request.POST.get('start_time_date')
            hour = request.POST.get('start_time_hour')
            minute = request.POST.get('start_time_minute')
            start_time = date + " " + hour + ":" + minute
            duration = request.POST.get('duration')
            started_time = datetime.strptime(str(start_time), '%Y-%m-%d %H:%M')
            finish_time = datetime.strptime(str(start_time), '%Y-%m-%d %H:%M') + timedelta(minutes=int(duration))

            testpaper = TestPaper.objects.get(id=int(request.POST.get('selected_testpaper')))
            TestPaper.objects.filter(id=int(request.POST.get('selected_testpaper'))).update(is_used=True)
            
            exam.name = exam_name
            exam.start_time = start_time
            exam.duration = duration
            exam.finish_time = finish_time
            exam.testpaper = testpaper
            exam.save()
            
            messages.success(request, "Successfully updated exam - {}".format(exam.name))
            return redirect('exam_list')
        except ObjectDoesNotExist:
            messages.error(request, "Exam does not exist, exam id - {}".format(exam_id))
            return redirect('exam_list')

# @method_decorator(permission_check(UserType.TestManager),name='get')
# class ExamEditView(View,OnlineUserStat):
    
#     template_name='exam/exam_edit.html'
    
#     def do_content_works(self,request,exam_id):
#         try:
#             exam = Exam.objects.get(id=exam_id)
#             if exam.start_time < datetime.now():
#                 messages.error(request, "Exam has started, cannot be edited.")
#                 return redirect('exam_list')
#             testpapers = TestPaper.objects.filter(is_testpaper=True, valid=True)
#             groups = Group.objects.all()
            
#             original_date = exam.start_time.strftime('%Y-%m-%d')
#             original_hour = exam.start_time.strftime('%H')
#             original_minute = exam.start_time.strftime('%M')
            
#             dateList = []
#             now_date = datetime.now().strftime('%Y-%m-%d')
#             dateList.append(now_date)
#             for i in range(20):
#                 now_date = datetime.strptime(now_date, '%Y-%m-%d')
#                 now_date = now_date + timedelta(days=1)
#                 now_date = now_date.strftime('%Y-%m-%d')
#                 dateList.append(now_date)

#             hourList = []
#             for i in range(24):
#                 hourList.append(str(i))

#             minuteList = [0]
#             for i in range(1, 60):
#                 if i % 5 == 0:
#                     minuteList.append(str(i))
            
#             return  dict(exam=exam,
#                         testpapers=testpapers,
#                         groups=groups,
#                         original_date=original_date,
#                         original_hour=original_hour,
#                         original_minute=original_minute,
#                         dateList=dateList,
#                         now_date=now_date,
#                         hourList=hourList,
#                         minuteList=minuteList)
            
#         except ObjectDoesNotExist:
#             messages.error(request, "Exam does not exist.")
#             return redirect('exam_list')
        
#     def post(self,request,exam_id):
#         try:
#             exam = Exam.objects.get(id=exam_id)
            
#             exam_name = request.POST.get('exam_name')
#             date = request.POST.get('start_time_date')
#             hour = request.POST.get('start_time_hour')
#             minute = request.POST.get('start_time_minute')
#             start_time = date + " " + hour + ":" + minute
#             duration = request.POST.get('duration')
#             started_time = datetime.strptime(str(start_time), '%Y-%m-%d %H:%M')
#             finish_time = datetime.strptime(str(start_time), '%Y-%m-%d %H:%M') + timedelta(minutes=int(duration))

#             testpaper = TestPaper.objects.get(id=int(request.POST.get('selected_testpaper')))
#             TestPaper.objects.filter(id=int(request.POST.get('selected_testpaper'))).update(is_used=True)
#             selected_group = Group.objects.get(id=int(request.POST.get('selected_group')))
#             exam.testeeList.clear()
#             for member in selected_group.member.all():
#                 exam.testeeList.add(member)
            
#             exam.name = exam_name
#             exam.start_time = start_time
#             exam.duration = duration
#             exam.finish_time = finish_time
#             exam.testpaper = testpaper
#             exam.save()
            
#             messages.success(request, "Successfully updated exam.")
#             return redirect('exam_list')
#         except ObjectDoesNotExist:
#             messages.error(request, "Exam does not exist.")
#             return redirect('exam_list')


@method_decorator(permission_check(UserType.TestManager),name='get')
class ExamDeleteView(View):
    def get(self, request, exam_id):
        try:
            exam = Exam.objects.get(id=exam_id)
            if datetime.now() > exam.start_time:
                messages.error(request, "Failed deleted, this Exam had started.")
                return redirect('exam_list')
        # proclamation_title = "Cancel " + exam.name + "."
        # proclamation_content = exam.name + " had been canceled. Thank you for your cooperation."
        # notify(
        #        title=proclamation_title,
        #        text=proclamation_content,
        #        is_read=False,
        #        is_public=False,
        #        announcer=request.user,
        #        users=list(User.objects.filter(exam__testeeList__exam=exam).distinct()))
            else:
                exam.testeeList.clear()
                exam.delete()
                messages.success(request, "Successfully deleted.")
                return redirect('exam_list')

        except ObjectDoesNotExist:
            messages.error(request, "Exam does not exist.")
            return redirect('exam_list')


@method_decorator(permission_check(UserType.TestManager),name='get')
# def testpaper_list(request):
#     testpaper_name = request.GET.get('testpaper_name')

#     if testpaper_name:
#         testpapers = TestPaper.objects.filter(is_testpaper=True).filter(name__contains=testpaper_name).order_by("-created_time")
#     else:
#         testpapers = TestPaper.objects.filter(is_testpaper=True).order_by("-created_time")

#     page = request.GET.get('page', 1)
#     paginator = Paginator(testpapers, 10)  # the second parameter is used to display how many items. Now is display 10

#     try:
#         testpaperList = paginator.page(page)
#     except PageNotAnInteger:
#         testpaperList = paginator.page(1)
#     except EmptyPage:
#         testpaperList = paginator.page(paginator.num_pages)

#     context={'testpapers':testpapers,
#              'testpaperList':testpaperList,
#              'paginator':paginator}
#     return render(request, 'exam/testpaper_list.html', context)
class TestpaperListView(View,OnlineUserStat):
    
    template_name='exam/testpaper_list.html'
    
    def do_content_works(self,request):
        testpaper_name = request.GET.get('testpaper_name')
        if testpaper_name:
            testpapers = TestPaper.objects.filter(is_testpaper=True).filter(name__contains=testpaper_name).order_by("-created_time")
        else:
            testpapers = TestPaper.objects.filter(is_testpaper=True).order_by("-created_time")

        page = request.GET.get('page', 1)
        paginator = Paginator(testpapers, 10)  # the second parameter is used to display how many items. Now is display 10

        try:
            testpaperList = paginator.page(page)
        except PageNotAnInteger:
            testpaperList = paginator.page(1)
        except EmptyPage:
            testpaperList = paginator.page(paginator.num_pages)
            

        return dict(testpapers=testpapers,
                    testpaperList=testpaperList,
                    paginator=paginator)


@method_decorator(permission_check(UserType.TestManager),name='get')
class TestpaperContentView(View,OnlineUserStat):
    
    template_name='exam/testpaper_content.html'
    
    def do_content_works(self,request,testpaper_id):
        try:
            testpaper = TestPaper.objects.get(id=testpaper_id)
        except ObjectDoesNotExist:
            messages.error(request, 'Test paper does not exist.')
            return redirect('testpaper_list')

        questions = testpaper.question_list.all().order_by('q_type')
        return dict(questions=questions)


@method_decorator(permission_check(UserType.TestManager),name='get')
class TestpaperCreateView(View,OnlineUserStat):
    
    template_name='exam/testpaper_create.html'
    
    def do_content_works(self,request):
        testpaper_names = [_.name for _ in TestPaper.objects.all()]
        return dict(testpaper_names=testpaper_names)
        
    def post(self,request):
        testpaper_name = request.POST.get('testpaper_name')
        try:
            testpaper = testmanager.create_testpaper(name=testpaper_name, created_by=request.user, is_testpaper=1)
            messages.success(request, 'Successfully created test paper.')
            return redirect('testpaper_edit', testpaper_id=testpaper.id)
        except:
            messages.error(request, "This name had existed.")
            testpaper_names = [_.name for _ in TestPaper.objects.all()]
            return dict(testpaper_names=testpaper_names)


@permission_check(UserType.TestManager)
def testpaper_valid(request, testpaper_id):
    testpaper = TestPaper.objects.get(id=testpaper_id)
    testpaper.valid = True
    messages.success(request, 'Successfully valid test paper.')
    testpaper.save()
    return redirect('testpaper_list')

def testpaper_unvalid(request, testpaper_id):
    testpaper = TestPaper.objects.get(id=testpaper_id)
    if testpaper.is_used:
        messages.warning(request, "This test paper already used, cannot change valid status.")
        return redirect('testpaper_list')
    testpaper.valid = False
    messages.success(request, 'Successfully unvalid test paper.')
    testpaper.save()
    return redirect('testpaper_list')

@method_decorator(permission_check(UserType.TestManager),name='get')
class TestpaperEditView(View):
    def get(self,request,testpaper_id):
        try:
            testpaper = TestPaper.objects.get(id=testpaper_id)

            if testpaper.valid and testpaper.is_used:
                messages.warning(request, "This test paper already used, cannot edit again.")
                return redirect('testpaper_list')
            # elif testpaper.valid==False and testpaper.is_used:
            #     messages.warning(request,"It is unvalid.")
            #     return redirect('testpaper_list')
            else:
                question_types = list(QuestionType.__members__.values())  # 5 types of question in definition
                question_type_counts = list(QuestionTypeCounts.Exam.value[0])  # Each type has been defined its question amount

                all_selected_questions = testpaper.question_list.all()  # Had been selected questions in this test paper.
                selected_question_type_nums = [len(all_selected_questions.filter(q_type=1)),
                                           # The number that had been selected for each type.
                                           len(all_selected_questions.filter(q_type=2)),
                                           len(all_selected_questions.filter(q_type=3)),
                                           len(all_selected_questions.filter(q_type=4)),
                                           len(all_selected_questions.filter(q_type=5))]

                testpaper_data = zip(question_types, question_type_counts, selected_question_type_nums)
                context={'testpaper':testpaper,
                         'testpaper_data':testpaper_data}
                return render(request, 'exam/testpaper_edit.html', context)
        except ObjectDoesNotExist:
            messages.error(request, 'Test paper does not exist.')
            return redirect('testpaper_list')
        
    def post(self,request,testpaper_id):
        try:
            testpaper = TestPaper.objects.get(id=testpaper_id)
            testpaper.name = request.POST.get('testpaper_name')
            if testmanager.quantity_confirmation(testpaper):
                testpaper.valid = True
                for question in testpaper.question_list.all():
                    updateNum = question.issued_freq + 1
                    Question.objects.filter(id=question.id).update(issued_freq=updateNum)
                testpaper.save()
                messages.success(request, "Successfully edited.")

        except IntegrityError:
            messages.warning(request, "This name has existed.")
        return redirect('testpaper_list')
        

@permission_check(UserType.TestManager)
def testpaper_delete(request, testpaper_id):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)
        if testpaper.is_testpaper and testpaper.is_used:
            messages.warning(request, 'This test paper already used, cannot delete.')
        else:
            for question in testpaper.question_list.all():
                testpaper.question_list.remove(question)

            messages.success(request, 'Successfully deleted test paper.')
            testpaper.delete()
        return redirect('testpaper_list')

    except ObjectDoesNotExist:
        messages.error(request, 'Test paper does not exist.')
        return redirect('testpaper_list')


@method_decorator(permission_check(UserType.TestManager),name='get')
class ManualPickView(View,OnlineUserStat):
    
    template_name='exam/manual_pick.html'
    
    def do_content_works(self,request,testpaper_id,question_type):
        try:
            testpaper = TestPaper.objects.get(id=testpaper_id)
            for q_type in QuestionType.__members__.values():
                if q_type.value[0] == int(question_type):
                    question_type = q_type
                    break

            all_questions = Question.objects.filter(state=1).filter(q_type=question_type.value[0]).order_by('id')
            selected_questions = testpaper.question_list.filter(q_type=question_type.value[0])
            limit_number = QuestionTypeCounts.Exam.value[0][question_type.value[0]-1]
            return dict(testpaper=testpaper,
                        question_type=question_type,
                        selected_questions=selected_questions,
                        limit_number=limit_number,
                        all_questions=all_questions)
        except ObjectDoesNotExist:
            messages.error(request, 'Test paper does not exist.') 
                 
    def post(self,request,testpaper_id,question_type):
        testpaper = TestPaper.objects.get(id=testpaper_id)
        selected_question_ids = request.POST.getlist('question')

        selected_questions = []
        for questionID in selected_question_ids:
            selected_questions.append(Question.objects.get(id=questionID))

        for question in selected_questions:
            testpaper.question_list.add(question)
            
        for question in testpaper.question_list.all().filter(q_type=question_type):
            if question not in selected_questions:
                testpaper.question_list.remove(question)

            messages.success(request, "Successfully picked.")
            return redirect('testpaper_edit', testpaper_id=testpaper.id)


@permission_check(UserType.TestManager)
def auto_pick(request, testpaper_id, question_type, difficulty):
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)

        if testmanager.quantity_confirmation(testpaper=testpaper):
            messages.warning(request, 'This type had reached limit amount.')
            return redirect('/exam/testpaper/{}/edit'.format(testpaper_id))
        selected_num = testmanager.auto_pick(testpaper=testpaper, question_type=int(question_type), difficulty=int(difficulty))

        messages.success(request, selected_num)
    except ObjectDoesNotExist:
        messages.error(request, 'Test paper does not exist.')

    return redirect('/exam/testpaper/{}/edit'.format(testpaper_id))


@permission_check(UserType.TestManager)
def reset_pick(request, testpaper_id, question_type):
    QUESTION_TYPE = {
        '1':'Listening／QA',
        '2':'Listening／Conversation',
        '3':'Reading／Grammar',
        '4':'Reading／Phrase',
        '5':'Reading／Paragraph',}
    try:
        testpaper = TestPaper.objects.get(id=testpaper_id)
        for question in testpaper.question_list.all().filter(q_type=question_type):
            testpaper.question_list.remove(question)
        messages.success(request, "{} has been reset".format(QUESTION_TYPE[question_type]))
    except ObjectDoesNotExist:
        messages.error(request, 'Test paper does not exist.')

    return redirect('/exam/testpaper/{}/edit'.format(testpaper_id))
