import 'package:faza_app/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;
  final Function(String url) onPageFinished;
  const WebViewScreen({super.key, this.url, required this.onPageFinished});
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewScreen> {
  WebViewController? controller;
  int progress = 0;
  init() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            this.progress = progress;
            if (progress == 100) {
              setState(() {});
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: widget.onPageFinished,
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  void initState() {
    // Future.delayed(Duration(seconds: 1)).then(init());
    init();
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: customAppBar('CONFIRM_ORDER'.tr),
      backgroundColor: Colors.white,
      body: progress == 100
          ? Column(children: [
              Expanded(
                child: WebViewWidget(controller: controller!),
              )
            ])
          : const Center(
              child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            )),
    );
  }
}
