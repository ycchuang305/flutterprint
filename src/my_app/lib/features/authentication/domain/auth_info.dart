import 'dart:convert' as convert;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_info.freezed.dart';

@freezed
class AuthInfo with _$AuthInfo {
  const AuthInfo._();
  const factory AuthInfo({
    required String accessToken,
  }) = _AuthInfo;

  bool get hasToken => accessToken.isNotEmpty;

  factory AuthInfo.empty() => const AuthInfo(accessToken: '');

  factory AuthInfo.fromJson(Map<String, dynamic> json) {
    if (json['_data'] != null) {
      var accessToken = json['_data']['access_token'] as String;
      return AuthInfo(accessToken: accessToken);
    }
    return AuthInfo.empty();
  }

  factory AuthInfo.fromSecureStorage(String value) {
    var json = convert.jsonDecode(value) as Map<String, dynamic>;
    return AuthInfo(
      accessToken: json['accessToken'] as String,
    );
  }

  String get toSecureStorage {
    final Map<String, dynamic> json = {
      'accessToken': accessToken,
    };
    return convert.jsonEncode(json);
  }
}
