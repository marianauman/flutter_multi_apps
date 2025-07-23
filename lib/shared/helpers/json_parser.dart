class JsonParser {
  static String parseString(dynamic value, {String defaultValue = ''}) {
    if (value == null) return defaultValue;
    if (value is String) return value;
    if (value is num) return value.toString();
    return defaultValue;
  }

  static bool parseBool(dynamic value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true' || value == '1';
    if (value is num) return value == 1;
    return defaultValue;
  }

  static int parseInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    if (value is double) return value.toInt();
    return defaultValue;
  }

  static double parseDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? defaultValue;
    if (value is int) return value.toDouble();
    return defaultValue;
  }

  static List<T> parseList<T>(dynamic value, {List<T> defaultValue = const []}) {
    if (value == null) return defaultValue;
    if (value is List) return List<T>.from(value);
    return defaultValue;
  }

  static Map<String, dynamic> parseMap(dynamic value, {Map<String, dynamic> defaultValue = const {}}) {
    if (value == null) return defaultValue;
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return defaultValue;
  }
}
