import 'package:six_g_app/export.dart';

class FormValidationHelper {
  String? require(String? value, [String? fieldName]) {
    if (value?.isEmpty ?? true) {
      return (fieldName ?? 'field'.localize()) +
          ' ' +
          ('is_required'.localize());
    }
    return null;
  }

  String? isEmailRequire(String? value, [String? fieldName]) {
    return require(value, fieldName) ?? isEmail(value);
  }

  String? isEmail(String? value) {
    if (value?.isNotEmpty ?? false) {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
        return 'pls_enter_avalid_email_address'.localize();
      }
    }
    return null;
  }

  String? isNumberRequire(String? value, [String? fieldName]) {
    return require(value, fieldName) ?? isNumber(value);
  }

  String? isNumber(String? value) {
    if (value?.isNotEmpty ?? false) {
      if (int.tryParse(value!) == null) {
        return 'pls_enter_avalid_number';
      }
    }
    return null;
  }

  String? isNoSpecialCharsRequire(String? value, [String? fieldName]) {
    return require(value, fieldName) ?? isNoSpecialChars(value);
  }

  String? isNoSpecialChars(String? value) {
    if (value?.isNotEmpty ?? false) {
      if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value!)) {
        return 'no_special_characters_allowed'.localize();
      }
    }
    return null;
  }

  String? isUrlRequire(String? value, [String? fieldName]) {
    return require(value, fieldName) ?? isUrl(value);
  }

  String? isUrl(String? value) {
    if (value?.isNotEmpty ?? false) {
      if (!_isUrl(value!)) {
        return 'pls_enter_avalid_url'.localize();
      }
    }
    return null;
  }

  String? isNativeUrlRequire(String? value, [String? fieldName]) {
    return require(value, fieldName) ?? isNativeUrl(value);
  }

  String? isNativeUrl(String? value) {
    if (value?.isNotEmpty ?? false) {
      if (!Uri.parse(value!).isAbsolute) {
        return 'pls_enter_avalid_url'.localize();
      }
    }
    return null;
  }

  bool _isUrl(String value) {
    // Regular expression pattern to match URLs without http:// or https://
    RegExp regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})+$',
      caseSensitive: false,
      multiLine: false,
    );
    return regExp.hasMatch(value);
  }
}
