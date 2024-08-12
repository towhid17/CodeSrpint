var editor = ace.edit('editor');
var txtAra = document.querySelector('textarea[name="code"]');
var jsbOpts = {
  indent_size : 4
};

editor.setTheme("ace/theme/monokai");
editor.getSession().setMode("ace/mode/java");
syncEditor();

setTimeout(formatCode, 1000);

editor.getSession().on('change', function() {
  commitChanges();
});

function syncEditor() {
  editor.getSession().setValue(txtAra.value);
}

function commitChanges() {
  txtAra.value = editor.getSession().getValue();
}

function formatCode() {
  var session = editor.getSession();
  session.setValue(js_beautify(session.getValue(), jsbOpts));
}

function runCode() {
    var code = document.querySelector('textarea[name="code"]').value;
    var output = document.getElementById("codeOutput");
    var outputBtn = document.getElementById("outputBtn");
    document.getElementById("outputSpinner").style.display = "block";

    $.ajax({
        type: "POST",
        url: "/code/run",
        data: {code: code},
        success: function (data) {
            output.innerHTML = data;
            document.getElementById("outputSpinner").style.display = "none";
            outputBtn.click();
        },
        error: function (e) {
            output.innerHTML = e.responseText;
            document.getElementById("outputSpinner").style.display = "none";
            outputBtn.click();
        }
    });
}

function loadCodeInEditor(submissionId) {
    var code = document.querySelector('textarea[name="code"]');

    $.ajax({
        type: "GET",
        url: "/submission/" + submissionId + "/textScript",
        success: function (data) {
            code.value = data;
            syncEditor();
        }
    });
}

switchThemeOfEditor();