// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'package:cookie/cookie.dart' as cookie;
import '../../strconv/strconv.dart';
import '../../pb/database.pb.dart';

class Connector {
  final String sessionGUIDKey = 'SessionGUID';
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
    var databaseURL = StrConv.getNewURL(window.location.href, curEndpoint, "/database");
    String existingSessionGUID = cookie.get(sessionGUIDKey);
    print("guid to send to server: $existingSessionGUID");

    var newClassReq = new NewClassReq();
    newClassReq
      ..className = className
      ..email = email
      ..password = password
      ..sessionGUID = existingSessionGUID != null ? existingSessionGUID : "";

    return HttpRequest.request(databaseURL, method: 'POST', requestHeaders: {
      "Command": "CreateClass"
    }, sendData: newClassReq.writeToBuffer(), responseType: 'arraybuffer');
  }

  sendGetEdHomeReq(String className, String curEndpoint) {
    var databaseURL = StrConv.getNewURL(window.location.href, curEndpoint, "/database");
    String existingSessionGUID = cookie.get(sessionGUIDKey);
    var edHomeDataReq = new EducatorHomeDataRequest();
    edHomeDataReq
      ..className = className
      ..sessionGUID = existingSessionGUID;

    return HttpRequest.request(databaseURL, method: 'POST', requestHeaders: {
      'Command': "GetEdHomeInfo"
    }, sendData: edHomeDataReq.writeToBuffer(), responseType: 'arraybuffer');
  }
}
