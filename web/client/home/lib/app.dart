// Copyright (C) 2017  Nicholas Anderssohn

import 'dart:html';
import 'page/page.dart';
import 'package:hello_class_lib/hello_class.dart';
class App {
  DivElement page;
  Page curPage;
  StandardBtn homeBtn;
  final String curEndpoint = "/";
  SelectorPage selectorPage;

  App() {
    selectorPage = new SelectorPage();
    selectorPage.onChangePage(_changePage);
    curPage = selectorPage;

    querySelector('#about-option').onClick.listen(_handleAboutOnClick);
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

  _handleAboutOnClick(var e) {
    window.location.assign(_getNEWURL('/about'));
  }

  _getNEWURL(String newEndpoint) {
    return StrConv.getNewURL(window.location.href, curEndpoint, newEndpoint);
  }
}
