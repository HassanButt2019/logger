import 'dart:async';
import '../models/api_test_data.dart';
import 'log_manager.dart';

/// A controller that manages real-time log updates via stream.
class LoggerController {
  final _controller = StreamController<List<ApiTestData>>.broadcast();

  /// Logs and broadcasts updates to any listeners (e.g., UI)
  void log(ApiTestData data) {
    NetworkLogManager().log(data);
    _controller.add(NetworkLogManager().logs);
  }

  /// Stream of logs for real-time updates in UI
  Stream<List<ApiTestData>> get logsStream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}

/// Global function to log a network call without needing to instantiate LoggerController
void logApiResponse({
  required String method,
  required String url,
  int? statusCode,
  Map<String, String>? headers,
  String? responseBody,
  String? requestBody,
}) {
  final log = ApiTestData(
    method: method,
    url: url,
    statusCode: statusCode,
    headers: headers,
    responseBody: responseBody,
    requestBody: requestBody,
  );
  NetworkLogManager().log(log);
}
