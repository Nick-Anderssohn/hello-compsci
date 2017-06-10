// Copyright (C) 2017  Nicholas Anderssohn

import 'page.dart';
import 'create_page.dart';
import 'join_page.dart';
import 'standard_btn.dart';
import 'dart:html';
import 'clickwrapper.dart';
import 'dart:async';

class SelectorPage extends Page {
  String htmlDoc = '../resources/selector.html';
  // String htmlDoc = '../resources/join.html';
  // Page createPage = new CreatePage();
  // Page joinPage = new JoinPage();
  StandardBtn selectCreatePageBtn;
  StandardBtn selectJoinPageBtn;
  StandardBtn joinSessionBtn;
  ClickWrapper joinSessionTextbox;
  StandardBtn createSessionBtn;
  ClickWrapper createSessionTextbox;
  DivElement createPage;
  DivElement joinPage;
  DivElement selectPage;
  DivElement curPage;
  String left = "calc(-100% - 10px)";
  String middle = "0px";
  String right = "calc(100% + 10px)";
  static const int animDuration = 1100; // milliseconds

  SelectorPage() {
    // createPage.onChangePage((var e) => changePageStream.add(e));
    // joinPage.onChangePage((var e) => changePageStream.add(e));
  }

  load() {
    print("load selector page");
    if (!hasBeenLoaded) {
      createPage = querySelector('#create-page');
      joinPage = querySelector('#join-page');
      curPage = selectPage = querySelector('#select-page');
      selectCreatePageBtn =
          new StandardBtn(querySelector('#select-create-page-btn'));
      selectJoinPageBtn =
          new StandardBtn(querySelector('#select-join-page-btn'));
      joinSessionBtn = new StandardBtn(querySelector('#join-session-btn'));
      joinSessionTextbox =
          new ClickWrapper(querySelector('#join-session-textbox'));
      joinSessionTextbox
        ..onClick(_onJoinSessionTextboxClick)
        ..onBlur(_onJoinSessionTextboxBlur)
        ..onKeyDown(_handleEnter);
      (joinSessionTextbox.target as InputElement).value = "Session Name";
      selectJoinPageBtn.onClick(_selectJoinPageBtnClick);

      createSessionBtn = new StandardBtn(querySelector('#create-session-btn'));
      createSessionTextbox =
          new ClickWrapper(querySelector('#create-session-textbox'));
      createSessionTextbox
        ..onClick(_onCreateSessionTextboxClick)
        ..onBlur(_onCreateSessionTextboxBlur)
        ..onKeyDown(_handleEnter);
      (createSessionTextbox.target as InputElement).value = "Session Name";
      selectCreatePageBtn.onClick(_selectCreatePageBtnClick);
      hasBeenLoaded = true;
    } else {
      // createBtn.newTarget(querySelector('#create-session-btn'));
      // selectJoinPageBtn.newTarget(querySelector('#join-session-btn'));
    }
  }

  _selectJoinPageBtnClick(var e) {
    _slideOutLeft(selectPage);
    _slideIn(joinPage);
    curPage = joinPage;
  }

  _selectCreatePageBtnClick(var e) {
    _slideOutRight(selectPage);
    _slideIn(createPage);
    curPage = createPage;
  }

  _slideOutLeft(DivElement page) async {
    page.classes.add('page-out-left');
    new Future.delayed(const Duration(milliseconds: animDuration), () {
      page.style.left = left;
      page.classes.remove('page-out-left');
    });
  }

  _slideOutRight(DivElement page) async {
    page.classes.add('page-out-right');
    new Future.delayed(const Duration(milliseconds: animDuration), () {
      page.style.left = right;
      page.classes.remove('page-out-right');
    });
  }

  _slideIn(DivElement page) async {
    page.classes.add('page-in');
    new Future.delayed(const Duration(milliseconds: animDuration), () {
      page.style.left = middle;
      page.classes.remove('page-in');
    });
  }

  repositionPages(var e) {
    if (curPage == selectPage) {
      return;
    }
    if (curPage == joinPage) {
      _slideOutRight(joinPage);
    } else {
      _slideOutLeft(createPage);
    }
    _slideIn(selectPage);
  }

  _removePageAnimations(DivElement page) {
    page.classes
      ..remove('page-in')
      ..remove('page-out-right')
      ..remove('page-out-left');
  }

  _onJoinSessionTextboxClick(var e) {
    if ((joinSessionTextbox.target as InputElement).value == "Session Name") {
      (joinSessionTextbox.target as InputElement).value = "";
    }
  }

  _onCreateSessionTextboxClick(var e) {
    if ((createSessionTextbox.target as InputElement).value == "Session Name") {
      (createSessionTextbox.target as InputElement).value = "";
    }
  }

  _onJoinSessionTextboxBlur(var e) {
    if ((joinSessionTextbox.target as InputElement).value.trim() == "") {
      (joinSessionTextbox.target as InputElement).value = "Session Name";
    }
  }

  _onCreateSessionTextboxBlur(var e) {
    if ((createSessionTextbox.target as InputElement).value.trim() == "") {
      (createSessionTextbox.target as InputElement).value = "Session Name";
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
