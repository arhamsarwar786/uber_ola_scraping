// ignore_for_file: unused_local_variable, avoid_print, camel_case_types, library_private_types_in_public_api, deprecated_member_use, prefer_collection_literals


import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/root_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class olaWebView extends StatefulWidget {
  const olaWebView({Key? key}) : super(key: key);

  @override
  _olaWebViewState createState() => _olaWebViewState();
}

class _olaWebViewState extends State<olaWebView> {
 late String _initialUrl;

  // final String _pickupAddressLine1 = 'Jail Road';
  final String? _pickupAddressLine2 = GlobalState.pickUpAddress;
  final double? _pickupLat = GlobalState.pickUpLat;
  final double? _pickupLng = GlobalState.pickUpLng;

  // final String _dropAddressLine1 = 'Kinnaird College For Women University';
  final String? _dropAddressLine2 = GlobalState.destinationAddress;
  final double? _dropLat = GlobalState.destinationLat;
  final double? _dropLng = GlobalState.destinationLng;


  // final String initialUrl =
      // 'https://book.olacabs.com/?serviceType=p2p&utm_source=widget_on_olacabs&drop_lat=25.8498572&drop_lng=85.6666046&drop_name=Tajpur%2C%20Bihar%2C%20India&lat=18.9224864&lng=72.8340377&pickup_name=WRCM%20XPX%2C%20Apollo%20Bandar%2C%20Colaba%2C%20Mumbai%2C%20Maharashtra%20400001%2C%20India&pickup=';
  late WebViewController _webViewController;
  String _htmlContent = '';

  Timer? _timer;

  void _updateHtmlContent(String newHtmlContent) {
    setState(() {
      _htmlContent = newHtmlContent;
      _htmlContent = _htmlContent.replaceAll("\\u003C", "<");
      if (_htmlContent != "" || _htmlContent != null) {
        GlobalState.olaHTML = _htmlContent;
      }
    });
    log('Updated HTML content: $_htmlContent'.toString());
  }

  Future<String> _getHtmlContent() async {
    final String content =
        await _webViewController.evaluateJavascript('document.body.innerHTML');
    return content;
  }

  @override
  void initState() {
    super.initState();

        if(_pickupLat != null && _pickupLng != null && _dropLat != null && _dropLng != null){
        _initialUrl =
              'https://book.olacabs.com/?serviceType=p2p&utm_source=widget_on_olacabs&drop_lat=${_dropLat}&drop_lng=${_dropLng}&drop_name=${_dropAddressLine2}India&lat=${_pickupLat}&lng=${_pickupLng}&pickup_name=${_pickupAddressLine2}&pickup=';
    }
    else {
      _initialUrl = 'https://book.olacabs.com/?serviceType=p2p&utm_source=widget_on_olacabs&drop_lat=25.8498572&drop_lng=85.6666046&drop_name=Tajpur%2C%20Bihar%2C%20India&lat=18.9224864&lng=72.8340377&pickup_name=WRCM%20XPX%2C%20Apollo%20Bandar%2C%20Colaba%2C%20Mumbai%2C%20Maharashtra%20400001%2C%20India&pickup=';
    }

    _timer = Timer.periodic(const Duration(seconds: 10), (Timer t) async {
      final String content = await _getHtmlContent();
      _updateHtmlContent(content);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => const RootScreen()));
        return false;
      },
        child: Scaffold(
          body: WebView(
            initialUrl: _initialUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
            },
            onPageFinished: (String url) async {
              final String content = await _getHtmlContent();
              _updateHtmlContent(content);
            },
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: 'internalChannel',
                  onMessageReceived: (JavascriptMessage message) {
                    _updateHtmlContent(message.message);
                  }),
            ]),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: SizedBox(
            height: 45,
            width: 45,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                focusColor: Colors.white,
                onPressed: () async {
                  const deepLink = 'https://olawebcdn.com/assets/ola-universal-link.html?';
                  if(await canLaunch(deepLink)){
                    await launch(deepLink);
                  }
                  else{
                    const fallbackUrl = 'https://olawebcdn.com/assets/ola-universal-link.html?';
                    if(await canLaunch(fallbackUrl)){
                      await launch(fallbackUrl);
                    }
                    else{
                      throw 'Could not launch $deepLink';
                    }
                  }
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/ola_icon_full.png',
                  ),
                  radius: 26,
                ),
              ),
        ),
          )
          ),
      )
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:uber_scrape/utils/root_screen.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class olaWebView extends StatefulWidget {
//   const olaWebView({Key? key}) : super(key: key);

//   @override
//   olaWebViewState createState() => olaWebViewState();
// }

// class olaWebViewState extends State<olaWebView> {
//   late final WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: WillPopScope(
//         onWillPop: () async {
//         await Navigator.push(context, MaterialPageRoute(builder: (context) => const RootScreen()));
//         return false;
//       },
//         child: Scaffold(
//           body: WebView(
//             initialUrl:
//                 'https://book.olacabs.com/?serviceType=p2p&utm_source=widget_on_olacabs&drop_lat=25.8498572&drop_lng=85.6666046&drop_name=Tajpur%2C%20Bihar%2C%20India&lat=18.9224864&lng=72.8340377&pickup_name=WRCM%20XPX%2C%20Apollo%20Bandar%2C%20Colaba%2C%20Mumbai%2C%20Maharashtra%20400001%2C%20India&pickup=',
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController webViewController) {
//               // Get reference to WebView controller to access it globally
//               _controller = webViewController;
//             },
//             javascriptChannels: <JavascriptChannel>[
//               // Set Javascript Channel to WebView
//               _extractDataJSChannel(context),
//               ].toSet(),
//               onPageStarted: (String url) {
//               print('Page started loading: $url');
//             },  
      
//             onPageFinished: (String url) {
//               print('Page finished loading: $url');
//               // In the final result page we check the url to make sure  it is the last page.
//               if (url.contains('/finalresponse.html')) {
//                 _controller.runJavascript("(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
//               }
//               },
//           ),
//           floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//           floatingActionButton: SizedBox(
//             height: 45,
//             width: 45,
//             child: FittedBox(
//               child: FloatingActionButton(
//                 backgroundColor: Colors.white,
//                 focusColor: Colors.white,
//                 onPressed: () async {
//                   const deepLink = 'https://olawebcdn.com/assets/ola-universal-link.html?';
//                   if(await canLaunch(deepLink)){
//                     await launch(deepLink);
//                   }
//                   else{
//                     const fallbackUrl = 'https://olawebcdn.com/assets/ola-universal-link.html?';
//                     if(await canLaunch(fallbackUrl)){
//                       await launch(fallbackUrl);
//                     }
//                     else{
//                       throw 'Could not launch $deepLink';
//                     }
//                   }
//                 },
//                 child: const CircleAvatar(
//                   backgroundImage: AssetImage(
//                     'assets/images/ola_icon_full.png',
//                   ),
//                   radius: 26,
//                 ),
//               ),
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



// import 'package:flutter/material.dart';
// import 'package:html/parser.dart' show parse;
// import 'package:uber_scrape/utils/gloablState.dart';
// import 'package:html/dom.dart' as dom;
// import 'package:uber_scrape/utils/root_screen.dart';

// class olaWebView extends StatefulWidget {
//   const olaWebView({Key? key});

//   @override
//   State<olaWebView> createState() => _olaWebViewState();
// }

// class _olaWebViewState extends State<olaWebView> {
//   List<String> listItems = [];

// @override
// void initState() {
//   super.initState();
//   String? htmlContent = GlobalState.uberHTML;
//   dom.Document document = parse(htmlContent!);
//   List<dom.Element> listElements = document.querySelectorAll('div > ul > li');
//   listItems = listElements
//       .where((element) => !element.querySelectorAll('li > p').isNotEmpty)
//       .map((e) => e.text)
//       .toList();
// }




//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         await Navigator.push(context, MaterialPageRoute(builder: (context) => const RootScreen()));
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Uber Rides', style: TextStyle(color: Colors.black)),
//           backgroundColor: Colors.amber,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               for (var i = 1; i < listItems.length; i++)
//                 Row(
//                   children: [
//                     const CircleAvatar(
//                       backgroundImage: AssetImage(
//                         'assets/images/uber_icon_full.png',
//                       ),
//                       radius: 15,
//                     ),
//                     const SizedBox(width: 10),
//                     Flexible(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             listItems[i],
//                             softWrap: true,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:html/parser.dart' as htmlParser;
// import 'package:uber_scrape/utils/gloablState.dart';

// class olaWebView extends StatelessWidget {
//   final htmlContent = GlobalState.uberHTML ;

//   String getFilteredText() {
//     final document = htmlParser.parse(htmlContent);
//     final element = document.querySelector('div > ul > li');
//     return element?.text ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredText = getFilteredText();
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Uber HTML show"),
//           backgroundColor: Colors.amber,
//         ),
//         body: Center(
//           child: Html(data: htmlContent),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: Text(filteredText),
//         ),
//       ),
//     );
//   }
// }