import 'dart:async';
import '../models/api_test_data.dart';
import 'log_manager.dart';

class LoggerController {
  final _controller = StreamController<List<ApiTestData>>.broadcast();

  void log(ApiTestData data) {
    NetworkLogManager().log(data);
    _controller.add(NetworkLogManager().logs);
  }

  Stream<List<ApiTestData>> get logsStream => _controller.stream;
}
