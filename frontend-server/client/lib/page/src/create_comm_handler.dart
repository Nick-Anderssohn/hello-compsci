// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'dart:typed_data';
import 'package:cookie/cookie.dart' as cookie;
import '../../button/button.dart';
import '../../textbox/textbox.dart';
import '../../connector/connector.dart';
import '../../pb/database.pb.dart';
import '../../strconv/strconv.dart';

class CreateCommHandler {
  TextBox _classBox;
  PasswordBox _passwordBox;
  StandardBtn _createClassBtn;
  String _curEndpoint;
  Connector _connector = new Connector();
  final String sessionGUIDKey = 'SessionGUID';

  CreateCommHandler(this._createClassBtn, this._classBox, this._passwordBox, this._curEndpoint) {
    _createClassBtn.onClick(_createClass);
  }

  _createClass(StandardBtn createBTN) {
    _connector.sendCreateClassReq(_classBox.value, '', _passwordBox.value, _curEndpoint).then((HttpRequest req) {
      List<int> bytes = new Uint8List.view(req.response);
      var sessionResp = new SessionResp.fromBuffer(bytes);
      if (sessionResp.success) {
        _setCookie(sessionResp.sessionGUID);
        var edHomeURL = Uri.encodeFull(StrConv.getNewURL(window.location.href, _curEndpoint, '/educator/home/') + '?classname=${_classBox.value}');
        print("edHomeURL: $edHomeURL");
        window.location.assign(edHomeURL);
      } else {
        window.alert(sessionResp.message);
      }
      
    }).catchError((var e) => window.alert('There was an error while creating the class.'));
  }

  _setCookie(String responseSessionGUID) {
    String existingSessionGUID = cookie.get(sessionGUIDKey);

    if (existingSessionGUID != null)
      cookie.remove(sessionGUIDKey, path: '/', secure: true);
    
    // NOTE: If we specify domain, we must add that to remove func as well
    // cookie.set(sessionGUIDKey, responseSessionGUID, domain: 'hellocompsci.com', path: '/');
    cookie.set(sessionGUIDKey, responseSessionGUID, path: '/', secure: true);
  }
}