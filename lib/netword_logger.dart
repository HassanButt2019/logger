import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiTestData {
  final String method;
  final String url;
  final String? body;

  ApiTestData({required this.method, required this.url, this.body});
}

class NetwordLogger extends StatelessWidget {
  final List<ApiTestData> apiList;

  const NetwordLogger({super.key, required this.apiList});

  @override
  Widget build(BuildContext context) {
    return _DraggableLoggerButton(apiList: apiList);
  }
}

class _DraggableLoggerButton extends StatefulWidget {
  final List<ApiTestData> apiList;

  const _DraggableLoggerButton({required this.apiList});

  @override
  State<_DraggableLoggerButton> createState() => _DraggableLoggerButtonState();
}

class _DraggableLoggerButtonState extends State<_DraggableLoggerButton> {
  double top = 100;
  double left = 20;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: top,
          left: left,
          child: Draggable(
            feedback: _buildButton(),
            childWhenDragging: Container(),
            onDragEnd: (details) {
              setState(() {
                top = details.offset.dy;
                left = details.offset.dx;
              });
            },
            child: _buildButton(),
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ApiListScreen(apiList: widget.apiList),
          ),
        );
      },
      child: Icon(Icons.api),
    );
  }
}

class ApiListScreen extends StatelessWidget {
  final List<ApiTestData> apiList;

  const ApiListScreen({super.key, required this.apiList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API List')),
      body: ListView.builder(
        itemCount: apiList.length,
        itemBuilder: (_, index) {
          final api = apiList[index];
          return ListTile(
            title: Text('${api.method} - ${api.url}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ApiResponseScreen(api: api)),
              );
            },
          );
        },
      ),
    );
  }
}

class ApiResponseScreen extends StatefulWidget {
  final ApiTestData api;

  const ApiResponseScreen({super.key, required this.api});

  @override
  State<ApiResponseScreen> createState() => _ApiResponseScreenState();
}

class _ApiResponseScreenState extends State<ApiResponseScreen> {
  String response = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchResponse();
  }

  Future<void> _fetchResponse() async {
    final api = widget.api;
    try {
      http.Response res;
      switch (api.method) {
        case 'GET':
          res = await http.get(Uri.parse(api.url));
          break;
        case 'POST':
          res = await http.post(
            Uri.parse(api.url),
            body: api.body,
            headers: {'Content-Type': 'application/json'},
          );
          break;
        case 'PUT':
          res = await http.put(
            Uri.parse(api.url),
            body: api.body,
            headers: {'Content-Type': 'application/json'},
          );
          break;
        case 'DELETE':
          res = await http.delete(Uri.parse(api.url));
          break;
        default:
          res = http.Response('Unsupported method', 400);
      }

      setState(() {
        response =
            'Status: ${res.statusCode}\n\nHeaders: ${res.headers}\n\nBody:\n${res.body}';
      });
    } catch (e) {
      setState(() {
        response = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Response')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(response),
      ),
    );
  }
}
