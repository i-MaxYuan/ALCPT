from django.shortcuts import render
from django.http import FileResponse

from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from .definitions import UserType
from .models import Proclamation, User

# Create your views here.


def index(request):
    privileges = UserType.__members__,
    proclamations = Proclamation.objects.filter(is_public=True)
    page = request.GET.get('page', 1)
    paginator = Paginator(proclamations, 5)  # the second parameter is used to display how many items. Now is display 5

    try:
        pros = paginator.page(page)
    except PageNotAnInteger:
        pros = paginator.page(1)
    except EmptyPage:
        pros = paginator.page(paginator.num_pages)

    return render(request, 'proclamation/proclamation.html', locals())


def about(request):
    users = list(User.objects.all())

    # To search top 5 the most practices testees
    answer_sheet_nums = [testee.answersheet_set.count() for testee in users]
    answer_sheetData = zip(users, answer_sheet_nums)
    answer_sheetData = list(answer_sheetData)
    sorted_Data = sorted(answer_sheetData, key=lambda x: x[1], reverse=True)[:5]

    # To search top 5 the highest average score testees
    total_scores = []
    for testee in users:
        tmp = 0
        if testee.answersheet_set.all() is None:
            total_scores.append(0)
            break
        else:
            for answer_sheet in testee.answersheet_set.all():
                if answer_sheet.score is None:
                    pass
                else:
                    tmp += answer_sheet.score
            total_scores.append(tmp)

    average_scoreData = zip(users, total_scores)
    average_scoreData = list(average_scoreData)
    average_score_sortedData = sorted(average_scoreData, key=lambda x: x[1], reverse=True)[:5]

    return render(request, 'SystemDocument/About.html', locals())


def downloadSystemPDF(request):
    file = open('./static/document/project.pdf', 'rb')  # path have to start from root
    response = FileResponse(file)
    response['Content-Type'] = 'application/octet-stream'
    response['Content-Disposition'] = 'attachment;filename="project.pdf"'
    return response


def downloadOperationManual(request):
    file = open('./static/document/ALCPT-Operation-Manual.pdf', 'rb')  # path have to start from root
    response = FileResponse(file)
    response['Content-Type'] = 'application/octet-stream'
    response['Content-Disposition'] = 'attachment;filename="ALCPT-Operation-Manual.pdf"'
    return response


def about_developer(request):
    return render(request, 'SystemDocument/about/developer.html')


def about_SystemManager(request):
    return render(request, 'SystemDocument/about/About_SystemManager.html')


def about_TestManager(request):
    return render(request, 'SystemDocument/about/About_TestManager.html')


def about_TBManager(request):
    return render(request, 'SystemDocument/about/About_TBManager.html')


def about_TBOperator(request):
    return render(request, 'SystemDocument/about/About_TBOperator.html')


def about_Viewer(request):
    return render(request, 'SystemDocument/about/About_Viewer.html')


def about_Testee(request):
    return render(request, 'SystemDocument/about/About_Testee.html')


def OM_System(request):
    return render(request, 'SystemDocument/OperationManual/OM_System.html')


def OM_Report(request):
    return render(request, 'SystemDocument/OperationManual/OM_Report.html')


def OM_User(request):
    return render(request, 'SystemDocument/OperationManual/OM_User.html')


def OM_SystemManager(request):
    return render(request, 'SystemDocument/OperationManual/OM_SystemManager.html')


def OM_TestManager(request):
    return render(request, 'SystemDocument/OperationManual/OM_TestManager.html')


def OM_TBManager(request):
    return render(request, 'SystemDocument/OperationManual/OM_TBManager.html')


def OM_TBOperator(request):
    return render(request, 'SystemDocument/OperationManual/OM_TBOperator.html')


def OM_Viewer(request):
    return render(request, 'SystemDocument/OperationManual/OM_Viewer.html')


def OM_Testee(request):
    return render(request, 'SystemDocument/OperationManual/OM_Testee.html')
