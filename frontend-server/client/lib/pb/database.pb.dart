///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: library_prefixes
library pb_database;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class NewClassReq extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('NewClassReq')
    ..a<String>(1, 'className', PbFieldType.OS)
    ..a<String>(2, 'email', PbFieldType.OS)
    ..a<String>(3, 'password', PbFieldType.OS)
    ..a<String>(4, 'sessionGUID', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  NewClassReq() : super();
  NewClassReq.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  NewClassReq.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  NewClassReq clone() => new NewClassReq()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static NewClassReq create() => new NewClassReq();
  static PbList<NewClassReq> createRepeated() => new PbList<NewClassReq>();
  static NewClassReq getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNewClassReq();
    return _defaultInstance;
  }
  static NewClassReq _defaultInstance;
  static void $checkItem(NewClassReq v) {
    if (v is! NewClassReq) checkItemFailed(v, 'NewClassReq');
  }

  String get className => $_get(0, 1, '');
  set className(String v) { $_setString(0, 1, v); }
  bool hasClassName() => $_has(0, 1);
  void clearClassName() => clearField(1);

  String get email => $_get(1, 2, '');
  set email(String v) { $_setString(1, 2, v); }
  bool hasEmail() => $_has(1, 2);
  void clearEmail() => clearField(2);

  String get password => $_get(2, 3, '');
  set password(String v) { $_setString(2, 3, v); }
  bool hasPassword() => $_has(2, 3);
  void clearPassword() => clearField(3);

  String get sessionGUID => $_get(3, 4, '');
  set sessionGUID(String v) { $_setString(3, 4, v); }
  bool hasSessionGUID() => $_has(3, 4);
  void clearSessionGUID() => clearField(4);
}

class _ReadonlyNewClassReq extends NewClassReq with ReadonlyMessageMixin {}

class SessionResp extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SessionResp')
    ..a<String>(1, 'sessionGUID', PbFieldType.OS)
    ..a<bool>(2, 'success', PbFieldType.OB)
    ..a<String>(3, 'message', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SessionResp() : super();
  SessionResp.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SessionResp.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SessionResp clone() => new SessionResp()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SessionResp create() => new SessionResp();
  static PbList<SessionResp> createRepeated() => new PbList<SessionResp>();
  static SessionResp getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySessionResp();
    return _defaultInstance;
  }
  static SessionResp _defaultInstance;
  static void $checkItem(SessionResp v) {
    if (v is! SessionResp) checkItemFailed(v, 'SessionResp');
  }

  String get sessionGUID => $_get(0, 1, '');
  set sessionGUID(String v) { $_setString(0, 1, v); }
  bool hasSessionGUID() => $_has(0, 1);
  void clearSessionGUID() => clearField(1);

  bool get success => $_get(1, 2, false);
  set success(bool v) { $_setBool(1, 2, v); }
  bool hasSuccess() => $_has(1, 2);
  void clearSuccess() => clearField(2);

  String get message => $_get(2, 3, '');
  set message(String v) { $_setString(2, 3, v); }
  bool hasMessage() => $_has(2, 3);
  void clearMessage() => clearField(3);
}

class _ReadonlySessionResp extends SessionResp with ReadonlyMessageMixin {}

class Submission extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Submission')
    ..a<String>(1, 'studentName', PbFieldType.OS)
    ..a<String>(2, 'answerText', PbFieldType.OS)
    ..a<bool>(3, 'graded', PbFieldType.OB)
    ..a<bool>(4, 'correct', PbFieldType.OB)
    ..a<bool>(5, 'success', PbFieldType.OB)
    ..a<String>(6, 'message', PbFieldType.OS)
    ..a<Int64>(7, 'id', PbFieldType.OU6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  Submission() : super();
  Submission.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Submission.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Submission clone() => new Submission()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Submission create() => new Submission();
  static PbList<Submission> createRepeated() => new PbList<Submission>();
  static Submission getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySubmission();
    return _defaultInstance;
  }
  static Submission _defaultInstance;
  static void $checkItem(Submission v) {
    if (v is! Submission) checkItemFailed(v, 'Submission');
  }

  String get studentName => $_get(0, 1, '');
  set studentName(String v) { $_setString(0, 1, v); }
  bool hasStudentName() => $_has(0, 1);
  void clearStudentName() => clearField(1);

  String get answerText => $_get(1, 2, '');
  set answerText(String v) { $_setString(1, 2, v); }
  bool hasAnswerText() => $_has(1, 2);
  void clearAnswerText() => clearField(2);

  bool get graded => $_get(2, 3, false);
  set graded(bool v) { $_setBool(2, 3, v); }
  bool hasGraded() => $_has(2, 3);
  void clearGraded() => clearField(3);

  bool get correct => $_get(3, 4, false);
  set correct(bool v) { $_setBool(3, 4, v); }
  bool hasCorrect() => $_has(3, 4);
  void clearCorrect() => clearField(4);

  bool get success => $_get(4, 5, false);
  set success(bool v) { $_setBool(4, 5, v); }
  bool hasSuccess() => $_has(4, 5);
  void clearSuccess() => clearField(5);

  String get message => $_get(5, 6, '');
  set message(String v) { $_setString(5, 6, v); }
  bool hasMessage() => $_has(5, 6);
  void clearMessage() => clearField(6);

  Int64 get id => $_get(6, 7, null);
  set id(Int64 v) { $_setInt64(6, 7, v); }
  bool hasId() => $_has(6, 7);
  void clearId() => clearField(7);
}

class _ReadonlySubmission extends Submission with ReadonlyMessageMixin {}

class Setting extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Setting')
    ..a<String>(1, 'name', PbFieldType.OS)
    ..a<bool>(2, 'isSelected', PbFieldType.OB)
    ..a<bool>(3, 'success', PbFieldType.OB)
    ..a<String>(4, 'message', PbFieldType.OS)
    ..a<Int64>(5, 'id', PbFieldType.OU6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  Setting() : super();
  Setting.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Setting.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Setting clone() => new Setting()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Setting create() => new Setting();
  static PbList<Setting> createRepeated() => new PbList<Setting>();
  static Setting getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySetting();
    return _defaultInstance;
  }
  static Setting _defaultInstance;
  static void $checkItem(Setting v) {
    if (v is! Setting) checkItemFailed(v, 'Setting');
  }

  String get name => $_get(0, 1, '');
  set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  bool get isSelected => $_get(1, 2, false);
  set isSelected(bool v) { $_setBool(1, 2, v); }
  bool hasIsSelected() => $_has(1, 2);
  void clearIsSelected() => clearField(2);

  bool get success => $_get(2, 3, false);
  set success(bool v) { $_setBool(2, 3, v); }
  bool hasSuccess() => $_has(2, 3);
  void clearSuccess() => clearField(3);

  String get message => $_get(3, 4, '');
  set message(String v) { $_setString(3, 4, v); }
  bool hasMessage() => $_has(3, 4);
  void clearMessage() => clearField(4);

  Int64 get id => $_get(4, 5, null);
  set id(Int64 v) { $_setInt64(4, 5, v); }
  bool hasId() => $_has(4, 5);
  void clearId() => clearField(5);
}

class _ReadonlySetting extends Setting with ReadonlyMessageMixin {}

class Problem extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Problem')
    ..a<Int64>(1, 'id', PbFieldType.OU6, Int64.ZERO)
    ..a<String>(2, 'title', PbFieldType.OS)
    ..a<String>(3, 'prompt', PbFieldType.OS)
    ..pp<Submission>(4, 'submissions', PbFieldType.PM, Submission.$checkItem, Submission.create)
    ..pp<Setting>(5, 'settings', PbFieldType.PM, Setting.$checkItem, Setting.create)
    ..a<bool>(6, 'success', PbFieldType.OB)
    ..a<String>(7, 'message', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Problem() : super();
  Problem.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Problem.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Problem clone() => new Problem()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Problem create() => new Problem();
  static PbList<Problem> createRepeated() => new PbList<Problem>();
  static Problem getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyProblem();
    return _defaultInstance;
  }
  static Problem _defaultInstance;
  static void $checkItem(Problem v) {
    if (v is! Problem) checkItemFailed(v, 'Problem');
  }

  Int64 get id => $_get(0, 1, null);
  set id(Int64 v) { $_setInt64(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  String get title => $_get(1, 2, '');
  set title(String v) { $_setString(1, 2, v); }
  bool hasTitle() => $_has(1, 2);
  void clearTitle() => clearField(2);

  String get prompt => $_get(2, 3, '');
  set prompt(String v) { $_setString(2, 3, v); }
  bool hasPrompt() => $_has(2, 3);
  void clearPrompt() => clearField(3);

  List<Submission> get submissions => $_get(3, 4, null);

  List<Setting> get settings => $_get(4, 5, null);

  bool get success => $_get(5, 6, false);
  set success(bool v) { $_setBool(5, 6, v); }
  bool hasSuccess() => $_has(5, 6);
  void clearSuccess() => clearField(6);

  String get message => $_get(6, 7, '');
  set message(String v) { $_setString(6, 7, v); }
  bool hasMessage() => $_has(6, 7);
  void clearMessage() => clearField(7);
}

class _ReadonlyProblem extends Problem with ReadonlyMessageMixin {}

class EducatorHomeData extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EducatorHomeData')
    ..a<String>(1, 'className', PbFieldType.OS)
    ..p<String>(2, 'problemTitles', PbFieldType.PS)
    ..p<Int64>(3, 'problemIDs', PbFieldType.PU6)
    ..a<Problem>(4, 'currentProblem', PbFieldType.OM, Problem.getDefault, Problem.create)
    ..a<bool>(5, 'success', PbFieldType.OB)
    ..a<String>(6, 'message', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  EducatorHomeData() : super();
  EducatorHomeData.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EducatorHomeData.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EducatorHomeData clone() => new EducatorHomeData()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EducatorHomeData create() => new EducatorHomeData();
  static PbList<EducatorHomeData> createRepeated() => new PbList<EducatorHomeData>();
  static EducatorHomeData getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEducatorHomeData();
    return _defaultInstance;
  }
  static EducatorHomeData _defaultInstance;
  static void $checkItem(EducatorHomeData v) {
    if (v is! EducatorHomeData) checkItemFailed(v, 'EducatorHomeData');
  }

  String get className => $_get(0, 1, '');
  set className(String v) { $_setString(0, 1, v); }
  bool hasClassName() => $_has(0, 1);
  void clearClassName() => clearField(1);

  List<String> get problemTitles => $_get(1, 2, null);

  List<Int64> get problemIDs => $_get(2, 3, null);

  Problem get currentProblem => $_get(3, 4, null);
  set currentProblem(Problem v) { setField(4, v); }
  bool hasCurrentProblem() => $_has(3, 4);
  void clearCurrentProblem() => clearField(4);

  bool get success => $_get(4, 5, false);
  set success(bool v) { $_setBool(4, 5, v); }
  bool hasSuccess() => $_has(4, 5);
  void clearSuccess() => clearField(5);

  String get message => $_get(5, 6, '');
  set message(String v) { $_setString(5, 6, v); }
  bool hasMessage() => $_has(5, 6);
  void clearMessage() => clearField(6);
}

class _ReadonlyEducatorHomeData extends EducatorHomeData with ReadonlyMessageMixin {}

class EducatorHomeDataRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EducatorHomeDataRequest')
    ..a<String>(1, 'className', PbFieldType.OS)
    ..a<String>(2, 'sessionGUID', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  EducatorHomeDataRequest() : super();
  EducatorHomeDataRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EducatorHomeDataRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EducatorHomeDataRequest clone() => new EducatorHomeDataRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EducatorHomeDataRequest create() => new EducatorHomeDataRequest();
  static PbList<EducatorHomeDataRequest> createRepeated() => new PbList<EducatorHomeDataRequest>();
  static EducatorHomeDataRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEducatorHomeDataRequest();
    return _defaultInstance;
  }
  static EducatorHomeDataRequest _defaultInstance;
  static void $checkItem(EducatorHomeDataRequest v) {
    if (v is! EducatorHomeDataRequest) checkItemFailed(v, 'EducatorHomeDataRequest');
  }

  String get className => $_get(0, 1, '');
  set className(String v) { $_setString(0, 1, v); }
  bool hasClassName() => $_has(0, 1);
  void clearClassName() => clearField(1);

  String get sessionGUID => $_get(1, 2, '');
  set sessionGUID(String v) { $_setString(1, 2, v); }
  bool hasSessionGUID() => $_has(1, 2);
  void clearSessionGUID() => clearField(2);
}

class _ReadonlyEducatorHomeDataRequest extends EducatorHomeDataRequest with ReadonlyMessageMixin {}

