var questionFile = document.getElementById("question_file");
var questionTypeListening = document.getElementById(
	"question_type_listening"
);

var questionTypeReading = document.getElementById("question_type_reading");
var questionContent = document.getElementById("question_content");

var choice1 = document.getElementById("choice1");
var choice2 = document.getElementById("choice2");
var choice3 = document.getElementById("choice3");
var choice4 = document.getElementById("choice4");

var submit = document.getElementById("submit");

var repeat = document.getElementById("repeat");

function OpenButton(kind) {
	if (kind === "reading") {
		Repeated();
		if (
			choice1.value === "" ||
			choice2.value === "" ||
			choice3.value === "" ||
			choice4.value === "" ||
			questionTypeReading.value === "" ||
			questionContent.value === ""
		) {
			submit.disabled = true;
			submit.style.backgroundColor = "grey";
		} else {
			submit.disabled = false;
			submit.style.backgroundColor = "#4CCABD";
		}
	} else {
		if (
			choice1.value === "" ||
			choice2.value === "" ||
			choice3.value === "" ||
			choice4.value === "" ||
			questionTypeListening.value === "" ||
			questionFile.value === ""
		) {
			submit.disabled = true;
		} else {
			submit.disabled = false;
		}
	}
}