// // Copyright (C) 2017  Nicholas Anderssohn
//
// import 'dart:html';
// import 'package:hello_class/hello_class.dart';
//
// final String curEndpoint = '/';
// void main() {
//   querySelector('#about-option').onClick.listen(_handleAboutOnClick);
// }
//
// _handleAboutOnClick(var e) {
//   window.location.assign(_getNEWURL('/about'));
// }
//
// _getNEWURL(String newEndpoint) {
//   return StrConv.getNewURL(window.location.href, curEndpoint, newEndpoint);
// }


// Copyright (C) 2017  Nicholas Anderssohn

import '../lib/app/app.dart';

App app = new App();
void main() {
  app.run();
}
