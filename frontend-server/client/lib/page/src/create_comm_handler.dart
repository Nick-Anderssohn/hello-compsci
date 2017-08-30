// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'dart:typed_data';
import 'package:cookie/cookie.dart' as cookie;
import '../../button/button.dart';
import '../../textbox/textbox.dart';
import '../../connector/connector.dart';
import '../../pb/database.pb.dart';

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
      print("handling response");
      var sessionResp;
      try {
        List<int> bytes = new Uint8List.view(req.response);
        // print("bytes: $bytes");
        sessionResp = new SessionResp.fromBuffer(bytes);
      } catch (e) {
        print(e);
      }
      if (sessionResp.success) {
        print('guid: ${sessionResp.sessionGUID}');
        _setCookie(sessionResp.sessionGUID);
        print('great success');
        // TODO: load educator home
      } else {
        window.alert(sessionResp.message);
      }
      
    }).catchError((var e) => window.alert('There was an error while creating the class.'));
  }

  _setCookie(String responseSessionGUID) {
    String existingSessionGUID = cookie.get(sessionGUIDKey);
    print('Existing key: $existingSessionGUID');

    if (existingSessionGUID != null)
      cookie.remove(sessionGUIDKey, path: '/', secure: true);
    
    // NOTE: If we specify domain, we must add that to remove func as well
    // cookie.set(sessionGUIDKey, responseSessionGUID, domain: 'hellocompsci.com', path: '/');
    cookie.set(sessionGUIDKey, responseSessionGUID, path: '/', secure: true);
  }
}