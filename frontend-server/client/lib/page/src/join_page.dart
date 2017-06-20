// Copyright (C) 2017  Nicholas Anderssohn

import 'page.dart';

class JoinPage extends Page {
  String htmlDoc = '../resources/join.html';

  JoinPage();

  load() {
    print("load join page");
    if (!hasBeenLoaded) {
      hasBeenLoaded = true;
    }
  }
}
