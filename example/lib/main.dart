import 'package:flutter/material.dart';
import 'package:netword_logger/netword_logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: // Example usage in app
          NetwordLogger(
        apiList: [
          ApiTestData(
            method: 'GET',
            url: 'https://jsonplaceholder.typicode.com/posts/1',
          ),
          ApiTestData(
            method: 'POST',
            url: 'https://jsonplaceholder.typicode.com/posts',
            body: '{"title":"test"}',
          ),
        ],
      ),
    );
  }
}
