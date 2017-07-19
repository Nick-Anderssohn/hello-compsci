// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import '../../strconv/strconv.dart';
import '../../button/button.dart';

class TopBar {
  List _topBarOptions = [];
  String curEndpoint;

  TopBar(this.curEndpoint) {
    _topBarOptions = [
      new StandardBtn(querySelector('#home-option'), tags: ['/']),
      new StandardBtn(querySelector('#play-option'), tags: ['/play']),
      new StandardBtn(querySelector('#about-option'), tags: ['/about'])
    ];
    _topBarOptions.forEach((StandardBtn btn) => btn.onClick(_handleTopBarOnClick));
  }

  _handleTopBarOnClick(StandardBtn btn) {
    if (btn.tags[0] != curEndpoint)
      window.location.assign(_getNEWURL(btn.tags[0]));
  }

  _getNEWURL(String newEndpoint) {
    return StrConv.getNewURL(window.location.href, curEndpoint, newEndpoint);
  }
}
