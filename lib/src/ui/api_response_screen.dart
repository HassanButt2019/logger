import 'package:flutter/material.dart';
import '../../src/models/api_test_data.dart';

class ApiResponseScreen extends StatelessWidget {
  final ApiTestData api;

  const ApiResponseScreen({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Response')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SelectableText(
          '''
Method: ${api.method}
URL: ${api.url}
Status Code: ${api.statusCode ?? 'N/A'}

Headers:
${api.headers?.entries.map((e) => '${e.key}: ${e.value}').join('\n') ?? 'N/A'}

Request Body:
${api.requestBody ?? 'N/A'}

Response Body:
${api.responseBody ?? 'N/A'}
''',
        ),
      ),
    );
  }
}
