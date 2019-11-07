from enum import Enum


class UserType(Enum):
    SystemManager = (0b100000, '系統管理員')
    TestManager = (0b10000, '考試管理員')
    TBManager = (0b1000, '題庫管理員')
    TBOperator = (0b100, '題目操作員')
    Viewer = (0b10, '成績檢閱者')
    Testee = (0b1, '受測者')

    # @staticmethod
    # def type_value(user_type: str):
    #     return UserType.__members__.get(user_type).value[0]


class QuestionType(Enum):
    QA = (1, '聽力／問答')
    ShortConversation = (2, '聽力／簡短對話')
    Grammar = (3, '閱讀／文法')
    Phrase = (4, '閱讀／名詞片語')
    ParagraphUnderstanding = (5, '閱讀／段落理解')


class QuestionTypeCounts(Enum):
    Exam = ([40, 20, 15, 15, 10], '模擬考')


class ExamType(Enum):
    Exam = (1, '模擬鑑測')
    Practice = (2, '綜合練習')
    Listening = (3, '聽力練習')
    Reading = (4, '閱讀練習')
