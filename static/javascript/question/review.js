function toggle(index) {
	var mainDataIndex = "mainData" + index;
	var mainData = document.getElementById(mainDataIndex);
	var dataIndex = "detailData" + index;
	var data = document.getElementById(dataIndex);
	var summaryIndex = "summary_Q_content" + index;
	var summary_Q_content = document.getElementById(summaryIndex);
	var fullIndex = "full_Q_content" + index;
	var full_Q_content = document.getElementById(fullIndex);
	var iconRightIndex = "iconRight" + index;
	var iconRight = document.getElementById(iconRightIndex);
	var iconDownIndex = "iconDown" + index;
	var iconDown = document.getElementById(iconDownIndex);

	if (data.style.display === "none") {
		data.style.display = "table-row";
		iconRight.style.display = "none";
		iconDown.style.display = "block";
		summary_Q_content.style.display = "none";
		full_Q_content.style.display = "block";
	} else {
		data.style.display = "none";
		iconRight.style.display = "block";
		iconDown.style.display = "none";
		summary_Q_content.style.display = "block";
		full_Q_content.style.display = "none";
	}
}