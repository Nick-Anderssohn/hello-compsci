// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import '../../button/button.dart';

class TextBox extends ClickWrapper {
    InputElement inputTarget;
    String defaultText;

    TextBox(this.inputTarget, {this.defaultText = ""}) : super(inputTarget) {
      inputTarget.value = defaultText;
      onClick(_clearIfTextIsDefault);
      onBlur(_restoreDefaultTextIfBoxIsEmpty);
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
