function file_not_empty() {
	if (document.getElementById("questions_file")) {
		document.getElementById("submit").disabled = false;
	} else {
		document.getElementById("submit").disabled = true;
	}
}


// to change the label, the selected file name will display
$(".custom-file-input").on("change", function() {
	var fileName = $(this).val().split("\\").pop();
	$(this)
		.siblings(".custom-file-label")
		.addClass("selected")
		.html(fileName);
});