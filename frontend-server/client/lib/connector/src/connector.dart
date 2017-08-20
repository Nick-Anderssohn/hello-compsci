// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import '../../strconv/strconv.dart';

class Connector {
  /// Sends the [filename] and [code].
  /// Returns a future that will eventually evaluate to the server's response if there is one
  sendCode(String filename, String code, String curEndpoint) {
    var runnerURL = StrConv.getNewURL(window.location.href, curEndpoint, "/runcode");
    return HttpRequest.request(runnerURL, method: 'POST', requestHeaders: {
      "Filename": filename}, sendData: code);
  }

  /// Sends [className], [email], and [password] as an attempt to create a new class.
  /// Returns a future that will evaluate to the server's response which will contain
  /// Whether or not it successfully created the class and a session guid. The session
  /// guid will be the same as the current one if it already exists.
  sendCreateClassReq(String className, String email, String password, String curEndpoint) {
    var createClassURL = StrConv.getNewURL(window.location.href, curEndpoint, "/createclass");
    return HttpRequest.request(createClassURL, method: 'POST', requestHeaders: {
      "ClassName": className,
      "Email": email,
      "Password": password
    });
  }
}
