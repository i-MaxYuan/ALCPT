function check_email(origin_email, input_email) {
	var submit = document.getElementById("submit");

	if (origin_email === input_email) {
		submit.disabled = true;
	} else {
		submit.disabled = false;
	}
}