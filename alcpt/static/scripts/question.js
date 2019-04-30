
$("#audio-file").on("change", function(e) {
    $(this).next(".custom-file-label").html($(this).val());
    $("#preview-audio-source").attr("src", URL.createObjectURL(event.target.files[0]));
    document.getElementById("preview-audio").load();
});

$("#description").on("change keyup paste", function(e) {
    console.log($(this).val());
    $("#preview-description").html($(this).val());
});

$("#add-option").on("click", function(e) {
    e.preventDefault();

    let numChildren = $("#options").children().length;

    if (numChildren >= 10) {
        return;
    }

    let field_id = 0;

    for (let i = 0; i < 10; ++i) {
        if ($("#option-" + i).length === 0) {
            field_id = i;
            break;
        }
    }

    $("#options").append(
            "<div class=\"form-group\">" +
                "<div class=\"input-group\">" +
                    "<div class=\"input-group-prepend\">" +
                        "<div class=\"input-group-text\">" +
                            "<input type=\"radio\" name=\"answer\" value=\"" + field_id + "\" checked>" +
                        "</div>" +
                    "</div>" +
                    "<input id=\"option-" + field_id + "\" type=\"text\" class=\"form-control\" name=\"option-" + field_id + "\" placeholder=\"Input option here...\" onkeyup=\"update_option(" + field_id + ")\" required>" +
                    "<div class=\"input-group-append\">" +
                        "<span class=\"input-group-text remove\"><i class=\"fa fa-times\"></i></span>" +
                    "</div>" +
                "</div>" +
            "</div>");
    $("#answers").append(
            "<div class=\"form-check\">" +
                "<input class=\"form-check-input\" type=\"radio\" name=\"preview\" id=\"preview-option-" + field_id + "\" disabled>" +
                "<label class=\"form-check-label\" for=\"preview-option-" + field_id + "\">" +
            "</div>");
});

$(document).on("click", "input[type=radio][name=answer]", function() {
    let option_id = $(this).val();
    $("#preview-option-" + option_id).attr("checked", "true");
});

$(document).on("click", ".remove", function() {
    let numChildren = $("#options").children().length;

    if (numChildren <= 2) {
        return;
    }

    let option_id = $(this).parent().parent().find("input[type=text]").attr("id");
    let preview_option_id = "preview-" + option_id;
    $(this).parent().parent().parent().remove();
    $("#" + preview_option_id).parent().remove();
});

function update_option(field_id) {
    $("#preview-option-" + field_id).parent().find("label").html($("#option-" + field_id).val());
}
