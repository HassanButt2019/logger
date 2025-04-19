import 'package:flutter/material.dart';
import '../../src/core/log_manager.dart';
import 'api_response_screen.dart';

class ApiListScreen extends StatelessWidget {
  const ApiListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = NetworkLogManager().logs;

    return Scaffold(
      appBar: AppBar(title: const Text('API Logs')),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (_, index) {
          final api = logs[index];
          return ListTile(
            title: Text('${api.method} - ${api.url}'),
            subtitle: Text('Status: ${api.statusCode ?? 'N/A'}'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ApiResponseScreen(api: api),
              ),
            ),
          );
        },
      ),
    );
  }
}
