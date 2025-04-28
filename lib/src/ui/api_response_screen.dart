import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import '../utils/json_pretifier.dart';

class ApiResponseScreen extends StatefulWidget {
  final ApiTestData api;

  const ApiResponseScreen({super.key, required this.api});

  @override
  State<ApiResponseScreen> createState() => _ApiResponseScreenState();
}

class _ApiResponseScreenState extends State<ApiResponseScreen> {
  bool prettifyJson = true;
  String searchKey = '';
  final TextEditingController _searchController = TextEditingController();

  // Function to filter JSON by key
  String filterJsonByKey(String rawResponse, String key) {
    if (rawResponse.isEmpty || key.isEmpty) {
      return prettifyJson ? JsonPrettifier.pretty(rawResponse) : rawResponse;
    }

    try {
      final jsonObject = jsonDecode(rawResponse);
      final matches = <String, dynamic>{};

      // Recursive function to search for key in JSON
      void searchKey(dynamic obj, String key, String currentPath) {
        if (obj is Map) {
          obj.forEach((k, v) {
            final newPath = currentPath.isEmpty ? k : '$currentPath.$k';
            if (k.toLowerCase() == key.toLowerCase()) {
              matches[newPath] = v;
            }
            searchKey(v, key, newPath);
          });
        } else if (obj is List) {
          for (var i = 0; i < obj.length; i++) {
            final newPath = '$currentPath[$i]';
            searchKey(obj[i], key, newPath);
          }
        }
      }

      searchKey(jsonObject, key, '');
      
      if (matches.isEmpty) {
        return 'No values found for key: "$key"';
      }

      final filteredJson = jsonEncode(matches);
      return prettifyJson ? JsonPrettifier.pretty(filteredJson) : filteredJson;
    } catch (e) {
      return 'Error parsing JSON: $e';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rawResponse = widget.api.responseBody ?? '';
    final responseText = filterJsonByKey(rawResponse, searchKey);

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Response'),
        actions: [
          Row(
            children: [
              const Text("Prettify"),
              Switch(
                value: prettifyJson,
                onChanged: (value) => setState(() => prettifyJson = value),
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: responseText));
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
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by Key',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => searchKey = value),
            ),
            const SizedBox(height: 16),
            Text('URL: ${widget.api.url}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Method: ${widget.api.method}'),
            const SizedBox(height: 8),
            Text('Status: ${widget.api.statusCode}'),
            const SizedBox(height: 8),
            Text('Timestamp: ${widget.api.timestamp}'),
            const SizedBox(height: 8),
            const Text('Response Body:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SelectableText(responseText),
          ],
        ),
      ),
    );
  }
}