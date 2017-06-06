// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';

final String curEndpoint = '/about';
void main() {
  querySelector('#home-option').onClick.listen(_handleHomeOnClick);
}

_handleHomeOnClick(var e) {
  window.location.assign(_getNEWURL('/'));
}

_getNEWURL(String newEndpoint) {
  String newURL = window.location.href;
  var index = newURL.lastIndexOf(curEndpoint);
  newURL = newURL.substring(0, index);
  return newURL + newEndpoint;
}
