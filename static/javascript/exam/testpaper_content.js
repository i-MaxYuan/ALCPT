var clickNum = 1;

function toggle(index) {
	var mainDataIndex = "mainData" + index;
	var mainData = document.getElementById(mainDataIndex);
	var dataIndex = "detailData" + index;
	var data = document.getElementById(dataIndex);
	var iconRightIndex = "iconRight" + index;
	var iconRight = document.getElementById(iconRightIndex);
	var iconDownIndex = "iconDown" + index;
	var iconDown = document.getElementById(iconDownIndex);
	var summaryIndex = "summary_Q_content" + index;
	var summary_Q_content = document.getElementById(summaryIndex);
	var fullIndex = "full_Q_content" + index;
	var full_Q_content = document.getElementById(fullIndex);

	if (data.style.display === "none") {
		mainData.style.backgroundColor = "rgb(220, 220, 220, 0.5)";
		data.style.display = "table-row";
		iconRight.style.display = "none";
		iconDown.style.display = "block";
		summary_Q_content.style.display = "none";
		full_Q_content.style.display = "block";
	} else {
		mainData.style.backgroundColor = "rgb(220, 220, 220, 0)";
		data.style.display = "none";
		iconRight.style.display = "block";
		iconDown.style.display = "none";
		summary_Q_content.style.display = "block";
		full_Q_content.style.display = "none";
	}
}

function toggle_visibility(type) {
	clickNum += 1;
	var all_types = [
      "QA",
      "ShortConversation",
      "Grammar",
      "Phrase",
      "ParagraphUnderstanding",
    ];
	if (type === "all") {
		for (var i = 0; i < all_types.length; i++) {
			var tmp = document.getElementsByClassName(all_types[i]);
			for (var j = 0; j < tmp.length; j++) {
				tmp[j].style.display = "table-row";
			}
		}
	} else {
		var show_type = document.getElementsByClassName(type);

		for (var i = 0; i < all_types.length; i++) {
			var tmp = document.getElementsByClassName(all_types[i]);
			for (var j = 0; j < tmp.length; j++) {
				tmp[j].style.display = "none";
			}
		}

		for (var i = 0; i < show_type.length; i++) {
			show_type[i].style.display = "table-row";
		}
	}
}

function back() {
	history.go(-clickNum);
}