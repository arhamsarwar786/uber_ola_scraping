// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:webview_flutter/webview_flutter.dart';

class uberWebView extends StatefulWidget {
  const uberWebView({Key? key}) : super(key: key);

  @override
  uberWebViewState createState() => uberWebViewState();
}

class uberWebViewState extends State<uberWebView> {
  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl:
              'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller = controller;
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: SizedBox(
          height: 40,
          width: 40,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              focusColor: Colors.white,
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/uber_icon_full.png',
                ),
                radius: 27,
              ),
              onPressed: () {
                   StoreRedirect.redirect(androidAppId:'com.ubercab&hl');
                _controller.reload();
              },
            ),
          ),
        ),
      ),
    );
  }
}
