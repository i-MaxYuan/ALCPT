from alcpt.models import User, Question


def user_photo_storage(user: User, photo):
    user.photo.save(user.reg_id+"_{}".format(photo), photo, save=True)


def question_file_storage(question: Question, file):
    question.q_file.save("question_{}.mp3".format(question.id), file, save=True)
