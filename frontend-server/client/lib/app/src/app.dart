// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import '../../page/page.dart';
import '../../button/button.dart';
import '../../topbar/topbar.dart';
class App {
  DivElement _pageDiv;
  Page _curPage;
  StandardBtn _homeBtn;
  TopBar _topBar;
  final String curEndpoint = "/";
  SelectorPage _selectorPage;

  App() {
    _topBar = new TopBar(curEndpoint);
    _selectorPage = new SelectorPage();
    _selectorPage.onChangePage(_changePage);
    _curPage = _selectorPage;
  }

  run() {
    print(window.navigator.userAgent);
    _pageDiv = querySelector('#page');
    _curPage.select();
    _homeBtn = new StandardBtn(querySelector('#home-option'));
    _homeBtn.onClick(_selectorPage.repositionPages);
  }

  _changePage(Page newPage) {
    _pageDiv.children.clear();
    HttpRequest.getString(newPage.htmlDoc).then((resp) {
      _pageDiv.appendHtml(resp);
      _curPage = newPage;
      newPage.load();
    });
  }
}
