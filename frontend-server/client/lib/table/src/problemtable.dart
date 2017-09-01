// Copyright (C) 2017  Nicholas Anderssohn

import 'problemrow.dart';
import 'package:simple_streams/simple_streams.dart';
import 'dart:html';

class ProblemTable {
  TableElement target;

  int get selectedID => _selectedID;
  int _selectedID = -1;
  List<ProblemRow> _rows = [];
  SimpleStream _rowSelectedStreamer = new SimpleStream();

  ProblemTable(this.target);

  populate(List<String> problemNames, List<int> ids) {
    if (problemNames.length == ids.length) {
      for (int i = 0; i < ids.length; i++) {
        addRow(problemNames[i], ids[i]);
      }
    }
  }

  addRow(String problemName, int id) {
    var row = new ProblemRow(problemName, id);

    row.onClick((e) {
      _selectedID = row.problemID;
      _rowSelectedStreamer.add(_selectedID);
    });

    _rows.add(row);
    target.children.add(row.target);
  }

  onNewRowSelectedStreamer(Function handler) => _rowSelectedStreamer.listen(handler);
}