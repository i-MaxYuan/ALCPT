from alcpt.models import UserAchievement, Achievement, AnswerSheet, Exam, User
from alcpt.definitions import Level


def levelup(user_id):
    user = User.objects.get(id=user_id)
    for level in Level:
        if user.level == level.value[0]-1:
            if user.experience >= level.value[1]:
                user.level = user.level + 1
                user.save()
                print("level up")

        else:
            continue


class TestAchievement:
    #user: user的id 5
    #exam_type: 考試類別 4閱讀
    def __init__(self, user: int, achievement_category: int):
        self.user = user
        self.achievement_category = achievement_category


    def exam_achievement(self):
        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)
            #filter 所有exam的achievement
            exam_achievements = achievements.filter(achievement__category=self.achievement_category)
            #計算模擬考了幾次
            exam_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__exam_type=self.achievement_category).count()
            for exam_achievement in exam_achievements:
                exam_achievement.progress = exam_count
                exam_achievement.save()
                if exam_achievement.progress >= exam_achievement.achievement.completion:
                    exam_achievement.unlock = True
                    user.experience +=  exam_achievement.achievement.point
                    exam_achievement.save()
                    user.save()
                    levelup(self.user)
                    return exam_achievement.achievement.name
                else:
                    continue
        except:
            pass

    def comprehensive_achievement(self):
        pass


    def reading_achievement(self):
        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)
            reading_achievements = achievements.filter(achievement__category=self.achievement_category)
            #計算閱讀練習了幾次
            reading_practice_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__exam_type=self.achievement_category).count()
            for reading_achievement in reading_achievements:
                reading_achievement.progress = reading_practice_count
                reading_achievement.save()
                if reading_achievement.progress >= reading_achievement.achievement.completion:
                    reading_achievement.unlock = True
                    user.experience +=  reading_achievement.achievement.point
                    reading_achievement.save()
                    user.save()
                    levelup(self.user)
                    return reading_achievement.achievement.name

                else:
                    continue
        except:

            pass


    def listening_achievement(self):
        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)
            listening_achievements = achievements.filter(achievement__category=self.achievement_category)
            #計算閱讀練習了幾次
            listening_practice_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__exam_type=self.achievement_category).count()
            for listening_achievement in listening_achievements:
                listening_achievement.progress = listening_practice_count
                listening_achievement.save()
                if listening_achievement.progress >= listening_achievement.achievement.completion:
                    listening_achievement.unlock = True
                    user.experience +=  listening_achievement.achievement.point
                    listening_achievement.save()
                    user.save()
                    levelup(self.user)
                    return listening_achievement.achievement.name

                else:
                    continue
        except:

            pass

    myDict = {
        1:exam_achievement,
        2:comprehensive_achievement,
        3:listening_achievement,
        4:reading_achievement,
    }

    def test_achievement(self):
        result = self.myDict[self.achievement_category](self)
        return result
