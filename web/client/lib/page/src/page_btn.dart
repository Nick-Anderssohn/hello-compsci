// Copyright (C) 2017  Nicholas Anderssohn
import 'page.dart';
import 'btn.dart';
import 'dart:html';
import 'package:simple_streams/simple_streams.dart';

class PageBtn extends Btn {
  Page page;
  SimpleStream _clickStream = new SimpleStream();

  PageBtn(Element target, this.page) : super(target){
    target.onClick.listen(_onTargetClick);
  }
  onClick(handler(var e)) => _clickStream.listen(handler);
  _onTargetClick(var e) => page.select();

  cancelAllClickSubs() {
    _clickStream.cancelAll();
  }

  newTarget(Element target) {
    this.target = target;
    target.onClick.listen(_onTargetClick);
  }
}
