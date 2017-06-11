// Copyright (C) 2017  Nicholas Anderssohn

import 'package:simple_streams/simple_streams.dart';

abstract class Page {
  String htmlDoc;
  bool hasBeenLoaded = false;
  SimpleStream changePageStream = new SimpleStream();

  load();

  select() {
    changePageStream.add(this);
  }

  onChangePage(handler(var e)) {
    changePageStream.listen(handler);
  }
}
