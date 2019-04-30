"use strict";

$(function() {
  $("input[type=file]").on('change', function() {
    var fieldVal = $(this).val();
    if (fieldVal != undefined || fieldVal != "") {
      $(this).next('.custom-file-control').addClass("selected").html(fieldVal);
    }
  });
});

function md5_password(form) {
    if (form['password'].value !== '') {
        form['password'].value = md5(form['password'].value);
        if (form['password-confirm'].value !== '') {
            form['password-confirm'].value = md5(form['password-confirm'].value);
        }
        return true;
    }
    return false;
}
