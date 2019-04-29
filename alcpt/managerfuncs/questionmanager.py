import json

from alcpt.definitions import QuestionType
from alcpt.models import Question


def create_question(question_type: QuestionType, question: str, options: list, answer_index: int, file):
    question = Question.objects.create(type=question_type.value[0],
                                       question=question,
                                       option=json.dumps(options),
                                       answer=answer_index)

    if question.question_type is QuestionType.QA:
        if file:
            question.question_file = file

    elif question.question_type is QuestionType.ShortConversation:
        if file:
            question.question_file = file

    elif question.question_type is QuestionType.ParagraphUnderstanding:
        pass

    elif question.question_type is QuestionType.Phrase:
        pass

    elif question.question_type is QuestionType.Grammar:
        pass

    else:
        raise RuntimeError('Question type "{}"'.format(question.question_type.name))

    question.save()

    return question


def update_question(question: Question, description: str, options: list, answer_index: int, file):
    question.question = description
    question.option = json.dumps(options)
    question.answer = answer_index

    if question.question_type is QuestionType.QA:
        if file:
            question.question_file = file

    elif question.question_type is QuestionType.ShortConversation:
        if file:
            question.question_file = file

    elif question.question_type is QuestionType.ParagraphUnderstanding:
        pass

    elif question.question_type is QuestionType.Phrase:
        pass

    elif question.question_type is QuestionType.Grammar:
        pass

    else:
        raise RuntimeError('Question type "{}"'.format(question.question_type.name))

    question.question_type = question.question_type.value[0]
    question.save()

    return question
