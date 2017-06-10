// Copyright (C) 2017  Nicholas Anderssohn

import 'page.dart';
import 'create_page.dart';
import 'join_page.dart';
import 'standard_btn.dart';
import 'dart:html';
import 'clickwrapper.dart';

class SelectorPage extends Page {
  String htmlDoc = '../resources/selector.html';
  // String htmlDoc = '../resources/join.html';
  // Page createPage = new CreatePage();
  // Page joinPage = new JoinPage();
  StandardBtn selectCreatePageBtn;
  StandardBtn selectJoinPageBtn;
  StandardBtn joinSessionBtn;
  ClickWrapper joinSessionTextbox;

  SelectorPage() {
    // createPage.onChangePage((var e) => changePageStream.add(e));
    // joinPage.onChangePage((var e) => changePageStream.add(e));
  }

  load() {
    print("load selector page");
    if (!hasBeenLoaded) {
      selectCreatePageBtn = new StandardBtn(querySelector('#select-create-page-btn'));
      selectJoinPageBtn = new StandardBtn(querySelector('#select-join-page-btn'));
      joinSessionBtn = new StandardBtn(querySelector('#join-session-btn'));
      joinSessionTextbox = new ClickWrapper(querySelector('#join-session-textbox'));
      joinSessionTextbox
      ..onClick(_onJoinSessionTextboxClick)
      ..onBlur(_onJoinSessionTextboxBlur)
      ..onKeyDown(_handleEnter);
      (joinSessionTextbox.target as InputElement).value = "Session Name";
      selectJoinPageBtn.onClick(_slideLeft);
      hasBeenLoaded = true;
    } else {
      // createBtn.newTarget(querySelector('#create-session-btn'));
      // selectJoinPageBtn.newTarget(querySelector('#join-session-btn'));
    }
  }

  _slideLeft(var e) {
    selectJoinPageBtn.target.classes.add('select-join-page-btn-slide-left-class');
    selectCreatePageBtn.target.classes.add('select-create-page-btn-slide-left-class');
    joinSessionTextbox.target.classes.add('join-session-textbox-slide-left-class');
    joinSessionBtn.target.classes.add('joinbtn-slide-left-class');
  }

  _onJoinSessionTextboxClick(var e) {
    if ((joinSessionTextbox.target as InputElement).value == "Session Name") {
      (joinSessionTextbox.target as InputElement).value = "";
    }
  }

  _onJoinSessionTextboxBlur(var e) {
    if ((joinSessionTextbox.target as InputElement).value.trim() == "") {
      (joinSessionTextbox.target as InputElement).value = "Session Name";
    }
  }

  _handleEnter(KeyboardEvent e) {
    if (e.keyCode == KeyCode.ENTER) {
      print("Enter!");
    }
  }

  _toggleJoinPageEnabled() {
    InputElement textInput = joinSessionTextbox.target;
    textInput.disabled = !textInput.disabled;
    joinSessionBtn.enabled = !joinSessionBtn.enabled;
  }
}
