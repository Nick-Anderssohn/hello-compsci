// Copyright (C) 2017  Nicholas Anderssohn

import 'page.dart';

class CreatePage extends Page {
  String htmlDoc = '../resources/create.html';

  CreatePage();

  load() {
    print("load create page");
    if (!hasBeenLoaded) {
      hasBeenLoaded = true;
    }
  }
}
