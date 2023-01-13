/// This file contains some helper functions used for string validation.
abstract class StringValidator {
  bool isValid(String value);

  factory StringValidator.regex(String regexSource) =>
      RegexValidator(regexSource: regexSource);

  factory StringValidator.nonEmpty() => NonEmptyStringValidator();

  factory StringValidator.minLength(int minLength) =>
      MinLengthStringValidator(minLength);
}

class RegexValidator implements StringValidator {
  RegexValidator({required this.regexSource});
  final String regexSource;

  @override
  bool isValid(String value) {
    final RegExp regex = RegExp(regexSource);
    return regex.hasMatch(value);
  }
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class MinLengthStringValidator implements StringValidator {
  MinLengthStringValidator(this.minLength);
  final int minLength;

  @override
  bool isValid(String value) {
    return value.length >= minLength;
  }
}
