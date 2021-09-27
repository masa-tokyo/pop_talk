import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key, required this.userId}) : super(key: key);

  final String userId;
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通報'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          if (_isLoading)
            LinearProgressIndicator(
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          Expanded(
            child: WebView(
              initialUrl:
                  'https://docs.google.com/forms/d/e/1FAIpQLSePAnSUGCvFtQpqNABT7g0f8uPOZA1p6AgKQWDg_Pu3KRUC7w/viewform?usp=pp_url&entry.971288946=${widget.userId}',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: _controller.complete,
              onPageStarted: (String url) {
                setState(() {
                  _isLoading = true;
                });
              },
              onPageFinished: (String url) async {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
