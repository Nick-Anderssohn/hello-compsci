// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'package:cookie/cookie.dart' as cookie;
import '../../strconv/strconv.dart';
import '../../pb/database.pb.dart';
import '../../constants.dart';

class Connector {
  /// Sends the [filename] and [code].
  /// Returns a future that will eventually evaluate to the server's response if there is one
  sendCode(String filename, String code, String curEndpoint) {
    var runnerURL = StrConv.getNewURL(window.location.href, curEndpoint, Constants.runCodeEndpoint);
    return HttpRequest.request(runnerURL, method: Constants.post, requestHeaders: {
      Constants.fileNameKey: filename}, sendData: code);
  }

  /// Sends [className], [email], and [password] as an attempt to create a new class.
  /// Returns a future that will evaluate to the server's response which will contain
  /// Whether or not it successfully created the class and a session guid. The session
  /// guid will be the same as the current one if it already exists.
  sendCreateClassReq(String className, String email, String password, String curEndpoint) {
    var databaseURL = StrConv.getNewURL(window.location.href, curEndpoint, Constants.databaseEndpoint);
    String existingSessionGUID = cookie.get(Constants.sessionGUIDKey);

    var newClassReq = new NewClassReq();
    newClassReq
      ..className = className
      ..email = email
      ..password = password
      ..sessionGUID = existingSessionGUID != null ? existingSessionGUID : "";

    return HttpRequest.request(databaseURL, method: Constants.post, requestHeaders: {
      Constants.commandKey: Constants.createClassCommand
    }, sendData: newClassReq.writeToBuffer(), responseType: Constants.responseTypeArrayBuffer);
  }

  /// Sends [className] and the current session guid
  /// Returns a future that will evaluate to the server's response which will contain
  /// Whether or not this session had permission to get the class data and the data if it does have permission
  sendGetEdHomeReq(String className, String curEndpoint) {
    var databaseURL = StrConv.getNewURL(window.location.href, curEndpoint, Constants.databaseEndpoint);
    String existingSessionGUID = cookie.get(Constants.sessionGUIDKey);
    print("sendGetEd...session guid: $existingSessionGUID");
    var edHomeDataReq = new EducatorHomeDataRequest();
    edHomeDataReq
      ..className = className
      ..sessionGUID = existingSessionGUID;

    return HttpRequest.request(databaseURL, method: Constants.post, requestHeaders: {
      Constants.commandKey: Constants.getEdHomeInfoCommand
    }, sendData: edHomeDataReq.writeToBuffer(), responseType: Constants.responseTypeArrayBuffer);
  }

  /// Sends [className], [password], and the current session guid
  /// Returns a future that contains the server's response which will tell
  /// if the login req was successful. It will also provide a message if it fails.
  sendLoginReq(String className, String password, String curEndpoint) {
    var databaseURL = StrConv.getNewURL(window.location.href, curEndpoint, Constants.databaseEndpoint);
    String existingSessionGUID = cookie.get(Constants.sessionGUIDKey);

    var loginReq = new LoginRequest();
    loginReq
      ..className = className
      ..sessionGUID = existingSessionGUID != null ? existingSessionGUID : ""
      ..password = password;

    return HttpRequest.request(databaseURL, method: Constants.post, requestHeaders: {
      Constants.commandKey: Constants.loginCommand
    }, sendData: loginReq.writeToBuffer(), responseType: Constants.responseTypeArrayBuffer);
  }
}
