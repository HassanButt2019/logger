// lib/src/ui/api_list_screen.dart
import 'package:flutter/material.dart';
import '../core/log_manager.dart';
import 'api_response_screen.dart';
class ApiListScreen extends StatefulWidget {
  const ApiListScreen({super.key});

  @override
  State<ApiListScreen> createState() => _ApiListScreenState();
}

class _ApiListScreenState extends State<ApiListScreen> {
  String searchQuery = '';
  String? selectedMethod;
  final logs = NetworkLogManager().logs;

  @override
  Widget build(BuildContext context) {
    final filteredLogs = logs.where((log) {
      final matchesMethod = selectedMethod == null || log.method.toUpperCase() == selectedMethod;
      final matchesQuery = searchQuery.isEmpty ||
          log.url.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (log.responseBody?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false);
      return matchesMethod && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('API Logs')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Search', border: OutlineInputBorder()),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Filter by Method'),
              value: selectedMethod,
              items: ['GET', 'POST', 'PUT', 'DELETE']
                  .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                  .toList(),
              onChanged: (value) => setState(() => selectedMethod = value),
              isExpanded: true,
              hint: const Text('Select Method'),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLogs.length,
              itemBuilder: (context, index) {
                final log = filteredLogs[index];
                return ListTile(
                  title: Text('${log.method} - ${log.url}'),
                  subtitle: Text('Status: ${log.statusCode} • Time: ${log.timestamp}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ApiResponseScreen(api: log),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}