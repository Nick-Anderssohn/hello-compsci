// Copyright (C) 2017  Nicholas Anderssohn
import 'dart:html';

abstract class Btn {
  Element target;
  Btn(this.target);

  onClick(handler(var e));
  cancelAllClickSubs();
}
