// Copyright (C) 2017  Nicholas Anderssohn

import '../../connector/connector.dart';
import '../../table/table.dart';
import '../../button/button.dart';
import '../../settings/problem_settings.dart';
import '../../constants.dart';
import '../../pb/database.pb.dart';
import '../../strconv/strconv.dart';
import 'package:cookie/cookie.dart' as cookie;
import 'dart:html';
import 'package:fixnum/fixnum.dart';
import 'dart:typed_data';

class EditProblem {
  bool get newProblem => _newProblem;

  final String _curEndpoint = '/educator/edit_problem/';
  Connector _connector = new Connector();
  ProblemSettings _settings = new ProblemSettings();
  Table _argumentTable;
  Table _submissionTable;
  DivElement _titleElement;
  DivElement _problemTitleElement;
  DivElement _promptElement;
  StandardBtn _addArgBtn;
  StandardBtn _deleteArgBtn;
  DivElement _expectedOutputElement;
  bool _newProblem = true;
  ClickWrapper _saveOption;
  String _className;
  Int64 _problemID;

  load() {
    _queryElements();
    _setupHandlers();

    String isNewProblem = Uri.base.queryParameters[Constants.newProblemQueryParam];
    _className = Uri.base.queryParameters[Constants.classNameQueryParam];
    _titleElement.text = 'Hello, ${_className}!';

    if (isNewProblem == Constants.stringFalse) {
      _problemID = new Int64(int.parse(Uri.base.queryParameters[Constants.problemIDQueryParam]));
      _newProblem = false;
      _populateFromDatabase();
    } else {
      _problemID = new Int64(0);
    }
  }

  _queryElements() {
    _argumentTable = new Table(querySelector('#argument-table'));
    _submissionTable = new Table(querySelector('#submission-table'));
    _titleElement = querySelector('#title');
    _problemTitleElement = querySelector('#problem-title');
    _promptElement = querySelector('#problem-text');
    _addArgBtn = new StandardBtn(querySelector('#add-argument-btn'));
    _deleteArgBtn = new StandardBtn(querySelector('#delete-argument-btn'));
    _expectedOutputElement = querySelector('#output-text');
    _settings.querySettingElements();
    _saveOption = new ClickWrapper(querySelector('#save-option'));
  }

  _setupHandlers() {
    _saveOption.onClick(_saveProblemToDatabase);
  }

  _saveProblemToDatabase(e) {
    // Handle saving problem to database
    if (_newProblem) {
      _connector.addProblemReq(_className, _problemTitleElement.text,
        _promptElement.text, _settings.getListOfSettings(),
        _expectedOutputElement.text, _curEndpoint).then((HttpRequest req){
        List<int> bytes = new Uint8List.view(req.response);
        var sessionResp = new SessionResp.fromBuffer(bytes);
        if (sessionResp.success) {
          _setCookie(sessionResp.sessionGUID);
          var edHomeURL = Uri.encodeFull(StrConv.getNewURL(window.location.href, _curEndpoint, '/educator/home/') + '?${Constants.classNameQueryParam}=${_className}');
          window.location.assign(edHomeURL);
        } else {
          window.alert(sessionResp.message);
        }
      }).catchError((e) => window.alert('There was a problem communicating with the server'));
    } else {
      // TODO: handle saving an existing problem
    }
  }

  _populateFromDatabase() {
    // TODO: load problem from database. Use query param for problem id
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