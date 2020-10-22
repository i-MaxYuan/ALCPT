function selectAll() {
	//變數checkItem為checkbox的集合
	var checkItem = document.getElementsByName("proclamation");
	for (var i = 0; i < checkItem.length; i++) {
		checkItem[i].checked = true;
	}
}

function cancelAll() {
	//變數checkItem為checkbox的集合
	var checkItem = document.getElementsByName("proclamation");
	for (var i = 0; i < checkItem.length; i++) {
		checkItem[i].checked = false;
	}
}

function reverseSelect() {
	//變數checkItem為checkbox的集合
	var checkItem = document.getElementsByName("proclamation");
	for (var i = 0; i < checkItem.length; i++) {
		checkItem[i].checked = !checkItem[i].checked;
	}
}

function selectRow(row) {
	var firstInput = row.getElementsByTagName("input")[0];
	firstInput.checked = !firstInput.checked;
}