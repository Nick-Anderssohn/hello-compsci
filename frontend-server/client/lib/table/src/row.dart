// Copyright (C) 2017  Nicholas Anderssohn

import 'package:simple_streams/simple_streams.dart';
import 'dart:html';

class Row {
  SimpleStreamRouter _clickStreamRouter;

  TableRowElement target = new TableRowElement();
  TableCellElement _content = new TableCellElement();

  set text(String value) => _content.text = value;
  get text => _content.text;

  int get id => _id;
  int _id = 0;

  Row(String text, this._id) {
    this.text = text;
    _clickStreamRouter = new SimpleStreamRouter(target.onClick);
    target.children.add(_content);
  }

  onClick(Function handler) => _clickStreamRouter.listen(handler);
}