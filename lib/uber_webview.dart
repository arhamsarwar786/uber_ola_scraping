// ignore_for_file: camel_case_types, avoid_print, prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class uberWebView extends StatefulWidget {
  const uberWebView({Key? key}) : super(key: key);

  @override
  uberWebViewState createState() => uberWebViewState();
}

class uberWebViewState extends State<uberWebView> {
  late final WebViewController _controller;
  final Uri _url1 = Uri.parse('https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl:
              'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D',
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
              backgroundColor: Colors.black,
              focusColor: Colors.white,
              onPressed: _launchUber,
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/uber_icon_full.png',
                ),
                radius: 27,
              ),
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
    Future<void> _launchUber() async {
  if (await canLaunchUrl(_url1)) {
    await launchUrl(_url1);
  } 
  else {
    throw "Could not launch Uber app.";
  }
}
}




// // ignore_for_file: camel_case_types

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class uberWebView extends StatefulWidget {
//   const uberWebView({Key? key}) : super(key: key);

//   @override
//   uberWebViewState createState() => uberWebViewState();
// }

// class uberWebViewState extends State<uberWebView> {
//   late final WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WebView(
//           initialUrl:
//               'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D',
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController controller) {
//             _controller = controller;
//           },
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//         floatingActionButton: SizedBox(
//           height: 40,
//           width: 40,
//           child: FittedBox(
//             child: FloatingActionButton(
//               backgroundColor: Colors.black,
//               focusColor: Colors.white,
//               child: const CircleAvatar(
//                 backgroundImage: AssetImage(
//                   'assets/images/uber_icon_full.png',
//                 ),
//                 radius: 27,
//               ),
//               onPressed: () {
//                 _controller.reload();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
