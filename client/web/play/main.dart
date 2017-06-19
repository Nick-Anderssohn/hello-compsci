// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import "../../lib/strconv/strconv.dart";
import "../../lib/page/page.dart";
import "../../lib/code_editor.dart";
import "../../lib/connector.dart";

final String curEndpoint = '/play';
List topBarOptions = []; // does not include homeBtn
CodeEditor codeEditor;
Connector connector = new Connector();
void main() {
  topBarOptions = [
    new StandardBtn(querySelector('#home-option'), tag: '/'),
    new StandardBtn(querySelector('#about-option'), tag: '/about')
  ];
  topBarOptions.forEach((StandardBtn btn) => btn.onClick(_handleTopBarOnClick));

  codeEditor = new CodeEditor('#code-editor');
  codeEditor..onSendClicked(_handleSendClicked)
  ..code = """#include "stdio.h"

int main() {
  printf("Hello, Notes!\\n");
  return 0;
}""";

  querySelector('#code-editor-container').children.add(codeEditor.target);
}

_handleTopBarOnClick(StandardBtn btn) {
  window.location.assign(_getNEWURL(btn.tag));
}

_getNEWURL(String newEndpoint) {
  return StrConv.getNewURL(window.location.href, curEndpoint, newEndpoint);
}

_handleSendClicked(var e) {
  var filename = e[0];
  var code = e[1];
  connector.sendCode(filename, code).then((var e) => codeEditor.output.text = e.responseText);
}
