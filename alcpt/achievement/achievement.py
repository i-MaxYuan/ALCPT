from alcpt.models import UserAchievement, Achievement, AnswerSheet, Exam, User, AnswerSheet
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

#當有新特殊任務時
def special_achievement_create(instance):
    users = User.objects.all().filter(identity=2)
    for user in users:
        if user.level >= int(instance.level):
            UserAchievement.objects.get_or_create(achievement=instance, user=user)

def new_user_special_achievement_create(user):
    special_achievements = Achievement.objects.all().filter(category=0).filter(level=1)
    UserAchievement.objects.bulk_create([UserAchievement(achievement=special_achievement,
                                                        user=user) for special_achievement in special_achievements])
#當user有升級時可能會有新成就可以接
def old_user_special_achievement_update(user):
    special_achievements = Achievement.objects.all().filter(category=0).filter(level=user.level)
    for special_achievement in special_achievements:
        UserAchievement.objects.get_or_create(achievement=special_achievement, user=user)



def exam_special_achievement(achievement: Achievement, users):
    UserAchievement.objects.bulk_create([UserAchievement(achievement=achievement,
                                                        user=user) for user in users])

def special_achievement_exam_settle(exam_id):
    for rank in range(1,4):
        user_achievement = UserAchievement.objects.all().filter(achievement__category=0).filter(achievement__completion=rank)
        achievement_list = UserAchievement.objects.all().filter(achievement__id=user_achievement.achievement.id)
        answersheets = AnswerSheet.objects.all().filter(exam=exam_id).exclude(is_tested=False).order_by('score')[rank-1]
        for answersheet in answersheets:
            for achievement in achievement_list:
                if achievement.user.id == answersheet.user.id:
                    print(achievement.user.id)
                    print(answersheet.user.id)
                    achievement.unlock = True
                    achievement.save()
    #最近的Achievement id
    # user_achievement = user_achievement.filter(user=answersheets[0].user.id)

    # user_achievement.unlock = True
    # user_achievement.save()






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
