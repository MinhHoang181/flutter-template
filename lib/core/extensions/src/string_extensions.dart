part of '../extensions.dart';

final RegExp _email = RegExp(
  r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
);
// RegExp _oldEmail = RegExp(r'^[a-zA-Z0-9]+(?:(\+|[\.\-_])[a-zA-Z0-9]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$');

final RegExp _phone = RegExp(r'^(\+)?([ 0-9]){10,16}$');

final RegExp _image = RegExp(r'.(jpeg|jpg|gif|png|bmp|heic|tiff)$');

final RegExp _audio = RegExp(r'.(mp3|wav|wma|amr|ogg)$');

final RegExp _video = RegExp(r'.(mp4|avi|wmv|rmvb|mpg|mpeg|3gp|mkv|mov)$');

final RegExp _txt = RegExp(r'.txt$');

final RegExp _doc = RegExp(r'.(doc|docx)$');

final RegExp _excel = RegExp(r'.(xls|xlsx)$');

final RegExp _powerpoint = RegExp(r'.(ppt|pptx)$');

final RegExp _pdf = RegExp(r'.pdf$');

final RegExp _html = RegExp(r'.html$');

final RegExp _asset = RegExp(r'^assets\/.+$');

final RegExp _svg = RegExp(r'<\s*svg[^>]*>(.*?)<\s*/\s*svg>');

final RegExp _svgFile = RegExp(r'.svg$');

final RegExp _htmlParagraph = RegExp(r'^(<p>)(.+?)(</p>)$');

final RegExp _jsonObject = RegExp(r'^\s*\{.*\}\s*$', dotAll: true);
final RegExp _jsonArray = RegExp(r'^\s*\[.*\]\s*$', dotAll: true);

final RegExp _ipv4Maybe = RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
final RegExp _ipv6 = RegExp(r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$');

final RegExp _surrogatePairsRegExp = RegExp(r'[\uD800-\uDBFF][\uDC00-\uDFFF]');

final RegExp _alpha = RegExp(r'^[a-zA-Z]+$');
final RegExp _alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
final RegExp _numeric = RegExp(r'^-?[0-9]+$');
final RegExp _int = RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
final RegExp _double = RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
final RegExp _hexadecimal = RegExp(r'^[0-9a-fA-F]+$');
final RegExp _hexColor = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
final RegExp _time = RegExp(r'^([01]\d|2[0-3]):[0-5]\d(:[0-5]\d(\.\d{1,3})?)?$');
final RegExp _boolean = RegExp(r'^(true|false|1|0|1\.0|0\.0)$', caseSensitive: false);

final RegExp _base64 = RegExp(r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');

final RegExp _creditCard = RegExp(
  r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
);

final Map<String, RegExp> _uuid = {
  '3': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-3[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$'),
  '4': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  '5': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  'all': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$'),
};

final RegExp _multibyte = RegExp(r'[^\x00-\x7F]');
final RegExp _ascii = RegExp(r'^[\x00-\x7F]+$');

String? _shift(List<String> elements) {
  if (elements.isEmpty) return null;
  return elements.removeAt(0);
}

Map<String, Object> _merge(Map<String, Object>? obj, Map<String, Object> defaults) {
  if (obj == null) {
    return defaults;
  }
  defaults.forEach((key, val) => obj.putIfAbsent(key, () => val));
  return obj;
}

/// String check extension
extension StringCheckExt on String? {
  /// Check if the string is null or empty.
  bool get isEmptyOrNull {
    if (this == null) return true;
    if (this!.isEmpty) return true;
    if (this!.toLowerCase() == 'null') return true;
    return false;
  }

  /// Check if the string is not null and not empty.
  bool get isNotEmptyAndNull => !isEmptyOrNull;

  /// check if the string is an email
  bool get isEmail {
    if (this == null) return false;
    return _email.hasMatch(this!.toLowerCase());
  }

  /// check if the string contains only letters (a-zA-Z).
  bool get isAlpha {
    if (this == null) return false;
    return _alpha.hasMatch(this!.removeDiacritics());
  }

  /// check if the string contains only numbers
  bool get isNumeric {
    if (this == null) return false;
    return _numeric.hasMatch(this!);
  }

  /// check if the string contains only letters and numbers
  bool get isAlphanumeric {
    if (this == null) return false;
    return _alphanumeric.hasMatch(this!);
  }

  /// check if a string is base64 encoded
  bool get isBase64 {
    if (this == null) return false;
    return _base64.hasMatch(this!);
  }

  /// check if the string is an integer
  bool get isInt {
    if (this == null) return false;
    return _int.hasMatch(this!);
  }

  /// check if the string is a double
  bool get isDouble {
    if (this == null) return false;
    return _double.hasMatch(this!);
  }

  /// check if the string is a time
  bool get isTime {
    if (this == null) return false;
    return _time.hasMatch(this!);
  }

  /// check if the string is a boolean
  bool get isBoolean {
    if (this == null) return false;
    return _boolean.hasMatch(this!);
  }

  /// check if the string is a hexadecimal number
  bool get isHexadecimal {
    if (this == null) return false;
    return _hexadecimal.hasMatch(this!);
  }

  /// check if the string is a hexadecimal color
  bool get isHexColor {
    if (this == null) return false;
    return _hexColor.hasMatch(this!);
  }

  /// check if the string is lowercase
  bool get isLowercase {
    if (this == null) return false;
    return this == this!.toLowerCase();
  }

  /// check if the string is uppercase
  bool get isUppercase {
    if (this == null) return false;
    return this == this!.toUpperCase();
  }

  /// Check if the string is a valid image url.
  bool get isImage {
    if (this == null) return false;
    return _image.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid audio url.
  bool get isAudio {
    if (this == null) return false;
    return _audio.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid video url.
  bool get isVideo {
    if (this == null) return false;
    return _video.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid phone number.
  bool get isPhone {
    if (this == null) return false;
    return _phone.hasMatch(this!);
  }

  /// Check if the string is a valid html code
  bool get isHtml {
    if (this == null) return false;
    return _html.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid asset url.
  bool get isAsset {
    if (this == null) return false;
    return _asset.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid text file url.
  bool get isTxt {
    if (this == null) return false;
    return _txt.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid word file url.
  bool get isDoc {
    if (this == null) return false;
    return _doc.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid excel file url.
  bool get isExcel {
    if (this == null) return false;
    return _excel.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid powerpoint file url.
  bool get isPpt {
    if (this == null) return false;
    return _powerpoint.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid pdf file url.
  bool get isPdf {
    if (this == null) return false;
    return _pdf.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid svg code.
  bool get isSvg {
    if (this == null) return false;
    return _svg.hasMatch(this!);
  }

  /// Check if the string is a valid svg file url.
  bool get isSvgFile {
    if (this == null) return false;
    return _svgFile.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid html paragraph.
  bool get isHtmlParagraph {
    if (this == null) return false;
    return _htmlParagraph.hasMatch(this!);
  }

  /// check if the string's length falls in a range
  /// If no max is given then any length above min is ok.
  ///
  /// Note: this function takes into account surrogate pairs.
  bool isLength(int min, [int? max]) {
    final surrogatePairs = _surrogatePairsRegExp.allMatches(this ?? '').toList();
    final int len = (this ?? '').length - surrogatePairs.length;
    return len >= min && (max == null || len <= max);
  }

  /// check if the string's length (in bytes) falls in a range.
  bool isByteLength(int min, [int? max]) {
    return (this ?? '').length >= min && (max == null || (this ?? '').length <= max);
  }

  /// check if the string is a UUID (version 3, 4 or 5).
  bool isUUID([Object? version]) {
    if (this == null) return false;
    if (version == null) {
      version = 'all';
    } else {
      version = version.toString();
    }

    final RegExp? pat = _uuid[version];
    return (pat != null && pat.hasMatch(this!.toUpperCase()));
  }

  /// check if the string is in an array of allowed values
  bool isIn(Object? values) {
    if (this == null) return false;
    if (values == null) return false;
    if (values is String) {
      return values.contains(this!);
    }
    if (values is! Iterable) return false;
    for (final Object? value in values) {
      if (value.toString() == this!) return true;
    }
    return false;
  }

  /// check if the string maybe a JSON object
  ///
  /// Note: this function only checks it maybe a JSON object, it does not check if it's a valid JSON object.
  /// To check if it's a valid JSON, try to decode it.
  bool get maybeJsonObject {
    if (this == null) return false;
    return _jsonObject.hasMatch(this!);
  }

  /// check if the string maybe a JSON array
  ///
  /// Note: this function only checks it maybe a JSON array, it does not check if it's a valid JSON array.
  /// To check if it's a valid JSON, try to decode it.
  bool get maybeJsonArray {
    if (this == null) return false;
    return _jsonArray.hasMatch(this!);
  }

  /// check if the string contains one or more multibyte chars
  bool get isMultibyte {
    if (this == null) return false;
    return _multibyte.hasMatch(this!);
  }

  /// check if the string contains ASCII chars only
  bool get isAscii {
    if (this == null) return false;
    return _ascii.hasMatch(this!);
  }

  /// check if the string contains any surrogate pairs chars
  bool get isSurrogatePair {
    if (this == null) return false;
    return _surrogatePairsRegExp.hasMatch(this!);
  }

  /// check if the string is a credit card
  bool get isCreditCard {
    if (this == null) return false;
    final String sanitized = this!.replaceAll(RegExp('[^0-9]+'), '');
    if (!_creditCard.hasMatch(sanitized)) {
      return false;
    }

    // Luhn algorithm
    int sum = 0;
    String digit;
    bool shouldDouble = false;

    for (int i = sanitized.length - 1; i >= 0; i--) {
      digit = sanitized.substring(i, (i + 1));
      int tmpNum = int.parse(digit);

      if (shouldDouble) {
        tmpNum *= 2;
        if (tmpNum >= 10) {
          sum += ((tmpNum % 10) + 1);
        } else {
          sum += tmpNum;
        }
      } else {
        sum += tmpNum;
      }
      shouldDouble = !shouldDouble;
    }

    return (sum % 10 == 0);
  }

  /// check if the string is a URL
  ///
  /// `options` is a `Map` which defaults to
  /// `{ 'protocols': ['http','https','ftp'], 'require_tld': true,
  /// 'require_protocol': false, 'allow_underscores': false }`.
  bool isURL([Map<String, Object>? options]) {
    if (this == null) return false;
    if (this!.isEmpty) return false;
    if (this!.length > 2083) return false;
    if (this!.indexOf('mailto:') == 0) return false;

    final defaultUrlOptions = {
      'protocols': ['http', 'https', 'ftp'],
      'require_tld': true,
      'require_protocol': false,
      'allow_underscores': false,
    };

    options = _merge(options, defaultUrlOptions);

    // check protocol
    List<String> split = this!.split('://');
    if (split.length > 1) {
      final protocol = _shift(split);
      final protocols = options['protocols']! as List<String>;
      if (!protocols.contains(protocol)) {
        return false;
      }
    } else if (options['require_protocol'] == true) {
      return false;
    }
    String? str = split.join('://');

    // check hash
    split = str.split('#');
    str = _shift(split);
    final hash = split.join('#');
    if (hash.isNotEmpty && RegExp(r'\s').hasMatch(hash)) {
      return false;
    }

    // check query params
    split = str?.split('?') ?? [];
    str = _shift(split);
    final query = split.join('?');
    if (query != '' && RegExp(r'\s').hasMatch(query)) {
      return false;
    }

    // check path
    split = str?.split('/') ?? [];
    str = _shift(split);
    final path = split.join('/');
    if (path != '' && RegExp(r'\s').hasMatch(path)) {
      return false;
    }

    // check auth type urls
    split = str?.split('@') ?? [];
    if (split.length > 1) {
      final auth = _shift(split);
      if (auth != null && auth.contains(':')) {
        // final auth = auth.split(':');
        final parts = auth.split(':');
        final user = _shift(parts);
        if (user == null || !RegExp(r'^\S+$').hasMatch(user)) {
          return false;
        }
        final pass = parts.join(':');
        if (!RegExp(r'^\S*$').hasMatch(pass)) {
          return false;
        }
      }
    }

    // check hostname
    final hostname = split.join('@');
    split = hostname.split(':');
    final host = _shift(split);
    if (split.isNotEmpty) {
      final portStr = split.join(':');
      final port = int.tryParse(portStr, radix: 10);
      if (!RegExp(r'^[0-9]+$').hasMatch(portStr) || port == null || port <= 0 || port > 65535) {
        return false;
      }
    }

    if (host == null || !host.isIP() && !host.isFQDN(options) && host != 'localhost') {
      return false;
    }

    return true;
  }

  /// check if the string is an IP (version 4 or 6)
  ///
  /// `version` is a String or an `int`.
  bool isIP([Object? version]) {
    if (this == null) return false;
    assert(version == null || version is String || version is int, 'version must be a String or an int');
    version = version.toString();
    if (version == 'null') {
      return isIP(4) || isIP(6);
    } else if (version == '4') {
      if (!_ipv4Maybe.hasMatch(this!)) {
        return false;
      }
      final parts = this!.split('.');
      parts.sort((a, b) => int.parse(a) - int.parse(b));
      return int.parse(parts[3]) <= 255;
    }
    return version == '6' && _ipv6.hasMatch(this!);
  }

  /// check if the string is a fully qualified domain name (e.g. domain.com).
  ///
  /// `options` is a `Map` which defaults to `{ 'require_tld': true, 'allow_underscores': false }`.
  bool isFQDN([Map<String, Object>? options]) {
    if (this == null) return false;
    final defaultFqdnOptions = {'require_tld': true, 'allow_underscores': false};

    options = _merge(options, defaultFqdnOptions);
    final parts = this!.split('.');
    if (options['require_tld']! as bool) {
      final tld = parts.removeLast();
      if (parts.isEmpty || !RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
        return false;
      }
    }

    for (final part in parts) {
      if (options['allow_underscores']! as bool) {
        if (part.contains('__')) {
          return false;
        }
      }
      if (!RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
        return false;
      }
      if (part[0] == '-' || part[part.length - 1] == '-' || part.contains('---')) {
        return false;
      }
    }
    return true;
  }
}

final CanonicalizedMap<String, String, Color> _colorNames = CanonicalizedMap<String, String, Color>.from({
  'transparent': Colors.transparent,
  'black': Colors.black,
  'black87': Colors.black87,
  'black54': Colors.black54,
  'black45': Colors.black45,
  'black38': Colors.black38,
  'black26': Colors.black26,
  'black12': Colors.black12,
  'white': Colors.white,
  'white70': Colors.white70,
  'white60': Colors.white60,
  'white54': Colors.white54,
  'white38': Colors.white38,
  'white30': Colors.white30,
  'white24': Colors.white24,
  'white12': Colors.white12,
  'white10': Colors.white10,
  'red': Colors.red,
  'redAccent': Colors.redAccent,
  'pink': Colors.pink,
  'pinkAccent': Colors.pinkAccent,
  'purple': Colors.purple,
  'purpleAccent': Colors.purpleAccent,
  'deepPurple': Colors.deepPurple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'lightBlue': Colors.lightBlue,
  'lightBlueAccent': Colors.lightBlueAccent,
  'cyan': Colors.cyan,
  'cyanAccent': Colors.cyanAccent,
  'teal': Colors.teal,
  'tealAccent': Colors.tealAccent,
  'green': Colors.green,
  'greenAccent': Colors.greenAccent,
  'lightGreen': Colors.lightGreen,
  'lightGreenAccent': Colors.lightGreenAccent,
  'lime': Colors.lime,
  'limeAccent': Colors.limeAccent,
  'yellow': Colors.yellow,
  'yellowAccent': Colors.yellowAccent,
  'amber': Colors.amber,
  'amberAccent': Colors.amberAccent,
  'orange': Colors.orange,
  'orangeAccent': Colors.orangeAccent,
  'deepOrange': Colors.deepOrange,
  'deepOrangeAccent': Colors.deepOrangeAccent,
  'brown': Colors.brown,
  'grey': Colors.grey,
  'blueGrey': Colors.blueGrey,
}, (key) => key.removeAllWhiteSpace().removeDiacritics().toLowerCase());

/// String convert extension
extension StringConvertExt on String? {
  /// Converts string to int or null.
  ///
  /// Example:
  /// ```dart
  /// '2021'.toIntOrNull(); // 2021
  /// '1f'.toIntOrNull(); // null
  /// // From binary (base 2) value.
  /// '1100'.toIntOrNull(radix: 2); // 12
  /// '00011111'.toIntOrNull(radix: 2); // 31
  /// '011111100101'.toIntOrNull(radix: 2); // 2021
  /// // From octal (base 8) value.
  /// '14'.toIntOrNull(radix: 8); // 12
  /// '37'.toIntOrNull(radix: 8); // 31
  /// '3745'.toIntOrNull(radix: 8); // 2021
  /// // From hexadecimal (base 16) value.
  /// 'c'.toIntOrNull(radix: 16); // 12
  /// '1f'.toIntOrNull(radix: 16); // 31
  /// '7e5'.toIntOrNull(radix: 16); // 2021
  /// // From base 35 value.
  /// 'y1'.toIntOrNull(radix: 35); // 1191 == 34 * 35 + 1
  /// 'z1'.toIntOrNull(radix: 35); // null
  /// // From base 36 value.
  /// 'y1'.toIntOrNull(radix: 36); // 1225 == 34 * 36 + 1
  /// 'z1'.toIntOrNull(radix: 36); // 1261 == 35 * 36 + 1
  /// ```
  int? toIntOrNull({int? radix}) {
    if (this == null || this!.isEmpty) return null;

    final int? value = int.tryParse(this!, radix: radix);

    if (value == null && radix == null) {
      if (isDouble) return toDoubleOrNull()?.toInt();
      if (isBoolean) return toBoolOrNull()?.toIntOrNull();
    }

    return value;
  }

  /// Converts string to int or default value.
  ///
  /// Example:
  /// ```dart
  /// '2021'.toInt(); // 2021
  /// '1f'.toInt(); // 0
  /// '1f'.toInt(defaultValue: 1); // 1
  /// // From binary (base 2) value.
  /// '1100'.toInt(radix: 2); // 12
  /// '00011111'.toInt(radix: 2); // 31
  /// '011111100101'.toInt(radix: 2); // 2021
  /// // From octal (base 8) value.
  /// '14'.toInt(radix: 8); // 12
  /// '37'.toInt(radix: 8); // 31
  /// '3745'.toInt(radix: 8); // 2021
  /// // From hexadecimal (base 16) value.
  /// 'c'.toInt(radix: 16); // 12
  /// '1f'.toInt(radix: 16); // 31
  /// '7e5'.toInt(radix: 16); // 2021
  /// // From base 35 value.
  /// 'y1'.toInt(radix: 35); // 1191 == 34 * 35 + 1
  /// 'z1'.toInt(radix: 35); // null
  /// // From base 36 value.
  /// 'y1'.toInt(radix: 36); // 1225 == 34 * 36 + 1
  /// 'z1'.toInt(radix: 36); // 1261 == 35 * 36 + 1
  /// ```
  int toInt({int defaultValue = 0, int? radix}) {
    return toIntOrNull(radix: radix) ?? defaultValue;
  }

  /// Converts string to double or null.
  ///
  /// Example:
  /// ```dart
  /// '3.14'.toDoubleOrNull(); // 3.14
  /// '  3.14 \xA0'.toDoubleOrNull(); // 3.14
  /// '0.'.toDoubleOrNull(); // 0.0
  /// '.0'.toDoubleOrNull(); // 0.0
  /// '-1.e3'.toDoubleOrNull(); // -1000.0
  /// '1234E+7'.toDoubleOrNull(); // 12340000000.0
  /// '+.12e-9'.toDoubleOrNull(); // 1.2e-10
  /// '-NaN'.toDoubleOrNull(); // null
  /// '0xFF'.toDoubleOrNull(); // null
  /// double.infinity.toString().toDoubleOrNull(); // Infinity
  /// ```
  double? toDoubleOrNull() {
    if (this == null || this!.isEmpty) return null;

    final double? value = double.tryParse(this!);

    if (value != null && value.isNaN) return null;
    if (value == null && isBoolean) return toBoolOrNull()?.toDoubleOrNull();

    return value;
  }

  /// Converts string to double or default value.
  ///
  /// Example:
  /// ```dart
  /// '3.14'.toDouble(); // 3.14
  /// '  3.14 \xA0'.toDouble(); // 3.14
  /// '0.'.toDouble(); // 0.0
  /// '.0'.toDouble(); // 0.0
  /// '-1.e3'.toDouble(); // -1000.0
  /// '1234E+7'.toDouble(); // 12340000000.0
  /// '+.12e-9'.toDouble(); // 1.2e-10
  /// '-NaN'.toDouble(); // 0.0
  /// '0xFF'.toDouble(); // 0.0
  /// 'null'.toDouble(defaultValue: 1.0); // 1.0
  /// double.infinity.toString().toDouble(); // Infinity
  /// ```
  double toDouble({double defaultValue = 0.0}) {
    return toDoubleOrNull() ?? defaultValue;
  }

  /// Converts string to bool or null.
  ///
  /// Example:
  /// ```dart
  /// 'true'.toBoolOrNull(); // true
  /// 'false'.toBoolOrNull(); // false
  /// '1'.toBoolOrNull(); // true
  /// '0'.toBoolOrNull(); // false
  /// '1.0'.toBoolOrNull(); // true
  /// '0.0'.toBoolOrNull(); // false
  /// 'null'.toBoolOrNull(); // null
  /// null.toBoolOrNull(); // null
  /// ```
  bool? toBoolOrNull() {
    if (this == null || this!.isEmpty) return null;

    final String value = this!.trim().replaceAll(' ', '').toLowerCase();

    if (value == 'true') return true;
    if (value == 'false') return false;
    if (value == '1') return true;
    if (value == '0') return false;
    if (value == '1.0') return true;
    if (value == '0.0') return false;

    return null;
  }

  /// Converts string to bool or default value.
  ///
  /// Example:
  /// ```dart
  /// 'true'.toBool(); // true
  /// 'false'.toBool(); // false
  /// '1'.toBool(); // true
  /// '0'.toBool(); // false
  /// '1.0'.toBool(); // true
  /// '0.0'.toBool(); // false
  /// 'null'.toBool(); // false
  /// null.toBool(defaultValue: true); // true
  /// ```
  bool toBool({bool defaultValue = false}) {
    return toBoolOrNull() ?? defaultValue;
  }

  /// Converts string to datetime or null.
  ///
  /// Example:
  /// ```dart
  /// '2012-02-27'.toDateTimeOrNull(); // 2012-02-27 00:00:00.000
  /// '2012-02-27 13:27:00'.toDateTimeOrNull(); // 2012-02-27 13:27:00.000
  /// '2012-02-27 13:27:00.123456789z'.toDateTimeOrNull(); // 2012-02-27 13:27:00.123456Z
  /// '2012-02-27 13:27:00,123456789z'.toDateTimeOrNull(); // 2012-02-27 13:27:00.123456Z
  /// '20120227 13:27:00'.toDateTimeOrNull(); // 2012-02-27 13:27:00.000
  /// '20120227T132700'.toDateTimeOrNull(); // 2012-02-27 13:27:00.000
  /// '20120227'.toDateTimeOrNull(); // 2012-02-27 00:00:00.000
  /// '+20120227'.toDateTimeOrNull(); // 2012-02-27 00:00:00.000
  /// '2012-02-27T14Z'.toDateTimeOrNull(); // 2012-02-27 14:00:00.000Z
  /// '2012-02-27T14+00:00'.toDateTimeOrNull(); // 2012-02-27 14:00:00.000Z
  /// '-123450101 00:00:00 Z'.toDateTimeOrNull(); // -12345-01-01 00:00:00.000Z
  /// '2002-02-27T14:00:00-0500'.toDateTimeOrNull(); // 2002-02-27 19:00:00.000Z
  /// '19/07/2024'.toDateTimeOrNull(); // 2024-07-19 00:00:00.000
  /// '1/1/2024'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '2024/1/1'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '1-1-2024'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '2024-1-1'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '1.1.2024'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '2024.1.1'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '1/1/2024 1:1:1'.toDateTimeOrNull(); // 2024-01-01 01:01:01.000
  /// '2024/1/1 1:1:1'.toDateTimeOrNull(); // 2024-01-01 01:01:01.000
  /// '01/01/2024 01:01:01'.toDateTimeOrNull(); // 2024-01-01 01:01:01.000
  /// '2024/01/01 01:01:01'.toDateTimeOrNull(); // 2024-01-01 01:01:01.000
  /// '1-1-2024 1:1'.toDateTimeOrNull(); // 2024-01-01 01:01:00.000
  /// '2024-1-1 1:1'.toDateTimeOrNull(); // 2024-01-01 01:01:00.000
  /// '18:30:40'.toDateTimeOrNull(); // 0001-01-01 18:30:40.000
  /// '18:30'.toDateTimeOrNull(); // 0001-01-01 18:30:00.000
  /// ```
  DateTime? toDateTimeOrNull({bool isUtc = false}) {
    String? str = this;
    if (str == null || str.isEmpty) return null;

    DateTime? dateTime = DateTime.tryParse(str);

    // if datetime null or year is more than 4 digits and isInt or isDouble
    // then convert to int and try to convert to DateTime
    if ((dateTime == null || dateTime.year.toString().length > 4) && (isInt || isDouble)) {
      return toIntOrNull()?.toDateTimeOrNull(isUtc: isUtc);
    }

    if (dateTime != null) return dateTime;

    // split date and time
    final int indexSplit = str.indexOf(RegExp('(T| )'));

    String? dateStr;
    String? timeStr;

    // if has date and time
    if (indexSplit >= 0) {
      dateStr = str.substring(0, indexSplit);
      timeStr = str.substring(indexSplit + 1, str.length);
    }
    // if only date or time
    else {
      if (str.isTime) {
        timeStr = str;
      } else {
        dateStr = str;
      }
    }

    // handle date format
    dateStr = dateStr?.replaceAll(RegExp(r'\s+'), '').replaceAll(RegExp('[^0-9+-]'), '-');

    final List<String> dateParts = dateStr?.split('-') ?? [];
    dateParts.removeWhere((e) => e.isEmpty);

    if (dateParts.length > 2) {
      int? year = dateParts.elementAtOrNull(0).toIntOrNull();
      final int? month = dateParts.elementAtOrNull(1).toIntOrNull();
      int? day = dateParts.elementAtOrNull(2).toIntOrNull();

      if (year != null && day != null && year < day) {
        final int temp = year;
        year = day;
        day = temp;
      }

      dateStr = <String>[
        year?.toString().padLeft(4, '0') ?? '0001',
        month?.toString().padLeft(2, '0') ?? '01',
        day?.toString().padLeft(2, '0') ?? '01',
      ].join('-');
    }

    // handle time format
    timeStr = timeStr?.replaceAll(RegExp(r'\s+'), '').replaceAll(RegExp('[^zZ0-9.,+-]'), ':');

    final List<String> timeParts = timeStr?.split(':') ?? [];

    if (timeParts.length > 1) {
      final String? hour = timeParts.elementAtOrNull(0);
      final String? minute = timeParts.elementAtOrNull(1);
      final String? second = timeParts.elementAtOrNull(2);

      timeStr = <String>[
        hour?.padLeft(2, '0') ?? '00',
        minute?.padLeft(2, '0') ?? '00',
        second?.padLeft(2, '0') ?? '00',
      ].join(':');
    }

    if (dateParts.isEmpty && timeParts.isEmpty) return null;

    str = <String>[dateStr ?? '0000-00-00', timeStr ?? '00:00:00'].join(' ');

    // print('full: $this, date: $dateStr, time: $timeStr, replace: $str');

    dateTime = DateTime.tryParse(str);

    return dateTime;
  }

  /// Converts string to DateTime or default value.
  ///
  /// Example:
  /// ```dart
  /// '2012-02-27'.toDateTime(); // 2012-02-27 00:00:00.000
  /// '2012-02-27 13:27:00'.toDateTime(); // 2012-02-27 13:27:00.000
  /// '2012-02-27 13:27:00.123456789z'.toDateTime(); // 2012-02-27 13:27:00.123456Z
  /// '2012-02-27 13:27:00,123456789z'.toDateTime(); // 2012-02-27 13:27:00.123456Z
  /// '20120227 13:27:00'.toDateTime(); // 2012-02-27 13:27:00.000
  /// '20120227T132700'.toDateTime(); // 2012-02-27 13:27:00.000
  /// '20120227'.toDateTime(); // 2012-02-27 00:00:00.000
  /// '+20120227'.toDateTime(); // 2012-02-27 00:00:00.000
  /// '2012-02-27T14Z'.toDateTime(); // 2012-02-27 14:00:00.000
  /// '2012-02-27T14+00:00'.toDateTime(); // 2012-02-27 14:00:00.000Z
  /// '-123450101 00:00:00 Z'.toDateTime(); // -12345-01-01 00:00:00.000Z
  /// '2002-02-27T14:00:00-0500'.toDateTime(); // 2002-02-27 19:00:00.000Z
  /// '19/07/2024'.toDateTime(); // 2024-07-19 00:00:00.000
  /// '1/1/2024'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '2024/1/1'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '1-1-2024'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '2024-1-1'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '1.1.2024'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '2024.1.1'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '1/1/2024 1:1:1'.toDateTime(); // 2024-01-01 01:01:01.000
  /// '2024/1/1 1:1:1'.toDateTime(); // 2024-01-01 01:01:01.000
  /// '01/01/2024 01:01:01'.toDateTime(); // 2024-01-01 01:01:01.000
  /// '2024/01/01 01:01:01'.toDateTime(); // 2024-01-01 01:01:01.000
  /// '1-1-2024 1:1'.toDateTime(); // 2024-01-01 01:01:00.000
  /// '2024-1-1 1:1'.toDateTime(); // 2024-01-01 01:01:00.000
  /// '18:30:40'.toDateTime(); // 0001-01-01 18:30:40.000
  /// '18:30'.toDateTime(); // 0001-01-01 18:30:00.000
  /// ```
  DateTime toDateTime({required DateTime defaultValue, bool isUtc = false}) {
    return toDateTimeOrNull(isUtc: isUtc) ?? defaultValue;
  }

  /// Converts string to valid url.
  String toUrl(String host, {String defaultValue = ''}) {
    String url;
    if (isEmptyOrNull) return defaultValue;

    if (isURL()) {
      url = this!;
    } else if (this!.startsWith('/')) {
      url = '$host$this';
    } else {
      url = '$host/$this';
    }
    url.replaceAll('//', '/');
    return url;
  }

  /// Convert string to Color or null.
  ///
  /// ```dart
  /// '#FFF'.toColorOrNull(); // Color(0xFFFFFFFF)
  /// '#123456'.toColorOrNull(); // Color(0xFF123456)
  /// 'rgb(255, 255, 255)'.toColorOrNull(); // Color.fromRGBO(255, 255, 255, 1)
  /// 'rgba(255, 255, 255, 0.5)'.toColorOrNull(); // Color.fromRGBO(255, 255, 255, 0.5)
  /// 'hsl(0, 100%, 50%)'.toColorOrNull(); // Color(0xFFFF0000)
  /// 'hsla(0, 100%, 50%, 0.5)'.toColorOrNull(); // Color(0x7fff0000)
  /// 'transparent'.toColorOrNull(); // Colors.transparent
  /// 'red'.toColorOrNull(); // Colors.red
  /// ```
  Color? toColorOrNull() {
    String? colorString = this;

    if (colorString == null || colorString.isEmpty) return null;

    if (colorString.startsWith('#')) {
      if (colorString.length == 4) {
        colorString =
            '#${colorString[1]}${colorString[1]}${colorString[2]}${colorString[2]}${colorString[3]}${colorString[3]}';
      }
      if (colorString.length == 7) {
        return Color(int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
      } else if (colorString.length == 9) {
        final int colorValue = int.parse(colorString.substring(1), radix: 16);
        final int alpha = (colorValue & 0xFF);
        final int rgb = (colorValue >> 8);
        return Color((alpha << 24) + rgb);
      }
    } else if (colorString.startsWith('rgb')) {
      final match = RegExp(
        r'rgb(a?)\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})(,\s*(0|1|0?\.\d+))?\)',
      ).firstMatch(colorString);
      if (match != null) {
        final int r = int.parse(match.group(2)!);
        final int g = int.parse(match.group(3)!);
        final int b = int.parse(match.group(4)!);
        if (match.group(1) == 'a') {
          final double a = double.parse(match.group(6)!);
          return Color.fromRGBO(r, g, b, a);
        } else {
          return Color.fromRGBO(r, g, b, 1.0);
        }
      }
    } else if (colorString.startsWith('hsl')) {
      final match = RegExp(
        r'hsl(a?)\((\d{1,3}),\s*(\d{1,3})%,\s*(\d{1,3})%(,\s*(0|1|0?\.\d+))?\)',
      ).firstMatch(colorString);
      if (match != null) {
        final int h = int.parse(match.group(2)!);
        final double s = int.parse(match.group(3)!) / 100;
        final double l = int.parse(match.group(4)!) / 100;
        if (match.group(1) == 'a') {
          final double a = double.parse(match.group(6)!);
          return hslToColor(h, s, l, a);
        } else {
          return hslToColor(h, s, l, 1.0);
        }
      }
    } else if (_colorNames.containsKey(colorString)) {
      return _colorNames[colorString]!;
    }
    return null;
  }

  /// Convert string to Color or default value.
  ///
  /// ```dart
  /// '#FFF'.toColor(); // Color(0xFFFFFFFF)
  /// '#123456'.toColor(); // Color(0xFF123456)
  /// 'rgb(255, 255, 255)'.toColor(); // Color.fromRGBO(255, 255, 255, 1)
  /// 'rgba(255, 255, 255, 0.5)'.toColor(); // Color.fromRGBO(255, 255, 255, 0.5)
  /// 'hsl(0, 100%, 50%)'.toColor(); // Color(0xFFFF0000)
  /// 'hsla(0, 100%, 50%, 0.5)'.toColor(); // Color(0x7fff0000)
  /// 'transparent'.toColor(); // Colors.transparent
  /// 'red'.toColor(); // Colors.red
  ///
  /// ''.toColor(defaultValue: Colors.red); // Colors.red
  /// null.toColor(); // Colors.transparent
  /// ```
  ///
  /// * `defaultColor`: return this color if the hex code is invalid.
  Color toColor({Color defaultValue = Colors.transparent}) {
    return toColorOrNull() ?? defaultValue;
  }
}

/// Size string extension.
extension SizeStringExt on String? {
  /// Get the basic size of the text.
  ///
  /// ```dart
  /// Size size = 'Hello'.getSize(style: TextStyle(fontSize: 14));
  /// ```
  /// * `style`: thuộc tính văn bản như fontSize, fontWeight, ...
  /// * `minWidth`: chiều dài 1 dòng tối thiểu của văn bản
  /// * `maxWidth`: chiều dài 1 dòng tối đa của văn bản
  /// * `textAlign`: canh lề văn bản theo chiều ngang
  /// * `textScaleFactor`: Tỉ lệ scale kích thước chữ. Ví dụ nếu hệ số tỷ lệ văn bản là 1,5, văn bản sẽ lớn hơn 50% so với kích thước phông chữ được chỉ định.
  /// * `maxLines`: số lượng dòng tối đa của văn bản
  /// * `ellipsis`: kí tự mặc định … , dùng để hiển thị văn bản vượt quá giới hạn tối đa nếu có thiết lập [TextOverflow.ellipsis]
  /// * `locale`: ngôn ngữ được sử dụng để chọn các nét tượng trưng theo vùng
  /// * `strutStyle`: thuộc tính chiều cao tối thiểu cho tổng thể các dòng văn bản, tham khảo ở https://api.flutter.dev/flutter/painting/StrutStyle-class.html
  /// * `textDirection`: hướng xuất văn bản theo chiều từ trái sang phải hoặc ngược lại (Arabic, Hebrew)
  Size getSize({
    required TextStyle style,
    double minWidth = 0,
    double maxWidth = double.infinity,
    TextAlign textAlign = TextAlign.start,
    TextScaler textScaler = TextScaler.noScaling,
    int? maxLines,
    String? ellipsis,
    Locale? locale,
    StrutStyle? strutStyle,
    ui.TextDirection? textDirection = ui.TextDirection.ltr,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textAlign: textAlign,
      textScaler: textScaler,
      maxLines: maxLines,
      ellipsis: ellipsis,
      locale: locale,
      strutStyle: strutStyle,
      textDirection: textDirection,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.size;
  }
}

/// Nullable string format extension
extension NullableStringFormatExt on String? {
  /// Validate the string and return the default value if it is null or empty.
  String validate({String defaultValue = ''}) {
    if (this == null) return defaultValue;
    if (this!.isEmpty) return defaultValue;

    return this!;
  }
}

/// String format extension
extension StringFormatExt on String {
  /// Remove all white spaces at the beginning and end of the string.
  /// Remove all duplicate white spaces in the string.
  ///
  /// Example:
  /// ```dart
  /// '     He   llo wor   ld'.removeDuplicateWhiteSpace(); // 'He llo wor ld'
  /// ```
  String removeDuplicateWhiteSpace() {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Remove all white spaces in the string.
  ///
  /// Example:
  /// ```dart
  /// '     He   llo wor   ld'.removeAllWhiteSpace(); // 'Helloworld'
  /// ```
  String removeAllWhiteSpace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Replace all new line characters with '\n'.
  ///
  /// Example:
  /// ```dart
  /// 'Hello\nWorld'.replaceNewLine();
  /// // Hello
  /// // World
  /// 'Hello\r\nWorld'.replaceNewLine();
  /// // Hello
  /// // World
  /// r'Hello\r\nWorld'.replaceNewLine();
  /// // Hello\r\nWorld
  /// ```
  String replaceNewLine() {
    return replaceAll(RegExp(r'\n|\r\n'), '\n');
  }

  /// Capitalize the first letter of the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.capitalizeFirstLetter(); // 'Hello world'
  /// 'hello World'.capitalizeFirstLetter(); // 'Hello World
  /// 'h'.capitalizeFirstLetter(); // 'H'
  /// ```
  String capitalizeFirstLetter() {
    return isEmptyOrNull ? '' : substring(0, 1).toUpperCase() + substring(1);
  }

  /// Capitalize the first letter of each sentence in the string.
  /// A sentence is defined as a string that ends with '.', '!', or '?'.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.capitalizeFirstLetterOfSentence(); // 'Hello world'
  /// 'hello World'.capitalizeFirstLetterOfSentence(); // 'Hello World'
  /// 'h'.capitalizeFirstLetterOfSentence(); // 'H'
  /// 'trường đại học Công nghệ thông tin. hòa Bình, thủ đô Hà Nội.'.capitalizeFirstLetterOfSentence();
  /// // 'Trường đại học Công nghệ thông tin. Hòa Bình, thủ đô Hà Nội.'
  /// 'hello. world. hello. world'.capitalizeFirstLetterOfSentence(); // 'Hello. World. Hello. World'
  /// '  đây là câu đầu.   đây là câu tiếp theo. và đây là câu cuối.  '.capitalizeFirstLetterOfSentence();
  /// // '  Đây là câu đầu.   Đây là câu tiếp theo. Và đây là câu cuối.  '
  /// ```
  String capitalizeFirstLetterOfSentence() {
    final RegExp sentenceRegExp = RegExp('[.!?]');

    return splitMapJoin(
      sentenceRegExp,
      onMatch: (match) => match.group(0) ?? '',
      onNonMatch: (nonMatch) {
        if (nonMatch.isEmpty) {
          return nonMatch;
        }

        final int index = nonMatch.removeDiacritics().indexOf(RegExp('[a-zA-Z]'));

        if (index >= 0) {
          return nonMatch.replaceRange(index, index + 1, nonMatch[index].toUpperCase());
        }

        return nonMatch;
      },
    );
  }

  /// Capitalize the first letter of each word in the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.capitalizeEachWord(); // 'Hello World'
  /// 'hello World'.capitalizeEachWord(); // 'Hello World'
  /// 'h'.capitalizeEachWord(); // 'H'
  /// ```
  String capitalizeEachWord() {
    return split(' ')
        .map((word) {
          if (word.isEmpty) {
            return word;
          }
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  /// Replace all diacritics in the string.
  ///
  /// Example:
  /// ```dart
  /// 'Việt Nam'.removeDiacritics(); // 'Viet Nam'
  /// ```
  String removeDiacritics() {
    return diacritic.removeDiacritics(this);
  }
}
