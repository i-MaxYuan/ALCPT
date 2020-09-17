from alcpt.models import AnswerSheet

def question_correction(answer_sheet: AnswerSheet):
    answers = answer_sheet.answer_set.all()
    correction_list = []
    for answer in answers:
        if answer.selected == -1:
            pass
        else:
            tmp = []
            for choice in answer.question.choice_set.all():
                tmp.append(choice)


            if tmp[answer.selected-1].is_answer:
                correction_list.append(1)
            else:
                correction_list.append(0)
    return correction_list
