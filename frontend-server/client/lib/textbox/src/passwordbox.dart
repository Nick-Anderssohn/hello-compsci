// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'textbox.dart';

class PasswordBox extends TextBox {
  String savedText = "";
  final String typeText = "text";
  final String typePassword = "password";
  PasswordBox(InputElement inputTarget, {String defaultText = ""}) : super(inputTarget, defaultText: defaultText) {
    onKeyDown(_changeToPasswordType);
    cancelBlurSub(blurSubscription); // cancel the parents blur handler which simply changes the text back to the default text
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
}