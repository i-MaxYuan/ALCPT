function toggle(index) {
	var angle_right_btnIndex = "angle_right_btn_" + index;
	var angle_right_btn = document.getElementById(angle_right_btnIndex);
	var dataIndex = "detailData" + index;
	var data = document.getElementById(dataIndex);
	var iconRightIndex = "iconRight" + index;
	var iconRight = document.getElementById(iconRightIndex);
	var iconDownIndex = "iconDown" + index;
	var iconDown = document.getElementById(iconDownIndex);
	var fullIndex = "full_Q_content" + index;
	var full_Q_content = document.getElementById(fullIndex);
	var summaryIndex = "summary_Q_content" + index;
	var summary_Q_content = document.getElementById(summaryIndex);
	var forumTable = "forum_table"+index;
	var forum_Table = document.getElementById(forumTable);
	var forumComment = "forum_comment"+index;
	var forum_Comment = document.getElementById(forumComment);
	


	if (data.style.display === "none") {
		angle_right_btn.innerHTML = '<i class="fa fa-angle-down"></i>';
		data.style.display = "table-row";
		// iconRight.style.display = "none";
		// iconDown.style.display = "block";
		summary_Q_content.style.display = "none";
		full_Q_content.style.display = "block";
		forum_Table.style.display = "table-row";
		forum_Comment.style.display = "table-row-group";
	} 
	else {
		angle_right_btn.innerHTML = '<i class="fa fa-angle-right"></i>';
		data.style.display = "none";
		// iconRight.style.display = "block";
		// iconDown.style.display = "none";
		summary_Q_content.style.display = "block";
		full_Q_content.style.display = "none";
		forum_Table.style.display = "none";
		forum_Comment.style.display = "none";
	}
}