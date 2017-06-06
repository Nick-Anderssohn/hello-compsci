// Copyright (C) 2017  Nicholas Anderssohn
import 'topbar.dart';
import 'topbaroption.dart';
import 'dart:html';

class App {
  TopBar topBar = new TopBar();
  DivElement page;
  Map _pageFunctions = {};

  App();

  run() {
    page = querySelector('#page');
    _setupTopBar();
    _setupPageFunctions();
    topBar.onChangePage(_changePage);
    _openHomePage();
  }

  _setupTopBar() {
    var options = _getOptionsFromDOM();
    topBar.addOptions(options);
  }

  List<TopBarOption> _getOptionsFromDOM() {
    List<TopBarOption> options = [];
    options.add(new TopBarOption(querySelector('#home-option'), '../resources/home.html'));
    options.add(new TopBarOption(querySelector('#about-option'), '../resources/about.html'));
    return options;
  }

  _changePage(String htmlDoc) {
    page.children.clear();
    HttpRequest.getString(htmlDoc).then((resp) {
      page.appendHtml(resp);
      _pageFunctions[htmlDoc](); // call the setup function for the page we switched to
    });
  }

  _setupPageFunctions() {
    _pageFunctions[topBar.options[0].htmlDoc] = _setupHomePage;
    _pageFunctions[topBar.options[1].htmlDoc] = _setupAboutPage;
  }

  _setupHomePage() {
    print("setupHomePage called");
  }

  _setupAboutPage() {
    print("setupAboutPage called");
  }

  _openHomePage() {
    topBar.selectOption(topBar.options[0]); // first option populated is home-option
  }
}
