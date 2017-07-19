// Copyright (C) 2017  Nicholas Anderssohn

import 'page.dart';
import '../../button/button.dart';
import 'dart:html';
import 'dart:async';
import 'package:simple_streams/simple_streams.dart';

class SelectorPage extends Page {
  String htmlDoc = '../resources/selector.html';
  SimpleStreamRouter _joinBackArrowRouter;
  SimpleStreamRouter _createBackArrowRouter;
  StandardBtn _selectCreatePageBtn;
  StandardBtn _selectJoinPageBtn;
  StandardBtn _joinSessionBtn;
  ClickWrapper _joinSessionTextbox;
  StandardBtn _createSessionBtn;
  ClickWrapper _createSessionTextbox;
  DivElement _createPage;
  DivElement _joinPage;
  DivElement _selectPage;
  DivElement _curPage;
  final String _left = "calc(-100% - 10px)";
  final String _middle = "0px";
  final String _right = "calc(100% + 10px)";
  static const int _animDuration = 900; // milliseconds

  SelectorPage();

  load() {
    if (!hasBeenLoaded) {
      _queryElementsFromHtml();
      _setupJoinPage();
      _setupCreatePage();
      hasBeenLoaded = true;
      _joinBackArrowRouter.listen(repositionPages);
      _createBackArrowRouter.listen(repositionPages);
    }
  }

  _queryElementsFromHtml() {
    _createPage = querySelector('#create-page');
    _joinPage = querySelector('#join-page');
    _curPage = _selectPage = querySelector('#select-page');
    _selectCreatePageBtn = new StandardBtn(querySelector('#select-create-page-btn'));
    _selectJoinPageBtn = new StandardBtn(querySelector('#select-join-page-btn'));
    _joinSessionBtn = new StandardBtn(querySelector('#join-session-btn'));
    _joinSessionTextbox = new ClickWrapper(querySelector('#join-session-textbox'));
    _createSessionBtn = new StandardBtn(querySelector('#create-session-btn'));
    _createSessionTextbox = new ClickWrapper(querySelector('#create-session-textbox'));
    _joinBackArrowRouter = new SimpleStreamRouter(querySelector('#join-back-arrow').onClick);
    _createBackArrowRouter = new SimpleStreamRouter(querySelector('#create-back-arrow').onClick);
  }

  _setupJoinPage() {
    _joinSessionTextbox
      ..onClick(_onJoinSessionTextboxClick)
      ..onBlur(_onJoinSessionTextboxBlur)
      ..onKeyDown(_handleEnter);
    (_joinSessionTextbox.target as InputElement).value = "Session Name";
    _selectJoinPageBtn.onClick(_selectJoinPageBtnClick);
  }

  _setupCreatePage() {
    _createSessionTextbox
      ..onClick(_onCreateSessionTextboxClick)
      ..onBlur(_onCreateSessionTextboxBlur)
      ..onKeyDown(_handleEnter);
    (_createSessionTextbox.target as InputElement).value = "Session Name";
    _selectCreatePageBtn.onClick(_selectCreatePageBtnClick);
  }

  _selectJoinPageBtnClick(var e) {
    _slideOutLeft(_selectPage);
    _slideIn(_joinPage);
    _curPage = _joinPage;
  }

  _selectCreatePageBtnClick(var e) {
    _slideOutRight(_selectPage);
    _slideIn(_createPage);
    _curPage = _createPage;
  }

  _slideOutLeft(DivElement page) async {
    page.classes.add('page-out-left');
    new Future.delayed(const Duration(milliseconds: _animDuration), () {
      page.style.left = _left;
      page.classes.remove('page-out-left');
    });
  }

  _slideOutRight(DivElement page) async {
    page.classes.add('page-out-right');
    new Future.delayed(const Duration(milliseconds: _animDuration), () {
      page.style.left = _right;
      page.classes.remove('page-out-right');
    });
  }

  _slideIn(DivElement page) async {
    page.classes.add('page-in');
    new Future.delayed(const Duration(milliseconds: _animDuration), () {
      page.style.left = _middle;
      page.classes.remove('page-in');
    });
  }

  repositionPages(var e) {
    if (_curPage == _selectPage) {
      return;
    }
    if (_curPage == _joinPage) {
      _slideOutRight(_joinPage);
    } else {
      _slideOutLeft(_createPage);
    }
    _slideIn(_selectPage);
  }

  _onJoinSessionTextboxClick(var e) {
    if ((_joinSessionTextbox.target as InputElement).value == "Session Name") {
      (_joinSessionTextbox.target as InputElement).value = "";
    }
  }

  _onCreateSessionTextboxClick(var e) {
    if ((_createSessionTextbox.target as InputElement).value == "Session Name") {
      (_createSessionTextbox.target as InputElement).value = "";
    }
  }

  _onJoinSessionTextboxBlur(var e) {
    if ((_joinSessionTextbox.target as InputElement).value.trim() == "") {
      (_joinSessionTextbox.target as InputElement).value = "Session Name";
    }
  }

  _onCreateSessionTextboxBlur(var e) {
    if ((_createSessionTextbox.target as InputElement).value.trim() == "") {
      (_createSessionTextbox.target as InputElement).value = "Session Name";
    }
  }

  _handleEnter(KeyboardEvent e) {
    if (e.keyCode == KeyCode.ENTER) {
      print("Enter!");
    }
  }

 // currently unnecessary to disable pages since they get hidden off of the screen
  // _toggleJoinPageEnabled() {
  //   InputElement textInput = joinSessionTextbox.target;
  //   textInput.disabled = !textInput.disabled;
  //   joinSessionBtn.enabled = !joinSessionBtn.enabled;
  // }
}
