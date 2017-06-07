// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'page/page.dart';

class App {
  DivElement page;
  List<PageBtn> options = [];
  Page curPage;
  PageBtn homeBtn;

  App() {
    var selectorPage = new SelectorPage();
    selectorPage.onChangePage(_changePage);
    curPage = selectorPage;
  }

  run() {
    page = querySelector('#page');
    curPage.select();
    homeBtn = new PageBtn(querySelector('#home-option'), curPage);
  }

  _changePage(Page newPage) {
    page.children.clear();
    HttpRequest.getString(newPage.htmlDoc).then((resp) {
      page.appendHtml(resp);
      curPage = newPage;
      newPage.load();
    });
  }
}
