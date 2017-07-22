// Copyright (C) 2017  Nicholas Anderssohn

import "../../lib/topbar/topbar.dart";
import "../../lib/compatibility/compatibility.dart";

final String curEndpoint = '/about';
TopBar topBar;
CompatibilityChecker compatibilityChecker = new CompatibilityChecker();
void main() {
  if (compatibilityChecker.checkCompatibility()) {
    topBar = new TopBar(curEndpoint);
  }
}
