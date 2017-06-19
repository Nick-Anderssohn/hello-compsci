// Copyright (C) 2017  Nicholas Anderssohn
import 'dart:html';

abstract class Btn {
  Element target;
  set text(String t) => target.text = t;
  get text => target.text;
  Btn(this.target);

  onClick(handler(var e));
  cancelAllClickSubs();
}
