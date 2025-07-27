import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_constants.dart';

enum BookStatus { none, wantToRead, reading, finished }

enum BookAccessType { none, public, borrowable }

enum BookAction { wantToRead, start, finish }

enum DialogPosition { top, center, bottom }

enum DialogAnimationType { slide, fade, scale, rotate }

enum SlideDirection { left, right, top, bottom }

enum DialogType { success, error, info, confirmation, custom }

String getBookStatusText(BookStatus status) {
  switch (status) {
    case BookStatus.wantToRead:
      return TextConstants.wantToRead;
    case BookStatus.reading:
      return TextConstants.reading;
    case BookStatus.finished:
      return TextConstants.finished;
    default:
      return TextConstants.wantToRead;
  }
}

String getBookActionText(BookAction action) {
  switch (action) {
    case BookAction.wantToRead:
      return TextConstants.wantToRead;
    case BookAction.start:
      return TextConstants.reading;
    case BookAction.finish:
      return TextConstants.finished;
  }
}

class AppConstants {
  static const privacyPolicyUrl = '';
  static double dialogMaxWidth = 0.95.sw;
  static double dialogMaxHeight = 0.8.sh;
}
