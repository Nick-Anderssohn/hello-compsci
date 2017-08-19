// Copyright (C) 2017  Nicholas Anderssohn

import 'package:simple_streams/simple_streams.dart';
import 'dart:html';
import 'dart:async';

class ClickWrapper {
  SimpleStreamRouter _router;
  SimpleStreamRouter _blurRouter;
  SimpleStreamRouter _keyDownRouter;
  Element target;

  ClickWrapper(this.target) {
    _router = new SimpleStreamRouter(target.onClick);
    _blurRouter = new SimpleStreamRouter(target.onBlur);
    _keyDownRouter = new SimpleStreamRouter(target.onKeyDown);
  }

  onClick(handler(var e)) => _router.listen(handler);
  onBlur(handler(var e)) => _blurRouter.listen(handler);
  onKeyDown(handler(var e)) => _keyDownRouter.listen(handler);

  cancelClickSub(StreamSubscription sub) => _router.cancelSub(sub);
  cancelBlurSub(StreamSubscription sub) => _blurRouter.cancelSub(sub);
  cancelKeyDownSub(StreamSubscription sub) => _keyDownRouter.cancelSub(sub);

  cancellAll() {
    _router = cancellAll();
  }
}
