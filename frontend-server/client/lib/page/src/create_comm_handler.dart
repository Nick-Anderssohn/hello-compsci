// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'package:cookie/cookie.dart' as cookie;
import '../../button/button.dart';
import '../../textbox/textbox.dart';
import '../../connector/connector.dart';

class CreateCommHandler {
  TextBox _classBox;
  PasswordBox _passwordBox;
  StandardBtn _createClassBtn;
  String _curEndpoint;
  Connector _connector = new Connector();
  final String sessionGUIDKey = 'SessionGUID';
  final String successKey = 'CreateSuccess';


  CreateCommHandler(this._createClassBtn, this._classBox, this._passwordBox, this._curEndpoint) {
    _createClassBtn.onClick(_createClass);
  }

  _createClass(StandardBtn createBTN) {
    _connector.sendCreateClassReq(_classBox.value, '', _passwordBox.value, _curEndpoint).then((HttpRequest response) {
      String createSuccess = response.responseHeaders[successKey];

      if (createSuccess == 'true') {
        _setCookie(response.responseHeaders[sessionGUIDKey]);
        print('great success');
        // TODO: load educator home
      } else {

      }
    }).catchError((var e) => window.alert('There was an error while creating the class.'));
  }

  _setCookie(String responseSessionGUID) {
    String existingSessionGUID = cookie.get(sessionGUIDKey);

    if (existingSessionGUID != null)
      cookie.remove(sessionGUIDKey, path: '/');
    
    cookie.set(sessionGUIDKey, responseSessionGUID, domain: 'hellocompsci.com', path: '/');
  }
}