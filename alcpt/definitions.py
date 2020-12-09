from enum import Enum
from django.utils.translation import gettext as _

# type and authority od alcpt users
class UserType(Enum):
    SystemManager = (0b100000, _('SystemManager'))
    TestManager = (0b10000, _('TestManager'))
    TBManager = (0b1000, _('TBManager'))
    TBOperator = (0b100, _('TBOperator'))
    Viewer = (0b10, _('Viewer'))
    Testee = (0b1, _('Testee'))

    # @staticmethod
    # def type_value(privilege: str):
    #     return UserType.__members__.get(privilege).value[0]


# Various types of questions
class QuestionType(Enum):
    # QA = (1, '聽力／問答')
    # ShortConversation = (2, '聽力／簡短對話')
    # Grammar = (3, '閱讀／文法')
    # Phrase = (4, '閱讀／名詞片語')
    # ParagraphUnderstanding = (5, '閱讀／段落理解')
    QA = (1, _('Listening/QA'))
    ShortConversation = (2, _('Listening/Conversation'))
    Grammar = (3, _('Reading/Grammar'))
    Phrase = (4, _('Reading/Phrase'))
    ParagraphUnderstanding = (5, _('Reading/paragraph'))


# The amount of various questions in the moke exam
# QA: 40題
# ShortConversation: 20題
# Grammar: 15題
# Phrase: 15題
# ParagraphUnderstanding: 10題
class QuestionTypeCounts(Enum):
    Exam = ([40, 20, 15, 15, 10], '模擬考')


# Types of exam and practices
class ExamType(Enum):
    Exam = (1, '模擬鑑測')
    Practice = (2, '綜合練習')
    Listening = (3, '聽力練習')
    Reading = (4, '閱讀練習')


class Identity(Enum):
    Visitor = (1, _('Visitor'))
    Student = (2, _('Student'))
    Teacher = (3, _('Teacher'))
