// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'textbox.dart';

class PasswordBox extends TextBox {
  String savedText = "";
  final String typeText = "text";
  final String typePassword = "password";
  PasswordBox(InputElement inputTarget, {String defaultText = ""}) : super(inputTarget, defaultText: defaultText) {
    cancelBlurSub(blurSubscription); // cancel the parents blur handler which simply changes the text back to the default text
    cancelFocusSub(focusSubscription);
    onKeyDown(_changeToPasswordType);
    onFocus(_clearIfTextIsDefault);
    onFocus(_changeToPasswordType);
    
    blurSubscription = onBlur(_changeToTypeTextIfEmpty);
  }

  _changeToPasswordType(var event) {
    if (inputTarget.type != typePassword) {
      inputTarget.type = typePassword;
    }
  }

  _changeToTypeTextIfEmpty(var event) {
    if (inputTarget.value.trim() == "") {
      inputTarget.type = typeText;
      inputTarget.value = defaultText;
    }
  }

  _clearIfTextIsDefault(var e) {
      if (inputTarget.value == defaultText && inputTarget.type != typePassword) {
        inputTarget.value = "";
      }
    }
}