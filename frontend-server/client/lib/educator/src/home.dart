// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import '../../table/table.dart';
import '../../connector/connector.dart';
import '../../pb/database.pb.dart';
import 'dart:typed_data';
import '../../constants.dart';

class EducatorHome {
  final String _curEndpoint = '/educator/home/';
  Connector connector = new Connector();
  ProblemTable problemTable;

  load() {
    problemTable = new ProblemTable(querySelector('#problem-table'));
    // get query params
    String className = Uri.base.queryParameters[Constants.classNameQueryParam];
    // ask server for class information
    connector.sendGetEdHomeReq(className, _curEndpoint).then((HttpRequest req) {
      List<int> bytes = new Uint8List.view(req.response);
      var edHomeData = new EducatorHomeData.fromBuffer(bytes);
      if (edHomeData.success) {
        querySelector('#title').text = 'Hello, ${edHomeData.className}!';
        // populate problems table
        problemTable.populate(edHomeData.problemTitles, edHomeData.problemIDs.map((value) => value.toInt()));
        // TODO: display currently posted problem if there is one
      } else {
        window.alert(edHomeData.message);
      }
    }).catchError((e) => window.alert("There was an error while fetching class data."));

  }
}
