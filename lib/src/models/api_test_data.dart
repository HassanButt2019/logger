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
