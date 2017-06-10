// Copyright (C) 2017  Nicholas Anderssohn
import 'btn.dart';
import 'package:simple_streams/simple_streams.dart';
import 'dart:html';

class StandardBtn extends Btn {
  SimpleStreamRouter _clickRouter;
  SimpleStream _clickStreamer = new SimpleStream();
  bool enabled = true;

  StandardBtn(Element target) : super(target) {
    _clickRouter = new SimpleStreamRouter(target.onClick);
    _clickRouter.listen(_onElementClick);
  }

  onClick(handler(var e)) {
    _clickStreamer.listen(handler);
  }

  cancelAllClickSubs() {
    _clickRouter.cancelAll();
  }

  newTarget(Element newTarget) {
    cancelAllClickSubs();
    target = newTarget;
    _clickRouter = new SimpleStreamRouter(target.onClick);
  }

  _onElementClick(var e) {
    if (enabled) {
      _clickStreamer.add(e);
    }
  }
}
