function toggle(index) {
	var angle_right_btnIndex = "angle_right_btn_" + index;
	var angle_right_btn = document.getElementById(angle_right_btnIndex);
	var dataIndex = "detailData" + index;
	var data = document.getElementById(dataIndex);
	var iconRightIndex = "iconRight" + index;
	var iconRight = document.getElementById(iconRightIndex);
	var iconDownIndex = "iconDown" + index;
	var iconDown = document.getElementById(iconDownIndex);

	if (data.style.display === "none") {
		angle_right_btn.innerHTML = '<i class="fa fa-angle-down"></i>';
		data.style.display = "table-row";
		iconRight.style.display = "none";
		iconDown.style.display = "block";
	} else {
		angle_right_btn.innerHTML = '<i class="fa fa-angle-right"></i>';
		data.style.display = "none";
		iconRight.style.display = "block";
		iconDown.style.display = "none";
	}
}