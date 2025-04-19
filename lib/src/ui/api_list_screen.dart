// lib/src/ui/api_list_screen.dart
import 'package:flutter/material.dart';
import '../core/log_manager.dart';
import 'api_response_screen.dart';
import 'profiler_timeline_screen.dart';
class ApiListScreen extends StatefulWidget {
  const ApiListScreen({super.key});

  @override
  State<ApiListScreen> createState() => _ApiListScreenState();
}

class _ApiListScreenState extends State<ApiListScreen> {
  String searchQuery = '';
  String? selectedMethod;
  final List<String> methods = ['GET', 'POST', 'PUT', 'DELETE'];
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
      appBar: AppBar(
        title: const Text('API Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.timeline),
            tooltip: 'Profiler',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilerTimelineScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Wrap(
              spacing: 8.0,
              children: methods.map((method) {
                final isSelected = selectedMethod == method;
                return FilterChip(
                  label: Text(method),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedMethod = selected ? method : null;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const Divider(),
          Expanded(
            child: filteredLogs.isEmpty
                ? const Center(child: Text('No logs found.'))
                : ListView.builder(
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