import 'ssl_shared.dart';
import 'package:http/http.dart' as http;

class HttpSSLPning {
  static Future<http.Client> get _theInstance async =>
      _clntInstance ??= await SSLShared.createLEClient();

  static http.Client? _clntInstance;
  static http.Client get client => _clntInstance ?? http.Client();

  static Future<void> init() async {
    _clntInstance = await _theInstance;
  }
}
