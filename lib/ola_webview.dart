import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class olaWebView extends StatefulWidget {
  const olaWebView({Key? key}) : super(key: key);

  @override
  olaWebViewState createState() => olaWebViewState();
}

class olaWebViewState extends State<olaWebView> {
  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OLA WEB View'),
      ),
      body: WebView(
        initialUrl:
            'https://book.olacabs.com/?serviceType=p2p&utm_source=widget_on_olacabs&drop_lat=25.8498572&drop_lng=85.6666046&drop_name=Tajpur%2C%20Bihar%2C%20India&lat=18.9224864&lng=72.8340377&pickup_name=WRCM%20XPX%2C%20Apollo%20Bandar%2C%20Colaba%2C%20Mumbai%2C%20Maharashtra%20400001%2C%20India&pickup=',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Container(
        height: 40,
        width: 40,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            focusColor: Colors.white,
            child: Image(
                fit: BoxFit.contain,
                image:
                    AssetImage("asset/images/images_ola-removebg-preview.png")),
            onPressed: () {
              _controller.reload();
            },
          ),
        ),
      ),
    );
  }
}