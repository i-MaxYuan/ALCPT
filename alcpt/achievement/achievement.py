from alcpt.models import UserAchievement, Achievement, AnswerSheet, Exam, User

class TestAchievement:
    #user: user的id 5
    #exam_type: 考試類別 4閱讀
    def __init__(self, user: int, exam_type: int):
        self.user = user
        self.exam_type = exam_type



    def reading_achievement(self):
        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)
            reading_achievements = achievements.filter(achievement__category__contains='練習')
            #計算閱讀練習了幾次
            reading_practice_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__name__contains="閱讀練習").count()
            for reading_achievement in reading_achievements:
                reading_achievement.progress = reading_practice_count
                reading_achievement.save()
                if reading_achievement.progress >= reading_achievement.achievement.completion:
                    reading_achievement.unlock = True
                    user.experience +=  reading_achievement.achievement.point
                    reading_achievement.save()
                    user.save()
                    print("This is success")
                else:
                    continue
        except:
            pass


    myDict = {
        4:reading_achievement,
    }

    def test_achievement(self):
        self.myDict[self.exam_type](self)
