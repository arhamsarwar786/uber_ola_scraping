// ignore_for_file: unused_local_variable, avoid_print, camel_case_types, library_private_types_in_public_api



import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:uber_scrape/utils/gloablState.dart';
import 'package:html/dom.dart' as dom;

class olaWebView extends StatefulWidget {
  const olaWebView({super.key});

  @override
  State<olaWebView> createState() => _olaWebViewState();
}

class _olaWebViewState extends State<olaWebView> {
  List<String> listItems = [];

  @override
  void initState() {
    super.initState();
    String? htmlContent = GlobalState.uberHTML;
    dom.Document document = parse(htmlContent!);
    List<dom.Element> listElements = document.querySelectorAll('div > ul > li p');
    listItems = listElements.map((e) => e.text).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HTML parsing Content'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (String item in listItems) Text(item),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:html/parser.dart' show parse;
// import 'package:uber_scrape/utils/gloablState.dart';
// import 'package:html/dom.dart' as dom;

// class olaWebView extends StatefulWidget {
//   const olaWebView({super.key});

//   @override
//   State<olaWebView> createState() => _olaWebViewState();
// }

// class _olaWebViewState extends State<olaWebView> {
//   List<String> listItems = [];

//   @override
//   void initState() {
//     super.initState();
//     String? htmlContent = GlobalState.uberHTML;
//     dom.Document document = parse(htmlContent!);
//     List<dom.Element> listElements = document.querySelectorAll('div > ul > li');
//     listItems = listElements.map((e) => e.text).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('HTML parsing Content'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 for (String item in listItems) Text(item),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }






// class olaWebView extends StatelessWidget {
//   // final String htmlContent;

//   const olaWebView({Key? key, required}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final document = parse(GlobalState.uberHTML);
    

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HTML Example'),
//       ),
//       body: SingleChildScrollView(
//         child: Html(
//           data: GlobalState.uberHTML,
//           style: {
//             'img': Style(
//               padding: const EdgeInsets.all(8)
//             ),
//             // 'html': Style(
//             //   fontSize: FontSize(16),
//             // ),
//             'p': Style(
//               padding: const EdgeInsets.all(8)
//             ),
//             'a': Style(
//               padding: const EdgeInsets.all(8)
//             ),
//             'p-name': Style(
//               padding: const EdgeInsets.all(8)
//             ),
//             'text': Style(
//               padding: const EdgeInsets.all(8)
//             ),

//           },
//           onLinkTap: (url, _, __, ___) => print('Tapped link: $url'),
//         ),
//       ),
//     );
//   }
// }









// // ignore_for_file: camel_case_types, avoid_print, prefer_collection_literals, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:store_redirect/store_redirect.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class olaWebView extends StatefulWidget {
//   const olaWebView({Key? key}) : super(key: key);

//   @override
//   olaWebViewState createState() => olaWebViewState();
// }

// class olaWebViewState extends State<olaWebView> {
//   late final WebViewController _controller;
//   // final Uri _url = Uri.parse('https://book.olacabs.com/?serviceType=p2p&utm_source=widget_on_olacabs&drop_lat=25.8498572&drop_lng=85.6666046&drop_name=Tajpur%2C%20Bihar%2C%20India&lat=18.9224864&lng=72.8340377&pickup_name=WRCM%20XPX%2C%20Apollo%20Bandar%2C%20Colaba%2C%20Mumbai%2C%20Maharashtra%20400001%2C%20India&pickup=');

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WebView(
//           initialUrl:
//               'https://book.olacabs.com/?serviceType=p2p&utm_source=widget_on_olacabs&drop_lat=25.8498572&drop_lng=85.6666046&drop_name=Tajpur%2C%20Bihar%2C%20India&lat=18.9224864&lng=72.8340377&pickup_name=WRCM%20XPX%2C%20Apollo%20Bandar%2C%20Colaba%2C%20Mumbai%2C%20Maharashtra%20400001%2C%20India&pickup=',
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//             // Get reference to WebView controller to access it globally
//             _controller = webViewController;
//           },
//           javascriptChannels: <JavascriptChannel>[
//             // Set Javascript Channel to WebView
//             _extractDataJSChannel(context),
//             ].toSet(),
//             onPageStarted: (String url) {
//             print('Page started loading: $url');
//           },  

//           onPageFinished: (String url) {
//             print('Page finished loading: $url');
//             // In the final result page we check the url to make sure  it is the last page.
//             if (url.contains('/finalresponse.html')) {
//               _controller.runJavascript("(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
//             }
//             },
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//         floatingActionButton: SizedBox(
//           height: 45,
//           width: 45,
//           child: FittedBox(
//             child: FloatingActionButton(
//               backgroundColor: Colors.white,
//               focusColor: Colors.white,
//               onPressed: () async {
//                 const deepLink = 'https://olawebcdn.com/assets/ola-universal-link.html?';
//                 if(await canLaunch(deepLink)){
//                   await launch(deepLink);
//                 }
//                 else{
//                   const fallbackUrl = 'https://olawebcdn.com/assets/ola-universal-link.html?';
//                   if(await canLaunch(fallbackUrl)){
//                     await launch(fallbackUrl);
//                   }
//                   else{
//                     throw 'Could not launch $deepLink';
//                   }
//                 }
//               },
//               // onPressed: _launchUrl ,
//               child: const CircleAvatar(
//                 backgroundImage: AssetImage(
//                   'assets/images/ola_icon_full.png',
//                 ),
//                 radius: 26,
//               ),
//               // onPressed: () {
//               //    StoreRedirect.redirect(androidAppId:'com.olacabs.customer&hl');
//               //   _controller.reload();
//               // },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   JavascriptChannel _extractDataJSChannel(BuildContext context) {
//     return JavascriptChannel(
//           name: 'Flutter',
//           onMessageReceived: (JavascriptMessage message) {
//                 String pageBody = message.message;
//                 print('page body: $pageBody');
//           },
//        );
//     }
// }

