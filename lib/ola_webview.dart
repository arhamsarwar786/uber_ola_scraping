// ignore_for_file: camel_case_types, avoid_print, prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class olaWebView extends StatefulWidget {
  const olaWebView({Key? key}) : super(key: key);

  @override
  olaWebViewState createState() => olaWebViewState();
}

class olaWebViewState extends State<olaWebView> {
  late final WebViewController _controller;
  final Uri _url = Uri.parse('https://olawebcdn.com/assets/ola-universal-link.html?');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl:
              'https://book.olacabs.com/?serviceType=p2p&utm_source=widget_on_olacabs&drop_lat=25.8498572&drop_lng=85.6666046&drop_name=Tajpur%2C%20Bihar%2C%20India&lat=18.9224864&lng=72.8340377&pickup_name=WRCM%20XPX%2C%20Apollo%20Bandar%2C%20Colaba%2C%20Mumbai%2C%20Maharashtra%20400001%2C%20India&pickup=',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            // Get reference to WebView controller to access it globally
            _controller = webViewController;
          },
          javascriptChannels: <JavascriptChannel>[
            // Set Javascript Channel to WebView
            _extractDataJSChannel(context),
            ].toSet(),
            onPageStarted: (String url) {
            print('Page started loading: $url');
          },  

          onPageFinished: (String url) {
            print('Page finished loading: $url');
            // In the final result page we check the url to make sure  it is the last page.
            if (url.contains('/finalresponse.html')) {
              _controller.runJavascript("(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
            }
            },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: SizedBox(
          height: 40,
          width: 40,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              focusColor: Colors.white,
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/ola_icon_full.png',
                ),
                radius: 27,
              ),
              onPressed: _launchUrl ,
            //   onPressed: () async {
            //   const deepLink = 'https://m.uber.com/ul/?client_id=<CLIENT_ID>&action=setPickup&pickup[latitude]=37.775818&pickup[longitude]=-122.418028&pickup[nickname]=UberHQ&pickup[formatted_address]=1455%20Market%20St%2C%20San%20Francisco%2C%20CA%2094103&dropoff[latitude]=37.802374&dropoff[longitude]=-122.405818&dropoff[nickname]=Coit%20Tower&dropoff[formatted_address]=1%20Telegraph%20Hill%20Blvd%2C%20San%20Francisco%2C%20CA%2094133&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d';
            //   if (await canLaunchUrl(deepLink)) {
            //     await launchUrl(deepLink);
            //   } else {
            //     throw 'Could not launch $deepLink';
            //   }
            // },
            ),
          ),
        ),
      ),
    );
  }
  JavascriptChannel _extractDataJSChannel(BuildContext context) {
    return JavascriptChannel(
          name: 'Flutter',
          onMessageReceived: (JavascriptMessage message) {
                String pageBody = message.message;
                print('page body: $pageBody');
          },
       );
    }
    Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
}

