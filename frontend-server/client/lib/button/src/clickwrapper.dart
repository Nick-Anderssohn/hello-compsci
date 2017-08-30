// Copyright (C) 2017  Nicholas Anderssohn

import 'package:simple_streams/simple_streams.dart';
import 'dart:html';
import 'dart:async';

class ClickWrapper {
  SimpleStreamRouter _router;
  SimpleStreamRouter _blurRouter;
  SimpleStreamRouter _keyDownRouter;
  SimpleStreamRouter _focusRouter;
  Element target;

  ClickWrapper(this.target) {
    _router = new SimpleStreamRouter(target.onClick);
    _blurRouter = new SimpleStreamRouter(target.onBlur);
    _keyDownRouter = new SimpleStreamRouter(target.onKeyDown);
    _focusRouter = new SimpleStreamRouter(target.onFocus);
  }

  onClick(handler(var e)) => _router.listen(handler);
  onBlur(handler(var e)) => _blurRouter.listen(handler);
  onKeyDown(handler(var e)) => _keyDownRouter.listen(handler);
  onFocus(handler(var e)) => _focusRouter.listen(handler);

  cancelClickSub(StreamSubscription sub) => _router.cancelSub(sub);
  cancelBlurSub(StreamSubscription sub) => _blurRouter.cancelSub(sub);
  cancelKeyDownSub(StreamSubscription sub) => _keyDownRouter.cancelSub(sub);
  cancelFocusSub(StreamSubscription sub) => _focusRouter.cancelSub(sub);

  cancellAll() {
    _router.cancelAll();
    _blurRouter.cancelAll();
    _keyDownRouter.cancelAll();
    _focusRouter.cancelAll();
  }
}
