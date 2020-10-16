function question_detail(index) {
	var detailIndex = "question_detail" + index;
	var question_detail = document.getElementById(detailIndex);
	var summaryIndex = "summary" + index;
	var summary_q_content = document.getElementById(summaryIndex);
	var fullIndex = "full" + index;
	var full_q_content = document.getElementById(fullIndex);

	if (question_detail.style.display === "none") {
		question_detail.style.display = "table-row";
		summary_q_content.style.display = "none";
		full_q_content.style.display = "table-row";
	} else {
		question_detail.style.display = "none";
		summary_q_content.style.display = "table-row";
		full_q_content.style.display = "none";
	}
}

function selectRow(row) {
	var firstInput = row.getElementsByTagName("input")[0];
	firstInput.checked = !firstInput.checked;
}
var limit = {

	limit_number

};