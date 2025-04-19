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
}
