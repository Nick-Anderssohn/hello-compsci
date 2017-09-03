// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import '../../table/table.dart';
import '../../connector/connector.dart';
import '../../pb/database.pb.dart';
import 'dart:typed_data';
import '../../constants.dart';
import '../../button/button.dart';
import '../../strconv/strconv.dart';
import 'package:fixnum/fixnum.dart';

class EducatorHome {
  final String _curEndpoint = '/educator/home/';
  Connector connector = new Connector();
  Table problemTable;
  StandardBtn _newProblemButton;
  String _className;

  load() {
    _queryElements();
    _className = Uri.base.queryParameters[Constants.classNameQueryParam];
    // ask server for class information
    connector.sendGetEdHomeReq(_className, _curEndpoint).then((HttpRequest req) {
      List<int> bytes = new Uint8List.view(req.response);
      var edHomeData = new EducatorHomeData.fromBuffer(bytes);
      if (edHomeData.success) {
        querySelector('#title').text = 'Hello, ${edHomeData.className}!';
        // populate problems table
        problemTable.populate(edHomeData.problemTitles, edHomeData.problemIDs.map((Int64 value) => value.toInt()).toList());
        // TODO: display currently posted problem if there is one
      } else {
        window.alert(edHomeData.message);
      }
    }).catchError((e) => window.alert("There was an error while fetching class data."));

    _setupHandlers();
  }

  _queryElements() {
    problemTable = new Table(querySelector('#problem-table'));
    _newProblemButton = new StandardBtn(querySelector('#new-problem-btn'));
  }

  _setupHandlers() {
    _newProblemButton.onClick((e) {
      var editProblemURL = Uri.encodeFull(StrConv.getNewURL(window.location.href, _curEndpoint, '/educator/edit_problem/') +
          '?${Constants.classNameQueryParam}=${_className}&${Constants.newProblemQueryParam}=${Constants.stringTrue}');
      window.location.assign(editProblemURL);
    });
  }
}
