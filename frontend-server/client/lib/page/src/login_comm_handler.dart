// Copyright (C) 2017  Nicholas Anderssohn

import '../../textbox/textbox.dart';
import '../../button/button.dart';
import '../../connector/connector.dart';
import '../../pb/database.pb.dart';
import '../../constants.dart';
import '../../strconv/strconv.dart';
import 'dart:html';
import 'dart:typed_data';
import 'package:cookie/cookie.dart' as cookie;

class LoginCommHandler {
  TextBox _classBox;
  PasswordBox _passwordBox;
  StandardBtn _educatorLoginBtn;
  StandardBtn _studentLoginBtn;
  String _curEndpoint;
  Connector _connector = new Connector();

  LoginCommHandler(this._classBox, this._passwordBox, this._educatorLoginBtn, this._studentLoginBtn, this._curEndpoint) {
    _educatorLoginBtn.onClick(_loginAsEducator);
  }

  _loginAsEducator(e) {
    _connector.sendLoginReq(_classBox.value, _passwordBox.value, _curEndpoint).then((HttpRequest req) {
      List<int> bytes = new Uint8List.view(req.response);
      var loginResp = new LoginResponse.fromBuffer(bytes);
      if (loginResp.success) {
        print("login responded with guid: ${loginResp.sessionGUID}");
        _setCookie(loginResp.sessionGUID);
        var edHomeURL = Uri.encodeFull(StrConv.getNewURL(window.location.href, _curEndpoint, '/educator/home/') + '?${Constants.classNameQueryParam}=${_classBox.value}');
        window.location.assign(edHomeURL);
      } else {
        window.alert(loginResp.message);
      }
    }).catchError((var e) => window.alert('There was an error while connecting to the server'));
  }

  _setCookie(String responseSessionGUID) {
    String existingSessionGUID = cookie.get(Constants.sessionGUIDKey);

    if (existingSessionGUID != null)
      cookie.remove(Constants.sessionGUIDKey, path: '/', secure: true);

    // NOTE: If we specify domain, we must add that to remove func as well
    // cookie.set(sessionGUIDKey, responseSessionGUID, domain: 'hellocompsci.com', path: '/');
    cookie.set(Constants.sessionGUIDKey, responseSessionGUID, path: '/', secure: true);
  }
}