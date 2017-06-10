// Copyright (C) 2017  Nicholas Anderssohn
import 'btn.dart';
import 'package:simple_streams/simple_streams.dart';
import 'dart:html';

class StandardBtn extends Btn {
  SimpleStreamRouter _clickRouter;

  StandardBtn(Element target) : super(target) {
    _clickRouter = new SimpleStreamRouter(target.onClick);
  }

  onClick(handler(var e)) {
    _clickRouter.listen(handler);
  }

  cancelAllClickSubs() {
    _clickRouter.cancelAll();
  }

  newTarget(Element newTarget) {
    cancelAllClickSubs();
    target = newTarget;
    _clickRouter = new SimpleStreamRouter(target.onClick);
  }
}
