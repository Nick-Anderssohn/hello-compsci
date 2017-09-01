// Copyright (C) 2017  Nicholas Anderssohn

import 'package:simple_streams/simple_streams.dart';
import 'dart:html';

class ProblemRow {
  SimpleStreamRouter _clickStreamRouter;

  TableRowElement target = new TableRowElement();
  TableCellElement _content = new TableCellElement();

  set problemName(String value) => _content.text = value;
  get problemName => _content.text;

  int get problemID => _problemID;
  int _problemID = 0;

  ProblemRow(String problemName, this._problemID) {
    this.problemName = problemName;
    _clickStreamRouter = new SimpleStreamRouter(target.onClick);
    target.children.add(_content);
  }

  onClick(Function handler) => _clickStreamRouter.listen(handler);
}