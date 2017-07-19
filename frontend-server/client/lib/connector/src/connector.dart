// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import '../../strconv/strconv.dart';

class Connector {
  // sends the code and returns a future that will eventually evaluate to the server's response if there is one
  sendCode(String filename, String code, String curEndpoint) {
    var runnerURL = StrConv.getNewURL(window.location.href, curEndpoint, "/runcode");
    return HttpRequest.request(runnerURL, method: 'POST',
     requestHeaders: {"Filename": filename}, sendData: code);
   }
}
