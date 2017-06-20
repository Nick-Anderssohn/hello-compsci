// Copyright (C) 2017  Nicholas Anderssohn

class StrConv {
  static String getNewURL(String curURL, String curEndpoint, String newEndpoint) {
    String newURL = curURL;
    var index = newURL.lastIndexOf(curEndpoint);
    newURL = newURL.substring(0, index);
    return newURL + newEndpoint;

  }
}
