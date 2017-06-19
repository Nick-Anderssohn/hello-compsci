// Copyright (C) 2017  Nicholas Anderssohn
import 'dart:html';
import 'package:simple_streams/simple_streams.dart';
import 'package:codemirror/codemirror.dart';
import 'dropdown/dropdown.dart';
import 'page/page.dart';

class CodeEditor {
  SimpleStream _sendStream = new SimpleStream();
  CodeMirror _editor;
  DivElement target = new DivElement();
  TextAreaElement textArea;
  DivElement runBtn = new DivElement();
  DivElement output = new DivElement();
  DropDown dropDown;
  DivElement dropBtn = new DivElement();
  StandardBtn selectedLang;
  List langBtns = [
    new StandardBtn(new DivElement(), tag: 'main.c', text: "C"),
    new StandardBtn(new DivElement(), tag: 'main.cpp', text: "C++"),
    new StandardBtn(new DivElement(), tag: 'main.py', text: "Python 3"),
    new StandardBtn(new DivElement(), tag: 'main.go', text: "Go"),
    new StandardBtn(new DivElement(), tag: 'Main.java', text: "Java")
  ];
  // bool waitingForOutput = false;
  String get language => dropBtn.text;
         set language(String value) {
           dropBtn.text = value;
           dropBtn.children.add(dropDown.target);
         }
  String get code => _editor.getDoc().getValue();
  set code(String value) {_editor.getDoc().setValue(value);}
  Map options = {
    'lineNumbers': true,
    'theme': 'neat',
    'continueComments': {'continueLineComment': false},
    'autoCloseTags': true,
    'mode': 'clike',
    'matchBrackets': true,
    'extraKeys': {
      'Ctrl-Space': 'autocomplete',
      'Cmd-/': 'toggleComment',
      'Ctrl-/': 'toggleComment' }
    };
  CodeEditor(String elementId, {options: null}) {
    selectedLang = langBtns[0];
    textArea = querySelector(elementId);
    runBtn..classes.add('send-code-btn')..text = "Run"..contentEditable = "false";
    textArea.classes.add('code-editor-text-area');
    target.children..add(runBtn)..add(output);
    if (options != null) this.options = options;

    _editor = new CodeMirror.fromTextArea(
          textArea, options: this.options);
    output..text = "output"..classes.add('output');

    runBtn.onClick.listen((var e) {
      // waitingForOutput = true;
      // globals.sendCodeStream.add([language, code]);
      _sendStream.add([selectedLang.tag, code]); // [filename, code]
    });


    target.children.add(dropBtn);
    dropBtn.classes.add('language-selector-btn');
    dropBtn.text = 'C';
    dropDown = new DropDown(dropBtn);
    _initializeDropDown();
    dropBtn.onClick.listen((var e) {
      dropDown.target.hidden = !dropDown.target.hidden;
    });
  }

  _initializeDropDown() {
    for (var btn in langBtns) {
      btn.onClick(_handleLangBtnClicked);
      dropDown.addItem(btn.target);
    }
  }

  onSendClicked(handler(var e)) {
    _sendStream.listen(handler);
  }

  _handleLangBtnClicked(var e) {
    language = e.text;
    selectedLang = e;
  }
}
