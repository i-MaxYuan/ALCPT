function checkTime() {
	var now = new Date();
	var h = now.getHours(); //小時
	var m = now.getMinutes(); //分鐘
	if (({
			{
				hour
			}
		} - h == 0) && ({
			{
				minute
			}
		} - m <= 0)) {
		alert("Time's up");
		document.location.href = "{{ url('testee_settle_exam', args=[exam.id]) }}";
	}
	setTimeout(checkTime, 1000); //每間隔1秒就呼叫自已一次
}
checkTime();