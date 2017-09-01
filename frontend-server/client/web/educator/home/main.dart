// Copyright (C) 2017  Nicholas Anderssohn
import "../../../lib/compatibility/compatibility.dart";
import "../../../lib/topbar/topbar.dart";
import "../../../lib/educator/educator.dart";

final String curEndpoint = '/educator/home';
CompatibilityChecker compatibilityChecker = new CompatibilityChecker();
TopBar topBar;
EducatorHome home = new EducatorHome();
void main() {
  if (compatibilityChecker.checkCompatibility()) {
    _run();
  }
}

_run() {
    topBar = new TopBar(curEndpoint);
    home.load();
}