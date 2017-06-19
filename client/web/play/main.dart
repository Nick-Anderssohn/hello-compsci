// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import "../../lib/strconv/strconv.dart";
import "../../lib/page/page.dart";
import "../../lib/code_editor.dart";

final String curEndpoint = '/play';
List topBarOptions = []; // does not include homeBtn
CodeEditor codeEditor;
void main() {
  topBarOptions = [
    new StandardBtn(querySelector('#home-option'), tag: '/'),
    new StandardBtn(querySelector('#about-option'), tag: '/about')
  ];
  topBarOptions.forEach((StandardBtn btn) => btn.onClick(_handleTopBarOnClick));

  codeEditor = new CodeEditor('#code-editor');
  codeEditor.code = """#include "stdio.h"

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
