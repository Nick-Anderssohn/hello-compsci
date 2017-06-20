// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'page/page.dart';
import 'strconv/strconv.dart';
class App {
  DivElement page;
  Page curPage;
  StandardBtn homeBtn;
  List topBarOptions = []; // does not include homeBtn
  final String curEndpoint = "/";
  SelectorPage selectorPage;

  App() {
    selectorPage = new SelectorPage();
    selectorPage.onChangePage(_changePage);
    curPage = selectorPage;

    topBarOptions = [
      new StandardBtn(querySelector('#about-option'), tags: ['/about']),
      new StandardBtn(querySelector('#play-option'), tags: ['/play'])
    ];
    topBarOptions.forEach((StandardBtn btn) => btn.onClick(_handleTopBarOnClick));
  }

  run() {
    page = querySelector('#page');
    curPage.select();
    // homeBtn = new PageBtn(querySelector('#home-option'), curPage);
    homeBtn = new StandardBtn(querySelector('#home-option'));
    homeBtn.onClick(selectorPage.repositionPages);
  }

  _changePage(Page newPage) {
    page.children.clear();
    HttpRequest.getString(newPage.htmlDoc).then((resp) {
      page.appendHtml(resp);
      curPage = newPage;
      newPage.load();
    });
  }

  _handleTopBarOnClick(StandardBtn btn) {
    window.location.assign(_getNEWURL(btn.tags[0]));
  }

  _getNEWURL(String newEndpoint) {
    return StrConv.getNewURL(window.location.href, curEndpoint, newEndpoint);
  }
}
