import 'package:flutter/material.dart';
import 'package:logger/src/utils/utils.dart';
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
  final List<String> methods = ['GET', 'POST', 'PUT', 'DELETE'];
  final logs = NetworkLogManager().logs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredLogs = logs.where((log) {
      final matchesMethod =
          selectedMethod == null || log.method.toUpperCase() == selectedMethod;
      final matchesQuery = searchQuery.isEmpty ||
          log.url.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (log.responseBody
                  ?.toLowerCase()
                  .contains(searchQuery.toLowerCase()) ??
              false);
      return matchesMethod && matchesQuery;
    }).toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Logs'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by URL or Response...',
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: methods.map((method) {
                  final isSelected = selectedMethod == method;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(method),
                      selected: isSelected,
                      selectedColor: Colors.deepPurple,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedMethod = selected ? method : null;
                        });
                      },
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Divider(height: 1),
          Expanded(
            child: filteredLogs.isEmpty
                ? const Center(
                    child:
                        Text('No logs found.', style: TextStyle(fontSize: 16)),
                  )
                : ListView.builder(
                    itemCount: filteredLogs.length,
                    itemBuilder: (context, index) {
                      final log = filteredLogs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ApiResponseScreen(api: log),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple.shade100,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          log.method,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          log.url,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.check_circle,
                                          size: 16,
                                          color: (log.statusCode ?? 0) >= 400
                                              ? Colors.red
                                              : Colors.green),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Status: ${log.statusCode ?? "N/A"}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: (log.statusCode ?? 0) >= 400
                                              ? Colors.red
                                              : theme
                                                  .colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        formatTime(log.timestamp),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
