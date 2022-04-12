import 'package:benix/main_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class WebView extends StatefulWidget {
  final String url;
  const WebView({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  InAppWebViewController? webView;
  @override
  Widget build(BuildContext context) {
    return InitControl(
      doubleClick: true,
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            onLoadHttpError: (controller, uri, integer, strings) {},
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                useOnLoadResource: true,
              ),
            ),
            onProgressChanged: (controller, progress) async {
              if (progress == 100) {
                Uri? geturl = await controller.getUrl();
                if (geturl?.host == 'gopay') {
                  launch(geturl.toString(), forceWebView: false);
                }
              }
            },
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
          ),
        ),
      ),
    );
  }
}
