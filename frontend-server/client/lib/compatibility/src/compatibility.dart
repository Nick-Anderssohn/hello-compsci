// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';

class CompatibilityChecker {
  CompatibilityChecker();

  bool checkCompatibility() {
    if (_isEdge()) {
      _handleCompatibilityFailure();
      return false;
    }
    return true;
  }

  bool _isEdge() {
    return window.navigator.userAgent.contains('Edge');
  }

  _handleCompatibilityFailure() {
    document.body.innerHtml = "Unfortunately, Microsoft Edge is the only browser that this website does not work with.<p>Please use literally any other browser....";
  }
}
