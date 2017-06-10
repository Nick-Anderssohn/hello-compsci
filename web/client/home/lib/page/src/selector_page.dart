// Copyright (C) 2017  Nicholas Anderssohn

import 'page.dart';
import 'create_page.dart';
import 'join_page.dart';
import 'standard_btn.dart';
import 'dart:html';

class SelectorPage extends Page {
  // String htmlDoc = '../resources/selector.html';
  String htmlDoc = '../resources/join.html';
  // Page createPage = new CreatePage();
  // Page joinPage = new JoinPage();
  StandardBtn createBtn;
  StandardBtn selectJoinPageBtn;
  StandardBtn joinSessionBtn;

  SelectorPage() {
    // createPage.onChangePage((var e) => changePageStream.add(e));
    // joinPage.onChangePage((var e) => changePageStream.add(e));
  }

  load() {
    print("load selector page");
    if (!hasBeenLoaded) {
      // createBtn = new StandardBtn(querySelector('#create-session-btn'));
      // selectJoinPageBtn = new StandardBtn(querySelector('#join-session-btn'));
      joinSessionBtn = new StandardBtn(querySelector('#join-session-btn'));
      //selectJoinPageBtn.onClick(_slideLeft);
      hasBeenLoaded = true;
    } else {
      createBtn.newTarget(querySelector('#create-session-btn'));
      selectJoinPageBtn.newTarget(querySelector('#join-session-btn'));
    }
  }

  _slideLeft(var e) {
    selectJoinPageBtn.target.classes.add('selectJoinPageBtn-slide-left-class');
    createBtn.target.classes.add('createbtn-slide-left-class');
  }
}
