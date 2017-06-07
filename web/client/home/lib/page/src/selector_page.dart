// Copyright (C) 2017  Nicholas Anderssohn

import 'page.dart';
import 'create_page.dart';
import 'join_page.dart';
import 'page_btn.dart';
import 'dart:html';

class SelectorPage extends Page {
  String htmlDoc = '../resources/selector.html';
  Page createPage = new CreatePage();
  Page joinPage = new JoinPage();
  PageBtn createBtn;
  PageBtn joinBtn;

  SelectorPage() {
    createPage.onChangePage((var e) => changePageStream.add(e));
    joinPage.onChangePage((var e) => changePageStream.add(e));
  }

  load() {
    print("load selector page");
    if (!hasBeenLoaded) {
      createBtn = new PageBtn(querySelector('#create-session-btn'), createPage);
      joinBtn = new PageBtn(querySelector('#join-session-btn'), joinPage);
      hasBeenLoaded = true;
    } else {
      createBtn.newTarget(querySelector('#create-session-btn'));
      joinBtn.newTarget(querySelector('#join-session-btn'));
    }
  }
}
