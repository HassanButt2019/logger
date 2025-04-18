import 'dart:convert';
import 'dart:io';
import 'package:logger/src/core/log_manager.dart';


class LogPersistenceService {
  Future<void> saveLogs(List<ApiTestData> logs) async {
    final file = File('api_logs.json');
    final data = logs.map((e) => {
      'method': e.method,
      'url': e.url,
      'statusCode': e.statusCode,
      'requestBody': e.requestBody,
      'responseBody': e.responseBody,
      'timestamp': e.timestamp.toIso8601String(),
    }).toList();

    await file.writeAsString(jsonEncode(data));
  }
}
