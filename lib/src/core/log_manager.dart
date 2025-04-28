import '../models/api_test_data.dart';

class NetworkLogManager {
  static final NetworkLogManager _instance = NetworkLogManager._internal();

  final List<ApiTestData> _logs = [];

  factory NetworkLogManager() => _instance;

  NetworkLogManager._internal();

  void log(ApiTestData data) {
    _logs.add(data);
  }

  List<ApiTestData> get logs => List.unmodifiable(_logs);
  void clear() {
    _logs.clear();
  }
}


class ApiTestData {
  final String method;
  final String url;
  final int? statusCode;
  final Map<String, String>? headers;
  final String? requestBody;
  final String? responseBody;
  final DateTime timestamp;
  

  ApiTestData({
    required this.method,
    required this.url,
    this.statusCode,
    this.headers,
    this.requestBody,
    this.responseBody,
  }) : timestamp = DateTime.now();
}