var validName = false;
var validTime = false;
var validDuration = true;
var validTestpaper = false;
var validGroup = false;

function time_valid()
var time = document.getElementById('start-time');
var time_invalid = document.getElementById('time_invalid');

validTime = true;
time_invalid.innerHTML = '';
data_valid();


function unique_name(names, input)
var invalid = document.getElementById("name_invalid");
var arr = names;

for (var i = 0; i < arr.length; i++)
	if (input.value === '')
		invalid.innerHTML = "<span style='color: red; font-size: 14px'>Required</span>";
validName = false;

else if (input.value === arr[i])
	invalid.innerHTML = "<span style='color: red; font-size: 14px'>Name has existed</span>";
validName = false;
break;

else
	invalid.innerHTML = '';
validName = true;


data_valid();


// Checkout whether duration not null and not negative.
function duration_valid(input)
var duration_invalid = document.getElementById("duration_invalid");
var reMatch = input.value.match(/[0-9]/g);


if (input.value === '')
	duration_invalid.innerHTML = "<span style='color: red; font-size: 14px'>Required</span>";
validDuration = false;

else if (parseInt(input.value) <= 0)
	duration_invalid.innerHTML = "<span style='color: red; font-size: 14px'>must be a positive integer</span>";
validDuration = false;

else if (reMatch.length !== (input.value).length)
	duration_invalid.innerHTML = "<span style='color: red; font-size: 14px'>reject other characters exclude positive integer</span>";
validDuration = false;

else
	duration_invalid.innerHTML = "";
validDuration = true;

data_valid();


Checkout whether testpaper and group are not null.
function is_selected(selectedData, kind)
var testpaper_invalid = document.getElementById("testpaper_invalid");
var group_invalid = document.getElementById("group_invalid");

if (selectedData.value === '')
	if (kind === 'Group')
		validGroup = false;
group_invalid.innerHTML = "<span style='color: red; font-size: 14px'>Required</span>";
else
	validTestpaper = false;
testpaper_invalid.innerHTML = "<span style='color: red; font-size: 14px'>Required</span>";


else
if (kind === 'group')
	validGroup = true;
group_invalid.innerHTML = '';
else
	validTestpaper = true;
testpaper_invalid.innerHTML = '';


data_valid();


Checkout whether all tag is valid and can send the form.
function data_valid()
if (validName === true && validTime === true && validDuration === true && validTestpaper === true && validGroup === true)
	submit.style.backgroundColor = '4CCABD';
submit.disabled = false;

else
	submit.style.backgroundColor = 'grey';
submit.disabled = true;

document.getElementById('time_invalid').innerHTML = validName + ',' + validTime + validDuration + validTestpaper + validGroup;