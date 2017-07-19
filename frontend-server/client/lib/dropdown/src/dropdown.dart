// Copyright (C) 2017  Nicholas Anderssohn
import 'dart:html';
import 'package:simple_streams/simple_streams.dart';

class DropDown {
  DivElement target = new DivElement();
  DivElement parent;
  List<DivElement> items = new List<DivElement>();
  bool _mouseIsOver = false;
  bool _mouseIsOverParent = false;
  SimpleStreamRouter _parentClickRouter;

  DropDown(this.parent) {
    _setupParent();
    _setupTarget();
    hide();
    window.onClick.listen(_handleClickOffOfDropDown);
  }

  _setupParent() {
    _parentClickRouter = new SimpleStreamRouter(parent.onClick);
    parent.children.add(target);
  }

  _setupTarget() {
    onClick((var e) => target.hidden = !target.hidden);
    target.classes.add('drop-down');
    target.onMouseEnter.listen((var e) => _mouseIsOver = true);
    target.onMouseLeave.listen((var e) => _mouseIsOver = false);
    target.parent.onMouseEnter.listen((var e) => _mouseIsOverParent = true);
    target.parent.onMouseLeave.listen((var e) => _mouseIsOverParent = false);
  }

  onClick(handler(var e)) => _parentClickRouter.listen(handler);

  _handleClickOffOfDropDown(var e) {
    if (!_mouseIsOver && !_mouseIsOverParent) {
      hide();
    }
  }

  //applies styling for you
  addItem(DivElement item) {
    item.classes.add('drop-down-item');
    target.children.add(item);
  }

  show() {
    target.hidden = false;
  }

  hide() {
    target.hidden = true;
  }
}
