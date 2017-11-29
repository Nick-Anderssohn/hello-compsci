// Copyright (C) 2017  Nicholas Anderssohn

import '../lib/app/app.dart';
import '../lib/compatibility/compatibility.dart';
import 'dart:html';

import 'package:hello_class_homepage/strconv/strconv.dart';

App app = new App();
CompatibilityChecker compatibilityChecker = new CompatibilityChecker();
void main() {
  if (compatibilityChecker.checkCompatibility()) {
//    app.run();
    window.location.assign(StrConv.getNewURL(window.location.href, '/', '/play'));
  }
}
