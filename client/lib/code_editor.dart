library CodeEditor;
import 'dart:html';
import 'package:codemirror/codemirror.dart';
import 'dropdown/dropdown.dart';
import 'page/page.dart';

class CodeEditor {
  CodeMirror _editor;
  DivElement target = new DivElement();
  TextAreaElement textArea;
  DivElement runBtn = new DivElement();
  DivElement output = new DivElement();
  DropDown dropDown;
  DivElement dropBtn = new DivElement();
  StandardBtn cOption = new StandardBtn(new DivElement(), tag: 'main.c');
  StandardBtn cppOption = new StandardBtn(new DivElement(), tag: 'main.cpp');
  StandardBtn python3Option = new StandardBtn(new DivElement(), tag: 'main.py');
  StandardBtn goOption = new StandardBtn(new DivElement(), tag: 'main.go');
  StandardBtn javaOption = new StandardBtn(new DivElement(), tag: 'main.java');
  bool waitingForOutput = false;
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
    'extraKeys': {
      'Ctrl-Space': 'autocomplete',
      'Cmd-/': 'toggleComment',
      'Ctrl-/': 'toggleComment' }
    };
  CodeEditor(String elementId, {options: null}) {

    textArea = querySelector(elementId);
    runBtn..classes.add('send-code-btn')..text = "Run"..contentEditable = "false";
    textArea.classes.add('code-editor-text-area');
    target.children..add(runBtn)..add(output);
    if (options != null) this.options = options;

    _editor = new CodeMirror.fromTextArea(
          textArea, options: this.options);
    output..text = "output"..classes.add('output');

    runBtn.onClick.listen((var e) {
      waitingForOutput = true;
      // globals.sendCodeStream.add([language, code]);
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
    cOption.text = "C";
    cppOption.text = "C++";
    python3Option.text = "Python 3";
    goOption.text = "Go";
    javaOption.text = 'Java';

    cOption.onClick((var e) {
      language = 'C';
    });
    cppOption.onClick((var e) {
      language = 'C++';
    });
    python3Option.onClick((var e) {
      language = 'Python 3';
    });
    goOption.onClick((var e) {
      language = 'Go';
    });
    javaOption.onClick((var e) {
      language = 'Java';
    });
    dropDown..addItem(cOption.target)..addItem(cppOption.target)/*..addItem(python2Option)*/..addItem(python3Option.target)
    ..addItem(goOption.target)..addItem(javaOption.target);
  }
}
