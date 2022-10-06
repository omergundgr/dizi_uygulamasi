import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wistv/consts/colors.dart';
import 'package:wistv/player_page.dart';

class WebViewPage extends StatefulWidget {
  late String htmlString;
  WebViewPage({Key? key, required this.htmlString}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webviewCtrl;
  String _currentUrl = "about:blank";

  _loadHtmlContent() async {
    if (widget.htmlString.startsWith("http", 0)) {
      _webviewCtrl.loadUrl(widget.htmlString);
    } else {
      _webviewCtrl.loadUrl(Uri.dataFromString(widget.htmlString,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (await _webviewCtrl.canGoBack()) {
            _webviewCtrl.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: MyColors.backgroundColor,
          body: htmlContent(),
        ),
      ),
    );
  }

  WebView htmlContent() {
    return WebView(
      initialUrl: _currentUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (url) {
        if (url.startsWith("go:", 0)) {
          _webviewCtrl.goBack();
          Get.to(() => const PlayerPage(),
              arguments: url.replaceFirst("go:", ""));
        }
      },
      onPageFinished: (url) {
        if (url.startsWith("go:", 0)) _webviewCtrl.goBack();
        _currentUrl = url;
      },
      onWebViewCreated: (WebViewController webViewController) {
        _webviewCtrl = webViewController;
        _loadHtmlContent();
      },
    );
  }
}
