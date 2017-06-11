// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import "../../lib/strconv/strconv.dart";

final String curEndpoint = '/about';
void main() {
  querySelector('#home-option').onClick.listen(_handleHomeOnClick);
}

_handleHomeOnClick(var e) {
  window.location.assign(_getNEWURL('/'));
}

_getNEWURL(String newEndpoint) {
  return StrConv.getNewURL(window.location.href, curEndpoint, newEndpoint);
}
