// Copyright (C) 2017  Nicholas Anderssohn

import '../lib/app/app.dart';
import '../lib/compatibility/compatibility.dart';

App app = new App();
CompatibilityChecker compatibilityChecker = new CompatibilityChecker();
void main() {
  if (compatibilityChecker.checkCompatibility()) {
    app.run();
  }
}
