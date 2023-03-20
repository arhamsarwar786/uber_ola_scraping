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