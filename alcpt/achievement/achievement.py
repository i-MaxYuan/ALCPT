from alcpt.models import UserAchievement, Achievement, AnswerSheet, Exam, User, AnswerSheet
from alcpt.definitions import Level, AchievementCategory


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

#當有新任務時，所有Testee都能有這個成就
def achievement_create(instance):
    users = User.objects.all().filter(identity=2)
    for user in users:
        # 當user等級比成就可承接等級大或等於時
        if user.level >= int(instance.level):
            UserAchievement.objects.get_or_create(achievement=instance, user=user)


#當新增使用者時所有成就會跟testee產生關聯
def new_user_achievement_create(user):
    for category in AchievementCategory:
        achievements = Achievement.objects.all().filter(category=category.value[0]).filter(level=1)
        UserAchievement.objects.bulk_create([UserAchievement(achievement=achievement,
                                                            user=user) for achievement in achievements])
#當user有升級時可能會有新成就可以接
def old_user_achievement_update(user):
    achievements = Achievement.objects.all().filter(level=user.level)
    for achievement in achievements:
        UserAchievement.objects.get_or_create(achievement=achievement, user=user)



def exam_special_achievement(achievement: Achievement, users):
    UserAchievement.objects.bulk_create([UserAchievement(achievement=achievement,
                                                        user=user) for user in users])

# def special_achievement_exam_settle(exam_id):
#     for rank in range(1,4):
#         user_achievement = UserAchievement.objects.all().filter(achievement__category=0).filter(achievement__completion=rank)
#         achievement_list = UserAchievement.objects.all().filter(achievement__id=user_achievement.achievement.id)
#         answersheets = AnswerSheet.objects.all().filter(exam=exam_id).exclude(is_tested=False).order_by('score')[rank-1]
#         for answersheet in answersheets:
#             for achievement in achievement_list:
#                 if achievement.user.id == answersheet.user.id:
#                     print(achievement.user.id)
#                     print(answersheet.user.id)
#                     achievement.unlock = True
#                     achievement.save()
    #最近的Achievement id
    # user_achievement = user_achievement.filter(user=answersheets[0].user.id)

    # user_achievement.unlock = True
    # user_achievement.save()






class TestAchievement:
    #user: user的id 5
    #exam_type: 考試類別 4閱讀
    def __init__(self, user: int, score: int, exam_type: int ,achievement_category: int):
        self.user = user
        self.score = score
        self.exam_type = exam_type
        self.achievement_category = achievement_category


#######################################   Exam   #################################################

    def exam_achievement(self):
        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)
            #filter 所有exam的achievement
            exam_achievements = achievements.filter(achievement__category=self.exam_type)
            #計算模擬考了幾次
            exam_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__exam_type=self.exam_type).count()
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

    def red_mark_exam(self):
        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)
            if self.score <= 30:
                #red_mark_exam的類別是5, filter 所有跟red mark exam 相關的 achievement
                red_mark_exam_achievements = achievements.filter(achievement__category=self.achievement_category)
                #計算小於30分模擬考了幾次
                red_mark_exam_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__exam_type=self.exam_type).filter(score__lte=30).count()
                for red_mark_exam_achievement in red_mark_exam_achievements:
                    red_mark_exam_achievement.progress = red_mark_exam_count
                    red_mark_exam_achievement.save()
                    if red_mark_exam_achievement.progress >= red_mark_exam_achievement.achievement.completion:
                        red_mark_exam_achievement.unlock = True
                        user.experience += red_mark_exam_achievement.achievement.point
                        red_mark_exam_achievement.save()
                        user.save()
                        levelup(self.user)
                        return red_mark_exam_achievement.name
                    else:
                        continue
        except:
            pass


    def comprehensive_achievement(self):
        pass

#######################################   Listening   #################################################

    def listening_achievement(self):

        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)

            #filter 所有listening的achievement
            listening_achievements = achievements.filter(achievement__category=self.exam_type)
            #計算聽力練習了幾次
            listening_practice_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__exam_type=self.exam_type).count()
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

    def red_mark_listening(self):
        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)
            if self.score <= 30:
                #red_mark_listening的類別是6, filter 所有跟red mark listening 相關的 achievement
                red_mark_listening_achievements = achievements.filter(achievement__category=self.achievement_category)
                #計算小於30分模擬考了幾次
                red_mark_listening_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__exam_type=self.exam_type).filter(score__lte=30).count()
                for red_mark_listening_achievement in red_mark_listening_achievements:
                    red_mark_listening_achievement.progress = red_mark_listening_count
                    red_mark_listening_achievement.save()
                    if red_mark_listening_achievement.progress >= red_mark_listening_achievement.achievement.completion:
                        red_mark_listening_achievement.unlock = True
                        user.experience += red_mark_listening_achievement.achievement.point
                        red_mark_listening_achievement.save()
                        user.save()
                        levelup(self.user)
                        return red_mark_listening_achievement.name
                    else:
                        continue
        except:
            pass
#######################################   Reading   #################################################
    def reading_achievement(self):
        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)

            reading_achievements = achievements.filter(achievement__category=self.exam_type)
            print(reading_achievements)
            #計算閱讀練習了幾次
            reading_practice_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__exam_type=self.exam_type).count()
            for reading_achievement in reading_achievements:
                reading_achievement.progress = reading_practice_count
                if reading_achievement.progress >= reading_achievement.achievement.completion:
                    reading_achievement.unlock = True
                    reading_achievement.save()
                    user.experience +=  reading_achievement.achievement.point
                    print(reading_achievement.unlock)
                    user.save()
                    levelup(self.user)
                    return reading_achievement.achievement.name

                else:
                    continue
        except:
            pass


    def red_mark_reading(self):
        try:
            user = User.objects.get(id=self.user)
            achievements = UserAchievement.objects.all().filter(user=self.user).filter(unlock=False)
            if self.score <= 30:
                #red_mark_reading的類別是7, filter 所有跟red mark reading 相關的 achievement
                red_mark_reading_achievements = achievements.filter(achievement__category=self.achievement_category)
                #計算小於30分模擬考了幾次
                red_mark_reading_count = AnswerSheet.objects.all().filter(user=self.user).filter(exam__exam_type=self.exam_type).filter(score__lte=30).count()
                for red_mark_reading_achievement in red_mark_reading_achievements:
                    red_mark_reading_achievement.progress = red_mark_reading_count
                    red_mark_reading_achievement.save()
                    if red_mark_reading_achievement.progress >= red_mark_reading_achievement.achievement.completion:
                        red_mark_reading_achievement.unlock = True
                        user.experience += red_mark_reading_achievement.achievement.point
                        red_mark_reading_achievement.save()
                        user.save()
                        levelup(self.user)
                        return red_mark_reading_achievement.name
                    else:
                        continue
        except:
            pass










    #number     category
    #   1       模擬測驗
    #   3       聽力練習
    #   4       閱讀練習
    #   5       模擬考0分
    #   6       聽力練習0分
    #   7       閱讀練習0分

    myDict = {
        1:exam_achievement,
        3:listening_achievement,
        4:reading_achievement,

        5:red_mark_exam,
        6:red_mark_listening,
        7:red_mark_reading,


    }

    def test_achievement(self):
        self.myDict[self.exam_type](self)
        self.myDict[self.achievement_category](self)

        return
