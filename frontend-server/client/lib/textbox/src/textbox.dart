// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'dart:async';
import '../../button/button.dart';

class TextBox extends ClickWrapper {
    InputElement inputTarget;
    String defaultText;
    StreamSubscription blurSubscription;
    StreamSubscription focusSubscription;

    String get value => inputTarget.value;

    TextBox(this.inputTarget, {this.defaultText = ""}) : super(inputTarget) {
      inputTarget.value = defaultText;
      focusSubscription = onFocus(_clearIfTextIsDefault);
      blurSubscription = onBlur(_restoreDefaultTextIfBoxIsEmpty);
    }

    _clearIfTextIsDefault(var e) {
      if (inputTarget.value == defaultText) {
        inputTarget.value = "";
      }
    }

    _restoreDefaultTextIfBoxIsEmpty(var e) {
      if (inputTarget.value.trim() == "") {
        inputTarget.value = defaultText;
      }
    }
}
