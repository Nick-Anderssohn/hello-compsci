// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';

final String curEndpoint = '/';
void main() {
  querySelector('#about-option').onClick.listen(_handleAboutOnClick);
}

_handleAboutOnClick(var e) {
  window.location.assign(_getNEWURL('/about'));
}

_getNEWURL(String newEndpoint) {
  String newURL = window.location.href;
  var index = newURL.lastIndexOf(curEndpoint);
  newURL = newURL.substring(0, index);
  return newURL + newEndpoint;
}
