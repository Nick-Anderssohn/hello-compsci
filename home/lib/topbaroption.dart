// Copyright (C) 2017  Nicholas Anderssohn
import 'dart:html';
import 'package:simple_streams/simple_streams.dart';

class TopBarOption {
  SimpleStream _clickStream = new SimpleStream();
  bool isSelected = false;
  Element target;
  String htmlDoc;

  TopBarOption(this.target, this.htmlDoc) {
    this.target.onClick.listen(_onTargetClick);
  }

  onClick(handler(var e)) => _clickStream.listen(handler);
  _onTargetClick(var e) => _clickStream.add(this);

  cancelAllClickSubs() {
    _clickStream.cancelAll();
  }
}
