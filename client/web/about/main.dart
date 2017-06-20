// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import "../../lib/strconv/strconv.dart";
import "../../lib/page/page.dart";

final String curEndpoint = '/about';
List topBarOptions = []; // does not include homeBtn
void main() {
  topBarOptions = [
    new StandardBtn(querySelector('#home-option'), tags: ['/']),
    new StandardBtn(querySelector('#play-option'), tags: ['/play'])
  ];
  topBarOptions.forEach((StandardBtn btn) => btn.onClick(_handleTopBarOnClick));
}

_handleTopBarOnClick(StandardBtn btn) {
  window.location.assign(_getNEWURL(btn.tags[0]));
}

_getNEWURL(String newEndpoint) {
  return StrConv.getNewURL(window.location.href, curEndpoint, newEndpoint);
}
