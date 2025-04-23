// lib/src/ui/api_response_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/json_pretifier.dart';
import '../models/api_test_data.dart';// lib/src/ui/api_response_screen.dart
// lib/src/ui/api_response_screen.dart

class ApiResponseScreen extends StatefulWidget {
  final ApiTestData api;

  const ApiResponseScreen({super.key, required this.api});

  @override
  State<ApiResponseScreen> createState() => _ApiResponseScreenState();
}

class _ApiResponseScreenState extends State<ApiResponseScreen> {
  bool prettifyJson = true;
  final TextEditingController _controller = TextEditingController();
  String searchKey = '';  bool _showSearch = false;

  @override
Widget build(BuildContext context) {
  final rawResponse = widget.api.responseBody ?? '';
  String responseText = '';
  dynamic decodedJson;

  if (searchKey.trim().isNotEmpty) {
    try {
      decodedJson = JsonPrettifier.decodeJson(rawResponse);
      final result = _searchInJson(decodedJson, searchKey.trim());
      responseText = result ?? 'Key not found in JSON.';
    } catch (e) {
      responseText = 'Invalid JSON response.';
    }
  } else {
    responseText = prettifyJson
        ? JsonPrettifier.pretty(rawResponse)
        : rawResponse;
  }

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
        ),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       
          Text('URL: ${widget.api.url}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Method: ${widget.api.method}'),
          const SizedBox(height: 8),
          Text('Status: ${widget.api.statusCode}'),
          const SizedBox(height: 8),
          Text('Timestamp: ${widget.api.timestamp}'),
          const SizedBox(height: 16),
            controller: _controller,
        Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text('Filter Key:', style: TextStyle(fontWeight: FontWeight.bold)),
    IconButton(
      icon: Icon(_showSearch ? Icons.close : Icons.search),
      onPressed: () {
        setState(() {
          _showSearch = !_showSearch;
          if (!_showSearch) {
            _controller.clear();
            searchKey = '';
          }
        });
      },
    ),
  ],
),
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  transitionBuilder: (Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, -0.2),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(opacity: animation, child: child),
    );
  },
  child: _showSearch
      ? Column(
          key: const ValueKey('searchField'),
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter key to search...',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onChanged: (value) {
                setState(() {
                  searchKey = value;
                });
              },
            ),
            const SizedBox(height: 16),
          ],
        )
      : const SizedBox.shrink(key: ValueKey('empty')),
),

          const SizedBox(height: 16),
          const Text('Response Body:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SelectableText(responseText),
        ],
      ),
    ),
  );
}



  /// 🔁 Recursively search for a key in a nested JSON
  String? _searchInJson(dynamic json, String key) {
    if (json is Map<String, dynamic>) {
      for (var k in json.keys) {
        if (k.toLowerCase().contains(key.toLowerCase())) {
          return '$k: ${JsonPrettifier.pretty(json[k].toString())}';
        } else {
          final result = _searchInJson(json[k], key);
          if (result != null) return result;
        }
      }
    } else if (json is List) {
      for (var item in json) {
        final result = _searchInJson(item, key);
        if (result != null) return result;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
