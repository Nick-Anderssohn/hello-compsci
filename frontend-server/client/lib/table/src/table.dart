// Copyright (C) 2017  Nicholas Anderssohn

import 'row.dart';
import 'package:simple_streams/simple_streams.dart';
import 'dart:html';

class Table {
  TableElement target;

  int get selectedID => _selectedID;
  int _selectedID = -1;
  List<Row> _rows = [];
  SimpleStream _rowSelectedStreamer = new SimpleStream();

  Table(this.target);

  populate(List<String> rowTexts, List<int> ids) {
    if (rowTexts != null && ids != null && rowTexts.length == ids.length) {
      for (int i = 0; i < ids.length; i++) {
        addRow(rowTexts[i], ids[i]);
      }
    }
  }

  addRow(String text, int id) {
    var row = new Row(text, id);
    row.onClick((e) {
      _selectedID = row.id;
      _rowSelectedStreamer.add(_selectedID);
    });

    _rows.add(row);
    target.children.add(row.target);
  }

  onNewRowSelectedStreamer(Function handler) => _rowSelectedStreamer.listen(handler);
}