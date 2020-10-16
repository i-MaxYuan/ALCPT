function ChangeButton() {
	var questionNum = document.getElementById("question_num");
	var submit = document.getElementById("submit");
	var types = document.getElementsByName("question_type");

	var click = "";

	for (var i = 0; i < types.length; i++) {
		if (types[i].checked === true) {
			click += types[i].value;
		}
	}
	if (click === "" || questionNum.value === "") {
		submit.disabled = true;
	} else {
		submit.disabled = false;
	}
}