// // import 'package:flutter/material.dart';
// // import 'package:webview_flutter/webview_flutter.dart';

// // class MyWebView extends StatefulWidget {
// //   @override
// //   _MyWebViewState createState() => _MyWebViewState();
// // }

// // class _MyWebViewState extends State<MyWebView> {
// //   final _webViewKey = GlobalKey<WebViewContainerState>();
// //   final _searchController = TextEditingController();
// //   String _searchResult = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('WebView Demo'),
// //       ),
// //       body: Column(
// //         children: [
// //           TextField(
// //             controller: _searchController,
// //             decoration: InputDecoration(
// //               labelText: 'Search',
// //               suffixIcon: IconButton(
// //                 icon: Icon(Icons.search),
// //                 onPressed: () {
// //                   _searchWebView();
// //                 },
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: WebViewContainer(
// //               key: _webViewKey,
// //               initialUrl: 'https://www.uber.com/pk/en/',
// //             ),
// //           ),
// //           Text(_searchResult),
// //         ],
// //       ),
// //     );
// //   }

// //   void _searchWebView() {
// //     final searchQuery = _searchController.text;

// //     _webViewKey.currentState?.controller.evaluateJavascript(
// //       "document.documentElement.outerHTML"
// //     ).then((html) {
// //       if (html.contains(searchQuery)) {
// //         setState(() {
// //           _searchResult = 'Found';
// //         });
// //       } else {
// //         setState(() {
// //           _searchResult = 'Not found';
// //         });
// //       }
// //     });
// //   }
// // }

// // class WebViewContainer extends StatefulWidget {
// //   final String initialUrl;
// //   final bool enableJavascript;

// //   WebViewContainer({
// //     Key? key,
// //     required this.initialUrl,
// //     this.enableJavascript = true,
// //   }) : super(key: key);

// //   @override
// //   WebViewContainerState createState() => WebViewContainerState();
// // }

// // class WebViewContainerState extends State<WebViewContainer> {
// //   late WebViewController _controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return WebView(
// //       initialUrl: widget.initialUrl,
// //       javascriptMode: widget.enableJavascript ? JavascriptMode.unrestricted : JavascriptMode.disabled,
// //       onWebViewCreated: (controller) {
// //         _controller = controller;
// //       },
// //     );
// //   }

// //   WebViewController get controller => _controller;
// // }
// import 'package:flutter/material.dart';
// import 'package:store_redirect/store_redirect.dart';

// import 'package:webview_flutter/webview_flutter.dart';
// class WebViewExample extends StatefulWidget {
// @override
// _WebViewExampleState createState() => _WebViewExampleState();
// }
// class _WebViewExampleState extends State<WebViewExample> {
// // Reference to webview controller
// late WebViewController _controller;
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     floatingActionButton: FloatingActionButton(onPressed: () {
//       StoreRedirect.redirect(androidAppId:'com.ubercab&hl');
//      // _controller.loadUrl("https://www.uber.com/pk/en/");
//     },),
//     appBar: AppBar(
//        title: Text('Flutter Web View Example'),
//     ),
//     body: Container(
//        child: WebView(
//           initialUrl: 'https://yourwebsite.com',
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//             // Get reference to WebView controller to access it globally
//             _controller = webViewController;
//           },
//           javascriptChannels: <JavascriptChannel>[
//             // Set Javascript Channel to WebView
//             _extractDataJSChannel(context),
//             ].toSet(),
//           onPageStarted: (String url) {
//             print('Page started loading: $url');
//           },
          
//           onPageFinished: (String url) {
//             print('Page finished loading: $url');
//             // In the final result page we check the url to make sure  it is the last page.
//             if (url.contains('/finalresponse.html')) {
//               _controller.evaluateJavascript("(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
//             }
//             },
//          ),
         
//       ),
//    );
// }
// JavascriptChannel _extractDataJSChannel(BuildContext context) {
//     return JavascriptChannel(
//           name: 'Flutter',
//           onMessageReceived: (JavascriptMessage message) {
//                 String pageBody = message.message;
//                 print('page body: $pageBody');
//           },
//        );
//     }
// }

// //android--com.zhiliaoapp.musically
// //ios--835599320

  // final String url="https://auth.uber.com/v2/?breeze_local_zone=dca23&next_url=https%3A%2F%2Fm.uber.com%2F%3F%25243p%3Da_custom_47734%26%2524deeplink_path%3D%253Faction%253DsetPickup%2526pickup%253Dmy_location%26_branch_match_id%3D1166982279930892104%26_branch_referrer%3DH4sIAAAAAAAAA42PTWvDMAyGf417W0Lj0MDAlEHX0Vs7trNxVdGY%252BEPY8iH%252FvjZlh94GOkh6XkmvZmbK730fwWJniDpnw9J%252Fbb9P6w9cwrAXwyhJGQ0lc%252FR6nCY5bsT0CcaTsfegImHQdVIne8PcUEaI4WbSqqlcnc0zJvV7xfR2CowpGLepS6t24Ui6JKfmZkLIDzEca%252FiuVHEH0bdaHgt7nWNJgEIeXvaIYdfgn5WKX81UboBtbCQjny0shWqTnok8%252BFW7CKZJnp6Q2v%252BaDM%252Bqnv739AOXPGBqRwEAAA%253D%253D%26action%3DsetPickup%26pickup%3Dmy_location%26utm_campaign%3Dopen_app_rides%26utm_medium%3Dpaid%2Badvertising%26utm_source%3DUber-Internal%26~campaign%3Dopen_app_rides%26~secondary_publisher%3DUber-Internal&state=IP0SVA7atLsQaC3070kPci6YY1ThLHldBL12Ot5PPnE%3D";
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MyWebView extends StatefulWidget {
//   final String url="https://auth.uber.com/v2/?breeze_local_zone=dca23&next_url=https%3A%2F%2Fm.uber.com%2F%3F%25243p%3Da_custom_47734%26%2524deeplink_path%3D%253Faction%253DsetPickup%2526pickup%253Dmy_location%26_branch_match_id%3D1166982279930892104%26_branch_referrer%3DH4sIAAAAAAAAA42PTWvDMAyGf417W0Lj0MDAlEHX0Vs7trNxVdGY%252BEPY8iH%252FvjZlh94GOkh6XkmvZmbK730fwWJniDpnw9J%252Fbb9P6w9cwrAXwyhJGQ0lc%252FR6nCY5bsT0CcaTsfegImHQdVIne8PcUEaI4WbSqqlcnc0zJvV7xfR2CowpGLepS6t24Ui6JKfmZkLIDzEca%252FiuVHEH0bdaHgt7nWNJgEIeXvaIYdfgn5WKX81UboBtbCQjny0shWqTnok8%252BFW7CKZJnp6Q2v%252BaDM%252Bqnv739AOXPGBqRwEAAA%253D%253D%26action%3DsetPickup%26pickup%3Dmy_location%26utm_campaign%3Dopen_app_rides%26utm_medium%3Dpaid%2Badvertising%26utm_source%3DUber-Internal%26~campaign%3Dopen_app_rides%26~secondary_publisher%3DUber-Internal&state=IP0SVA7atLsQaC3070kPci6YY1ThLHldBL12Ot5PPnE%3D";

//  // MyWebView({required this.url});

//   @override
//   _MyWebViewState createState() => _MyWebViewState();
// }

// class _MyWebViewState extends State<MyWebView> {
//   late WebViewController _webViewController;
//   String _htmlCode = "";
//   String _cssCode = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebView(
      
//         initialUrl: widget.url,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _webViewController = webViewController;
//         },
//         onPageFinished: (String url) async {
//           print("some thing");
//           // Extract HTML code
//           String htmlCode = await _webViewController.evaluateJavascript("document.documentElement.outerHTML;");
//           setState(() {
//             _htmlCode = htmlCode;
//           });

//           // Extract CSS code
//           String cssCode = await _webViewController.evaluateJavascript("Array.from(document.styleSheets).map(styleSheet => Array.from(styleSheet.cssRules).map(cssRule => cssRule.cssText).join('\\n')).join('\\n');");
//           setState(() {
//             _cssCode = cssCode;
//           });
//         },
//       ),
//     );
//   }
// }


 import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MyWebView extends StatefulWidget {
//   final String url="https://auth.uber.com/v2/?breeze_local_zone=dca23&next_url=https%3A%2F%2Fm.uber.com%2F%3F%25243p%3Da_custom_47734%26%2524deeplink_path%3D%253Faction%253DsetPickup%2526pickup%253Dmy_location%26_branch_match_id%3D1166982279930892104%26_branch_referrer%3DH4sIAAAAAAAAA42PTWvDMAyGf417W0Lj0MDAlEHX0Vs7trNxVdGY%252BEPY8iH%252FvjZlh94GOkh6XkmvZmbK730fwWJniDpnw9J%252Fbb9P6w9cwrAXwyhJGQ0lc%252FR6nCY5bsT0CcaTsfegImHQdVIne8PcUEaI4WbSqqlcnc0zJvV7xfR2CowpGLepS6t24Ui6JKfmZkLIDzEca%252FiuVHEH0bdaHgt7nWNJgEIeXvaIYdfgn5WKX81UboBtbCQjny0shWqTnok8%252BFW7CKZJnp6Q2v%252BaDM%252Bqnv739AOXPGBqRwEAAA%253D%253D%26action%3DsetPickup%26pickup%3Dmy_location%26utm_campaign%3Dopen_app_rides%26utm_medium%3Dpaid%2Badvertising%26utm_source%3DUber-Internal%26~campaign%3Dopen_app_rides%26~secondary_publisher%3DUber-Internal&state=IP0SVA7atLsQaC3070kPci6YY1ThLHldBL12Ot5PPnE%3D";

//  // MyWebView({required this.url});

//   @override
//   _MyWebViewState createState() => _MyWebViewState();
// }

// class _MyWebViewState extends State<MyWebView> {
//   late WebViewController _webViewController;
//   String _htmlCode = "";
//   String _cssCode = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebView(
      
//         initialUrl: widget.url,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _webViewController = webViewController;
//         },
//         onPageFinished: (String url) async {
//           print("some thing");
//           // Extract HTML code
//           String htmlCode = await _webViewController.evaluateJavascript("document.documentElement.outerHTML;");
//           setState(() {
//             _htmlCode = htmlCode;
//           });

//           // Extract CSS code
//           String cssCode = await _webViewController.evaluateJavascript("Array.from(document.styleSheets).map(styleSheet => Array.from(styleSheet.cssRules).map(cssRule => cssRule.cssText).join('\\n')).join('\\n');");
//           setState(() {
//             _cssCode = cssCode;
//           });
//         },
//       ),
//     );
//   }
// }
// Future<void> extractHtmlAndCss(String url) async {
//   final response = await http.get(Uri.parse(url));
//   final document = htmlParser.parse(response.body);
//   final cssLinks = document.querySelectorAll('https://auth.uber.com/v2/?breeze_local_zone=dca23&next_url=https%3A%2F%2Fm.uber.com%2F%3F%25243p%3Da_custom_47734%26%2524deeplink_path%3D%253Faction%253DsetPickup%2526pickup%253Dmy_location%26_branch_match_id%3D1166982279930892104%26_branch_referrer%3DH4sIAAAAAAAAA42PTWvDMAyGf417W0Lj0MDAlEHX0Vs7trNxVdGY%252BEPY8iH%252FvjZlh94GOkh6XkmvZmbK730fwWJniDpnw9J%252Fbb9P6w9cwrAXwyhJGQ0lc%252FR6nCY5bsT0CcaTsfegImHQdVIne8PcUEaI4WbSqqlcnc0zJvV7xfR2CowpGLepS6t24Ui6JKfmZkLIDzEca%252FiuVHEH0bdaHgt7nWNJgEIeXvaIYdfgn5WKX81UboBtbCQjny0shWqTnok8%252BFW7CKZJnp6Q2v%252BaDM%252Bqnv739AOXPGBqRwEAAA%253D%253D%26action%3DsetPickup%26pickup%3Dmy_location%26utm_campaign%3Dopen_app_rides%26utm_medium%3Dpaid%2Badvertising%26utm_source%3DUber-Internal%26~campaign%3Dopen_app_rides%26~secondary_publisher%3DUber-Internal&state=IP0SVA7atLsQaC3070kPci6YY1ThLHldBL12Ot5PPnE%3D]');
  
//   for (final link in cssLinks) {
//     final cssUrl = link.attributes['href'];
//     final cssResponse = await http.get(Uri.parse(cssUrl!));
//     final cssDocument = cssParser.parse(cssResponse.body);
    
//     // Do something with the CSS document here
//   }
  
//   // Extract HTML document and do something with it
// }
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://www.example.com',
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: Set.from([
          JavascriptChannel(
              name: 'html_css',
              onMessageReceived: (JavascriptMessage message) {
                String html = message.message;
                // Do something with the HTML string
              }),
        ]),
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          
  }),
    );
  }
}

