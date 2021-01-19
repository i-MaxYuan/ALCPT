function set_action(action) {
	var form = document.getElementById("notificationForm");
	if (action === "read") {
		form.action = "/proclamation/read/toggle";
	} else {
		form.action = "/proclamation/delete/toggle";
	}
	form.submit();
}

function say_hello() {
	now = new Date(), hour = now.getHours()
	if (hour < 6) {
		document.write("凌晨好！")
	} else if (hour < 9) {
		document.write("早安！")
	} else if (hour < 12) {
		document.write("上午好！")
	} else if (hour < 14) {
		document.write("午安！")
	} else if (hour < 17) {
		document.write("下午好！")
	} else if (hour < 19) {
		document.write("傍晚好！")
	} else if (hour < 22) {
		document.write("晚安！")
	} else {
		document.write("該睡摟！")
	}

}
