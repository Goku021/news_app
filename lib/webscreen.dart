import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebScreen extends StatefulWidget {
  final String webUrl;

  const WebScreen(this.webUrl, {super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late InAppWebViewController _webcontroller;

    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri.uri(
            Uri.parse(widget.webUrl),
          ),
        ),
        onWebViewCreated: (controller) {
          _webcontroller = controller;
        },
        onReceivedError: (controller, request, error) {
          print("Failed to load ${request.url}: ${error.description}");
          // Optional: Show a user-friendly error message
        },
      ),
    );
  }
}
