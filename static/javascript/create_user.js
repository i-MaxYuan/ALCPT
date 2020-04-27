var passRegId = false;
var passIdentity = false;
var passPrivilege = true;
var passStuID = false;

function unique_ID(reg_ids , input) {
    var arr = reg_ids;
    var invalid_id = document.getElementById('invalid_id');

    for(var i = 0; i < arr.length; i++) {
        if (input.value === arr[i]) {
            invalid_id.innerHTML = "此ID已存在";
            passRegId = false;
            break;
        }
        else if (input.value === ""){
            invalid_id.innerHTML = "此為必填，請勿留白";
            passRegId = false;
        }
        else {
            invalid_id.innerHTML = "";
            passRegId = true;
        }
    }
    data_valid();
}

function unique_stuID(stu_ids , input) {
    var arr = stu_ids;
    var invalid_stu_id = document.getElementById('invalid_stu_id');

    for(var i = 0; i < arr.length; i++) {
        if (input.value === arr[i]) {
            invalid_stu_id.innerHTML = "此ID已存在";
            passStuID = false;
            break;
        } else if (input.value === ""){
            invalid_stu_id.innerHTML = "此為必填，請勿留白";
            passStuID = false;
        } else {
            invalid_stu_id.innerHTML = "";
            passStuID = true;
        }
    }
    data_valid();
}

// Checkout whether privilege is empty.
function privilege_not_empty() {
    var privilegeInvalid = document.getElementById('privilege_invalid');
    var system = document.getElementById('32');
    var testM = document.getElementById('16');
    var tbM = document.getElementById('8');
    var tbO = document.getElementById('4');
    var viewer = document.getElementById('2');
    var testee = document.getElementById('1');

    if (system.checked === false && testM.checked === false && tbM.checked === false &&
        tbO.checked === false && viewer.checked === false && testee.checked === false) {
        privilegeInvalid.innerHTML = '最少選一個權限';
        passPrivilege = false;
    } else {
        privilegeInvalid.innerHTML = '';
        passPrivilege = true;
    }
    data_valid();
}

function is_student() {
    var stuID = document.getElementById('stu_id');
    var department = document.getElementById('department');
    var squadron = document.getElementById('squadron');
    var grade = document.getElementById('grade');
    var identity = document.getElementById('identity');

    if (identity.value === '2') {
        stuID.disabled = false;
        department.disabled = false;
        squadron.disabled = false;
        grade.disabled = false;

        passIdentity = true;
    }
    else {
        if (identity.value === ''){
            passIdentity = false;
        } else{
            passIdentity = true;}

        stuID.value = '';
        department.value = '';
        squadron.value = '';
        grade.value = '';

        stuID.disabled = true;
        department.disabled = true;
        squadron.disabled = true;
        grade.disabled = true;
    }
    data_valid();
}

function data_valid() {
    var identity = document.getElementById('identity');
    var submit = document.getElementById('submit');

    if(identity.value === '2'){
        if (passRegId===true && passIdentity===true && passPrivilege===true && passStuID===true){
            submit.disabled = false;
            submit.style.backgroundColor = "#4CCABD";
        } else {
            submit.disabled = true;
            submit.style.backgroundColor = "grey";
        }
    }
    else if(identity.value === '1' || identity.value === '3'){
        if (passRegId===true && passIdentity===true && passPrivilege===true){
            submit.disabled = false;
            submit.style.backgroundColor = "#4CCABD";
        } else{
            submit.disabled = true;
            submit.style.backgroundColor = "grey";
        }
    }
    else{
        submit.disabled = true;
        submit.style.backgroundColor = "grey";
    }
}