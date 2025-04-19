// lib/src/ui/api_response_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/json_pretifier.dart';
import '../models/api_test_data.dart'; // lib/src/ui/api_response_screen.dart

class ApiResponseScreen extends StatefulWidget {
  final ApiTestData api;

  const ApiResponseScreen({super.key, required this.api});

  @override
  State<ApiResponseScreen> createState() => _ApiResponseScreenState();
}

class _ApiResponseScreenState extends State<ApiResponseScreen> {
  bool prettifyJson = true;

  @override
  Widget build(BuildContext context) {
    final rawResponse = widget.api.responseBody ?? '';

    // This value will change every time `prettifyJson` changes
    final responseText =
        prettifyJson ? JsonPrettifier.pretty(rawResponse) : rawResponse;

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Response'),
        actions: [
          Row(
            children: [
              const Text("Prettify"),
              Switch(
                value: prettifyJson,
                onChanged: (value) {
                  setState(() {
                    prettifyJson = value;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                tooltip: 'Copy Response',
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: responseText));
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('URL: ${widget.api.url}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Method: ${widget.api.method}'),
            const SizedBox(height: 8),
            Text('Status: ${widget.api.statusCode}'),
            const SizedBox(height: 8),
            Text('Timestamp: ${widget.api.timestamp}'),
            const SizedBox(height: 8),
            const Text('Request Body:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SelectableText(responseText),
            const SizedBox(height: 16),
            const Text('Response Body:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SelectableText(responseText),
          ],
        ),
      ),
    );
  }
}
