import 'package:benix/main_library.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:request_api_helper/request.dart';
import 'package:request_api_helper/request_api_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class WebView extends StatefulWidget {
  final String url;
  final String? id;
  const WebView({Key? key, required this.url, this.id}) : super(key: key);

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
                // print(controller.getHitTestResult().then((value) => print(value!.type)));
                Uri? geturl = await controller.getUrl();

                if (geturl?.host == 'gopay') {
                  try {
                    await launch(geturl.toString(), forceWebView: false);
                    if (geturl?.host != 'app.midtrans.com') {
                      Navigator.pop(context);
                      // Navigator.pop(context);
                    }
                  } catch (e) {
                    await RequestApiHelper.sendRequest(
                      type: Api.get,
                      url: 'transaction/delete/' + widget.id.toString(),
                      replacementId: 1,
                      withLoading: true,
                      config: RequestApiHelperData(
                        onSuccess: (data) {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Peringatan'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Aplikasi tidak ditemukan'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  // launch(geturl.toString(), forceWebView: false);
                  // Navigator.pop(context);

                } else {
                  if (geturl?.host != 'app.midtrans.com') {
                    Navigator.pop(context);
                    // Navigator.pop(context);
                  }
                }
              }
            },
            onPrint: (InAppWebViewController controller, uri) {
              // print(uri.)
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
