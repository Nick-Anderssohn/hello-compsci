// Copyright (C) 2017  Nicholas Anderssohn
import "../../../lib/compatibility/compatibility.dart";
import "../../../lib/topbar/topbar.dart";
import "../../../lib/educator/educator.dart";

final String curEndpoint = '/educator/edit_problem/';
CompatibilityChecker compatibilityChecker = new CompatibilityChecker();
TopBar topBar;
EditProblem problemEditor = new EditProblem();
void main() {
  if (compatibilityChecker.checkCompatibility()) {
    _run();
  }
}

_run() {
  topBar = new TopBar(curEndpoint);
  problemEditor.load();
}