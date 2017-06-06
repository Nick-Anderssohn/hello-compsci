// Copyright (C) 2017  Nicholas Anderssohn
import 'topbaroption.dart';
import 'package:simple_streams/simple_streams.dart';

const String niceGrey = "#e7e8e9";
const String white = "#FFFFFF";

class TopBar {
  List<TopBarOption> options = [];
  SimpleStream _changePageStream = new SimpleStream();
  TopBar();

  onChangePage(handler(var e)) => _changePageStream.listen(handler);

  addOption(TopBarOption option) {
    options.add(option);
    option.onClick(handleOptionClick);
  }

  addOptions(List<TopBarOption> newOptions) {
    newOptions.forEach(addOption);
  }

  handleOptionClick(TopBarOption option) {
    if (!option.isSelected) {
      selectOption(option);
    }
  }

  selectOption(TopBarOption option) {
    _unselectAll();
    option.isSelected = true;
    option.target.style.backgroundColor = niceGrey;
    _changePageStream.add(option.htmlDoc); // path to html file that should now populate the main section of the page
  }

  _unselectAll() {
    for (var option in options) {
      option..isSelected = false
            ..target.style.backgroundColor = white;
    }
  }
}
