// Copyright (C) 2017  Nicholas Anderssohn

import '../../pb/database.pb.dart';
import 'dart:html';

class ProblemSettings {
  InputElement _autoGrade;
  InputElement _langC;
  InputElement _langCPP;
  InputElement _langPython3;
  InputElement _langGo;
  InputElement _langJava;
  InputElement _trimEdgeSpace;

  querySettingElements() {
    _autoGrade = querySelector('#auto-grade-checkbox');
    _langC = querySelector('#lang-c-checkbox');
    _langCPP = querySelector('#lang-cpp-checkbox');
    _langPython3 = querySelector('#lang-python3-checkbox');
    _langGo = querySelector('#lang-go-checkbox');
    _langJava = querySelector('#lang-java-checkbox');
    _trimEdgeSpace = querySelector('#trim-edge-space-checkbox');
  }

  List<Setting> getListOfSettings() {
    return [
      _inputToSetting('auto-grade', _autoGrade),
      _inputToSetting('lang-c', _langC),
      _inputToSetting('lang-cpp', _langCPP),
      _inputToSetting('lang-python3', _langPython3),
      _inputToSetting('lang-go', _langGo),
      _inputToSetting('lang-java', _langJava),
      _inputToSetting('trim-edge-space', _trimEdgeSpace)
    ];
  }

  Setting _inputToSetting(String settingName, InputElement checkbox) {
    var setting = new Setting();
    setting.name = settingName;
    setting.isSelected = checkbox.checked;
    return setting;
  }
}