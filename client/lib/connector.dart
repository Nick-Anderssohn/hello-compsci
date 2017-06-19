// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';

class Connector {
  String codeRunnerPort = "8079";

  Connector({this.codeRunnerPort: "8079"});

  // sends the code and returns a future that will eventually evaluate to the server's response if there is one
  sendCode(String filename, String code) => HttpRequest.request("http://localhost:"+codeRunnerPort, method: 'POST',
     requestHeaders: {"Filename": filename}, sendData: code);
}
