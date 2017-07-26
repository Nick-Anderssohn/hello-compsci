// Copyright (C) 2017  Nicholas Anderssohn
import "../../code_editor/code_editor.dart";
import "../../connector/connector.dart";
import "../../topbar/topbar.dart";
import "../../compatibility/compatibility.dart";
import '../../textbox/textbox.dart';
import '../../button/button.dart';
import 'dart:html';

class QuestionPage {
  final String curEndpoint = '/question';
  CodeEditor codeEditor;
  Connector connector = new Connector();
  CompatibilityChecker compatibilityChecker = new CompatibilityChecker();
  TopBar topBar;
  TextBox _nameBox;
  StandardBtn _submitBtn;
  QuestionPage();

  run() {
    if (compatibilityChecker.checkCompatibility()) {
      init();
    }
  }

  init() {
    topBar = new TopBar(curEndpoint);
    _nameBox = new TextBox(querySelector('#name-textbox'), defaultText: 'Name');
    _submitBtn = new StandardBtn(querySelector('#submit-btn'));

    _setupCodeEditor();
  }

  _setupCodeEditor() {
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
}
