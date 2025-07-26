// All of the validation functions

bool isStringAValidUrl(String inputVal) {
  bool isValid = false;
  Uri? val = Uri.tryParse(inputVal);
  if (val == null) {
    isValid = false;
  } else {
    isValid = val.isAbsolute;
  }

  return isValid;
}

bool isPdfUrl(String value) {
  String pattern = r"(http(s?):)([/|.|\w|\s|-])*\.pdf";
  RegExp regex = RegExp(pattern);
  if (!(value.contains(regex))) {
    return false;
  } else {
    return true;
  }
}

bool isImageUrl(String value) {
  String pattern = r"(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|jpeg|gif|png|webp|bmp)";
  RegExp regex = RegExp(pattern);
  if (!(value.contains(regex))) {
    return false;
  } else {
    return true;
  }
}

bool hasValidUrl(String value) {
  String pattern = r'^((http|https):\/\/.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
        return false;
  }
  else if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}

bool isValidUrl(String text) {
  final urlPattern = RegExp(
    r'^(https?:\/\/)?(([a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}|'
    r'((\d{1,3}\.){3}\d{1,3}))(\:\d+)?(\/[-a-zA-Z0-9%_.~#+ ]*)*'
    r'(\?[;&a-zA-Z0-9%_.~+=-]*)?(\#[-a-zA-Z0-9%_.~+=-]*)?$',
    caseSensitive: false,
  );
  return urlPattern.hasMatch(text);
}


