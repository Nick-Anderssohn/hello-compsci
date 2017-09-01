///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: library_prefixes
library pb_database_pbjson;

const NewClassReq$json = const {
  '1': 'NewClassReq',
  '2': const [
    const {'1': 'className', '3': 1, '4': 1, '5': 9, '10': 'className'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'sessionGUID', '3': 4, '4': 1, '5': 9, '10': 'sessionGUID'},
  ],
};

const SessionResp$json = const {
  '1': 'SessionResp',
  '2': const [
    const {'1': 'sessionGUID', '3': 1, '4': 1, '5': 9, '10': 'sessionGUID'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

const Submission$json = const {
  '1': 'Submission',
  '2': const [
    const {'1': 'studentName', '3': 1, '4': 1, '5': 9, '10': 'studentName'},
    const {'1': 'answerText', '3': 2, '4': 1, '5': 9, '10': 'answerText'},
    const {'1': 'graded', '3': 3, '4': 1, '5': 8, '10': 'graded'},
    const {'1': 'correct', '3': 4, '4': 1, '5': 8, '10': 'correct'},
    const {'1': 'success', '3': 5, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'id', '3': 7, '4': 1, '5': 4, '10': 'id'},
  ],
};

const Setting$json = const {
  '1': 'Setting',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'isSelected', '3': 2, '4': 1, '5': 8, '10': 'isSelected'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'id', '3': 5, '4': 1, '5': 4, '10': 'id'},
  ],
};

const Problem$json = const {
  '1': 'Problem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'prompt', '3': 3, '4': 1, '5': 9, '10': 'prompt'},
    const {'1': 'submissions', '3': 4, '4': 3, '5': 11, '6': '.pb.Submission', '10': 'submissions'},
    const {'1': 'settings', '3': 5, '4': 3, '5': 11, '6': '.pb.Setting', '10': 'settings'},
    const {'1': 'success', '3': 6, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
  ],
};

const EducatorHomeData$json = const {
  '1': 'EducatorHomeData',
  '2': const [
    const {'1': 'className', '3': 1, '4': 1, '5': 9, '10': 'className'},
    const {'1': 'problemTitles', '3': 2, '4': 3, '5': 9, '10': 'problemTitles'},
    const {'1': 'problemIDs', '3': 3, '4': 3, '5': 4, '10': 'problemIDs'},
    const {'1': 'currentProblem', '3': 4, '4': 1, '5': 11, '6': '.pb.Problem', '10': 'currentProblem'},
    const {'1': 'success', '3': 5, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

const EducatorHomeDataRequest$json = const {
  '1': 'EducatorHomeDataRequest',
  '2': const [
    const {'1': 'className', '3': 1, '4': 1, '5': 9, '10': 'className'},
    const {'1': 'sessionGUID', '3': 2, '4': 1, '5': 9, '10': 'sessionGUID'},
  ],
};

const LoginRequest$json = const {
  '1': 'LoginRequest',
  '2': const [
    const {'1': 'className', '3': 1, '4': 1, '5': 9, '10': 'className'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'sessionGUID', '3': 3, '4': 1, '5': 9, '10': 'sessionGUID'},
  ],
};

const LoginResponse$json = const {
  '1': 'LoginResponse',
  '2': const [
    const {'1': 'className', '3': 1, '4': 1, '5': 9, '10': 'className'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'sessionGUID', '3': 3, '4': 1, '5': 9, '10': 'sessionGUID'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

