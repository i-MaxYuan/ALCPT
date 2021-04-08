from enum import Enum
from django.utils.translation import gettext as _

# type and authority od alcpt users
class UserType(Enum):
    SystemManager = (0b100000,'SystemManager', _('SystemManager'))
    TestManager = (0b10000, 'TestManager', _('TestManager'))
    TBManager = (0b1000, 'TBManager', _('TBManager'))
    TBOperator = (0b100, 'TBOperator', _('TBOperator'))
    Viewer = (0b10, 'Viewer', _('Viewer'))
    Testee = (0b1, 'Testee', _('Testee'))

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


# Types of achivement
class AchievementCategory(Enum):
    Exam = (1, '模擬鑑測')
    Listening = (3, '聽力練習')
    Reading = (4, '閱讀練習')
    Red_mark_exam = (5, '模擬考30分以下')
    Red_mark_listening = (6, '聽力練習30分以下')
    Red_mark_reading = (7, '閱讀練習30分以下')


class Level(Enum):
    One = (1, 0)
    Two = (2, 200)
    Three = (3, 500)
    Four = (4, 1000)
    Five = (5, 2000)
    Six = (6, 4000)
    Seven = (7, 6000)
    Eight = (8, 8000)
    Nine = (9, 10000)
    Ten = (10, 12000)
    Eleven = (11, 14000)
    Twelve = (12, 18000)
    Thirteen = (13, 20000)
    Fourteen = (14, 22000)
    Fifteen = (15, 24000)
    Sixteen = (16, 26000)
    Seventeen = (17, 28000)
    Eighteen = (18, 30000)
    Nineteen = (19, 32000)
    Twenty = (20, 34000)
    Twenty_one = (21, 36000)
    Twenty_two = (22, 38000)
    Twenty_three = (23, 40000)
