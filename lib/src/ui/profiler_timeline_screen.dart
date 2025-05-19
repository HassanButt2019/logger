import 'package:flutter/material.dart';
import '../core/log_manager.dart';
import 'api_response_screen.dart';

class ProfilerTimelineScreen extends StatelessWidget {
  const ProfilerTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = NetworkLogManager().logs;
    final maxDuration = 10;

    return Scaffold(
      appBar: AppBar(title: const Text('API Timeline Profiler')),
      body: logs.isEmpty
          ? const Center(child: Text('No logs available'))
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                final duration =  0;
                final barWidth = (maxDuration > 0) ? (duration / maxDuration * 200) : 0.0;

                return ListTile(
                  title: Text('${log.method} - ${log.url}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Duration: ${duration}ms • ${log.timestamp}'),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            height: 8,
                            width: barWidth,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          Text('${duration} ms'),
                        ],
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ApiResponseScreen(api: log)),
                  ),
                );
              },
            ),
    );
  }
}
