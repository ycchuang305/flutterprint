import 'package:{{project_name.snakeCase()}}/constant/regex_pattern.dart';
import 'package:{{project_name.snakeCase()}}/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    '[StringValidator]:',
    () {
      test(
        'IP address with port number regex validator',
        () {
          final ipAddressHostValidator =
              StringValidator.regex(RegexPattern.ipAddressPort);
          expect(ipAddressHostValidator.isValid('192.168.0.233'), false);
          expect(ipAddressHostValidator.isValid('192.168.0.233:8000'), true);
        },
      );

      test(
        'Non empty validator',
        () {
          final nonEmptyValidator = StringValidator.nonEmpty();
          expect(nonEmptyValidator.isValid(''), false);
          expect(nonEmptyValidator.isValid('123'), true);
        },
      );

      test(
        'Minimum length validator',
        () {
          final minLengthValidator = StringValidator.minLength(8);
          expect(minLengthValidator.isValid('123'), false);
          expect(minLengthValidator.isValid('12345678'), true);
        },
      );
    },
  );
}
