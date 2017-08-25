///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: library_prefixes
library pb_database;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

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
}

class _ReadonlySessionResp extends SessionResp with ReadonlyMessageMixin {}

