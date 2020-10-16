function searchFunction() {
	var input, filter, table, tr, td, td2, i, txtValue, txtValue2;
	input = document.getElementById("search");
	filter = input.value.toUpperCase();
	table = document.getElementById("table");
	tr = table.getElementsByTagName("tr");
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td")[0];
		td2 = tr[i].getElementsByTagName("td")[1];
		if (td) {
			txtValue = td.innerText;
			txtValue2 = td2.innerText;
			if (
				txtValue.toUpperCase().indexOf(filter) > -1 ||
				txtValue2.toUpperCase().indexOf(filter) > -1
			) {
				tr[i].style.display = "";
			} else {
				tr[i].style.display = "none";
			}
		}
	}
}