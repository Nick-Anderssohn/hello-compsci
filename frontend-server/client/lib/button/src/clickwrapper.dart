// Copyright (C) 2017  Nicholas Anderssohn

import 'package:simple_streams/simple_streams.dart';
import 'dart:html';

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

  cancellAll() {
    _router = cancellAll();
  }
}
