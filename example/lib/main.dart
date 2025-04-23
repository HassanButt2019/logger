import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netword_logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logger Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _makeGetCall() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");

    final response = await http.get(url);

    logApiResponse(
      method: "GET",
      url: url.toString(),
      statusCode: response.statusCode,
      headers: {},
      responseBody: response.body,
    );
  }

  Future<void> _makePostCall() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "title": "Logger Test",
      "body": "Testing POST request",
      "userId": 101,
    });

    final response = await http.post(url, headers: headers, body: body);

    logApiResponse(
      method: "POST",
      url: url.toString(),
      statusCode: response.statusCode,
      headers: headers,
      responseBody: response.body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text('Network Logger Test')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _makeGetCall,
                  child: const Text("Call GET API"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _makePostCall,
                  child: const Text("Call POST API"),
                ),
              ],
            ),
          ),
        ),
        const LoggerInjector(),
      ],
    );
  }
}

class LoggerInjector extends StatefulWidget {
  const LoggerInjector({super.key});

  @override
  State<LoggerInjector> createState() => _LoggerInjectorState();
}

class _LoggerInjectorState extends State<LoggerInjector> {
  bool _inserted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay = Navigator.of(context).overlay;
      if (overlay != null && !_inserted) {
        overlay.insert(
          OverlayEntry(
            builder: (_) => const NetworkLoggerHost(),
          ),
        );
        _inserted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
