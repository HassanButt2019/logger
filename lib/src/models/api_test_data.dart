class ApiTestData {
  final String method;
  final String url;
  final int? statusCode;
  final Map<String, String>? headers;
  final String? requestBody;
  final String? responseBody;
  final DateTime timestamp;
  final int? durationMs; // Duration in milliseconds

  ApiTestData({
    required this.method,
    required this.url,
    this.statusCode,
    this.headers,
    this.requestBody,
    this.responseBody,
    DateTime? timestamp,
    this.durationMs,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'method': method,
        'url': url,
        'statusCode': statusCode,
        'headers': headers,
        'requestBody': requestBody,
        'responseBody': responseBody,
        'timestamp': timestamp.toIso8601String(),
        'durationMs': durationMs,
      };

  factory ApiTestData.fromJson(Map<String, dynamic> json) => ApiTestData(
        method: json['method'],
        url: json['url'],
        statusCode: json['statusCode'],
        headers: (json['headers'] as Map?)?.cast<String, String>(),
        requestBody: json['requestBody'],
        responseBody: json['responseBody'],
        timestamp: DateTime.parse(json['timestamp']),
        durationMs: json['durationMs'],
      );
}
