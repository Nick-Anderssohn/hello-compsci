// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import "../../lib/code_editor/code_editor.dart";
import "../../lib/connector/connector.dart";
import "../../lib/topbar/topbar.dart";
import "../../lib/compatibility/compatibility.dart";

final String curEndpoint = '/play';
CodeEditor codeEditor;
Connector connector = new Connector();
CompatibilityChecker compatibilityChecker = new CompatibilityChecker();
TopBar topBar;
void main() {
  if (compatibilityChecker.checkCompatibility()) {
    _run();
  }
}

_run() {
  topBar = new TopBar(curEndpoint);

  codeEditor = new CodeEditor('#code-editor');
  codeEditor..onSendClicked(_handleSendClicked);

  querySelector('#code-editor-container').children.add(codeEditor.target);
}

_handleSendClicked(var e) {
  var filename = e[0];
  var code = e[1];
  codeEditor.output.text = "Running...please wait";
  connector.sendCode(filename, code, curEndpoint).then((var e) {
    codeEditor.output.innerHtml = e.responseText.replaceAll(new RegExp("\n"), "\n<br>");
    codeEditor.runBtnEnabled = true;
  }).catchError((var e) => codeEditor.runBtnEnabled = true);
}
