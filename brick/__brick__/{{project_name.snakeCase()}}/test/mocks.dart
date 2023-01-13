import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:{{project_name.snakeCase()}}/features/authentication/authentication.dart';
import 'package:{{project_name.snakeCase()}}/services/local_storage/data/secure_storage_repository.dart';
import 'package:mocktail/mocktail.dart';

// A generic Listener class, used to keep track of when a provider notifies its listeners
class Listener<T> extends Mock {
  void call(T? previous, T next);
}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSecureRepository extends Mock implements SecureRepository {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}
