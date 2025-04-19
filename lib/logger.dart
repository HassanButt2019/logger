library logger;

export 'src/core/log_manager.dart';
export 'src/models/api_test_data.dart';
export 'src/ui/draggable_logger_overlay.dart';
export 'src/core/logger_controller.dart'; // Required to expose logApiResponse

/// Optional entry point for host widget if needed
export 'src/ui/network_logger_host.dart';



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ApiTestData {
//   final String method;
//   final String url;
//   final int? statusCode;
//   final Map<String, String>? headers;
//   final String? responseBody;
//   final String? requestBody;
//   final DateTime timestamp;

//   ApiTestData({
//     required this.method,
//     required this.url,
//     this.statusCode,
//     this.headers,
//     this.responseBody,
//     this.requestBody,
//   }) : timestamp = DateTime.now();
// }

// // import '../models/api_test_data.dart';

// // import '../models/api_test_data.dart';

// class NetworkLogManager {
//   static final NetworkLogManager _instance = NetworkLogManager._internal();
//   final List<ApiTestData> _logs = [];

//   factory NetworkLogManager() => _instance;

//   NetworkLogManager._internal();

//   void log(ApiTestData apiData) {
//     _logs.add(apiData);
//   }

//   List<ApiTestData> get logs => List.unmodifiable(_logs);
// }

// // library network_logger;

// // export 'models/api_test_data.dart';
// // export 'ui/draggable_logger.dart';

// // import 'core/log_manager.dart';
// // import 'models/api_test_data.dart';

// void logApiResponse({
//   required String method,
//   required String url,
//   int? statusCode,
//   Map<String, String>? headers,
//   String? responseBody,
//   String? requestBody,
// }) {
//   final apiData = ApiTestData(
//     method: method,
//     url: url,
//     statusCode: statusCode,
//     headers: headers,
//     responseBody: responseBody,
//     requestBody: requestBody,
//   );
//   NetworkLogManager().log(apiData);
// }




// class NetwordLogger extends StatefulWidget {
//   const NetwordLogger({super.key});

//   @override
//   State<NetwordLogger> createState() => _NetwordLoggerState();
// }

// class _NetwordLoggerState extends State<NetwordLogger> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final overlay = Overlay.of(context, rootOverlay: true);
//       if (overlay != null && !DraggableLoggerOverlay.isInserted) {
//         overlay.insert(DraggableLoggerOverlay.instance);
//         DraggableLoggerOverlay.isInserted = true;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     if (DraggableLoggerOverlay.isInserted) {
//       DraggableLoggerOverlay.instance.remove();
//       DraggableLoggerOverlay.isInserted = false;
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox.shrink(); // Does not render anything itself
//   }
// }


// class DraggableLoggerOverlay {
//   static bool isInserted = false;

//   static final OverlayEntry instance = OverlayEntry(
//     builder: (context) => const _DraggableLoggerButton(),
//   );
// }

// class _DraggableLoggerButton extends StatefulWidget {
//   const _DraggableLoggerButton();

//   @override
//   State<_DraggableLoggerButton> createState() => _DraggableLoggerButtonState();
// }

// class _DraggableLoggerButtonState extends State<_DraggableLoggerButton> {
//   double top = 100;
//   double left = 20;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: top,
//       left: left,
//       child: Draggable(
//         feedback: _buildButton(),
//         childWhenDragging: Container(),
//         onDragEnd: (details) {
//           setState(() {
//             top = details.offset.dy;
//             left = details.offset.dx;
//           });
//         },
//         child: _buildButton(),
//       ),
//     );
//   }

//   Widget _buildButton() {
//     return FloatingActionButton(
//       backgroundColor: Colors.deepPurple,
//       onPressed: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(builder: (_) => const ApiListScreen()),
//         );
//       },
//       child: const Icon(Icons.api),
//     );
//   }
// }



// // import 'package:flutter/material.dart';
// // import '../core/log_manager.dart';
// // import 'api_response_screen.dart';

// class ApiListScreen extends StatelessWidget {
//   const ApiListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final logs = NetworkLogManager().logs;

//     return Scaffold(
//       appBar: AppBar(title: const Text('API Logs')),
//       body: ListView.builder(
//         itemCount: logs.length,
//         itemBuilder: (context, index) {
//           final api = logs[index];
//           return ListTile(
//             title: Text('${api.method} - ${api.url}'),
//             subtitle: Text('Status: ${api.statusCode ?? "N/A"}'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ApiResponseScreen(api: api),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class ApiResponseScreen extends StatelessWidget {
//   final ApiTestData api;

//   const ApiResponseScreen({super.key, required this.api});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('API Response')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: SelectableText(
//           '''Method: ${api.method}
// URL: ${api.url}
// Status Code: ${api.statusCode ?? "N/A"}

// Headers:
// ${api.headers?.entries.map((e) => '${e.key}: ${e.value}').join('\n') ?? 'N/A'}

// Request Body:
// ${api.requestBody ?? 'N/A'}

// Response Body:
// ${api.responseBody ?? 'N/A'}''',
//         ),
//       ),
//     );
//   }
// }


// // class ApiTestData {
// //   final String method;
// //   final String url;
// //   final String? body;

// //   ApiTestData({required this.method, required this.url, this.body});
// // }

// // class NetwordLogger extends StatelessWidget {
// //   final List<ApiTestData> apiList;

// //   const NetwordLogger({super.key, required this.apiList});

// //   @override
// //   Widget build(BuildContext context) {
// //     return _DraggableLoggerButton(apiList: apiList);
// //   }
// // }

// // class _DraggableLoggerButton extends StatefulWidget {
// //   final List<ApiTestData> apiList;

// //   const _DraggableLoggerButton({required this.apiList});

// //   @override
// //   State<_DraggableLoggerButton> createState() => _DraggableLoggerButtonState();
// // }

// // class _DraggableLoggerButtonState extends State<_DraggableLoggerButton> {
// //   double top = 100;
// //   double left = 20;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: [
// //         Positioned(
// //           top: top,
// //           left: left,
// //           child: Draggable(
// //             feedback: _buildButton(),
// //             childWhenDragging: Container(),
// //             onDragEnd: (details) {
// //               setState(() {
// //                 top = details.offset.dy;
// //                 left = details.offset.dx;
// //               });
// //             },
// //             child: _buildButton(),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildButton() {
// //     return FloatingActionButton(
// //       backgroundColor: Colors.deepPurple,
// //       onPressed: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (_) => ApiListScreen(apiList: widget.apiList),
// //           ),
// //         );
// //       },
// //       child: Icon(Icons.api),
// //     );
// //   }
// // }

// // class ApiListScreen extends StatelessWidget {
// //   final List<ApiTestData> apiList;

// //   const ApiListScreen({super.key, required this.apiList});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('API List')),
// //       body: ListView.builder(
// //         itemCount: apiList.length,
// //         itemBuilder: (_, index) {
// //           final api = apiList[index];
// //           return ListTile(
// //             title: Text('${api.method} - ${api.url}'),
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => ApiResponseScreen(api: api)),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class ApiResponseScreen extends StatefulWidget {
// //   final ApiTestData api;

// //   const ApiResponseScreen({super.key, required this.api});

// //   @override
// //   State<ApiResponseScreen> createState() => _ApiResponseScreenState();
// // }

// // class _ApiResponseScreenState extends State<ApiResponseScreen> {
// //   String response = 'Loading...';

// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   Future<void> _fetchResponse( {http.Response? res}) async {
// //     final api = widget.api;
// //     try {
// //       setState(() {
// //         response =
// //             'Status: ${res?.statusCode}\n\nHeaders: ${res?.headers}\n\nBody:\n${res?.body}';
// //       });
// //     } catch (e) {
// //       setState(() {
// //         response = 'Error: $e';
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Response')),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(16),
// //         child: Text(response),
// //       ),
// //     );
// //   }
// // }
