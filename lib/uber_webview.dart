// ignore_for_file: camel_case_types, deprecated_member_use, unused_field, avoid_print, prefer_collection_literals, library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uber_scrape/utils/gloablState.dart';
import 'package:uber_scrape/utils/root_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class uberWebView extends StatefulWidget {
  const uberWebView({Key? key}) : super(key: key);

  @override
  _uberWebViewState createState() => _uberWebViewState();
}

class _uberWebViewState extends State<uberWebView> {
  final String initialUrl =
      'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D';
  late WebViewController _webViewController;
  String _htmlContent = '';

  Timer? _timer;

  void _updateHtmlContent(String newHtmlContent) {
    setState(() {
      _htmlContent = newHtmlContent;
      _htmlContent = _htmlContent.replaceAll("\\u003C", "<");
      if (_htmlContent != "" || _htmlContent != null) {
        GlobalState.uberHTML = _htmlContent;
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
            initialUrl: initialUrl,
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
                  const deepLink = 'uber://?client_id=<CLIENT_ID>&action=setPickup&pickup[latitude]=37.775818&pickup[longitude]=-122.418028&pickup[nickname]=UberHQ&pickup[formatted_address]=1455%20Market%20St%2C%20San%20Francisco%2C%20CA%2094103&dropoff[latitude]=37.802374&dropoff[longitude]=-122.405818&dropoff[nickname]=Coit%20Tower&dropoff[formatted_address]=1%20Telegraph%20Hill%20Blvd%2C%20San%20Francisco%2C%20CA%2094133&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383';
                  if(await canLaunch(deepLink)){
                    await launch(deepLink);
                  }
                  else{
                    const fallbackUrl = 'uber://?client_id=<CLIENT_ID>&action=setPickup&pickup[latitude]=37.775818&pickup[longitude]=-122.418028&pickup[nickname]=UberHQ&pickup[formatted_address]=1455%20Market%20St%2C%20San%20Francisco%2C%20CA%2094103&dropoff[latitude]=37.802374&dropoff[longitude]=-122.405818&dropoff[nickname]=Coit%20Tower&dropoff[formatted_address]=1%20Telegraph%20Hill%20Blvd%2C%20San%20Francisco%2C%20CA%2094133&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383';
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
                    'assets/images/uber_icon_full.png',
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








// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:uber_scrape/utils/gloablState.dart';
// import 'package:webview_flutter/webview_flutter.dart';


// class uberWebView extends StatefulWidget {
//   const uberWebView({super.key});

//   @override
//   _uberWebViewState createState() => _uberWebViewState();
// }

// class _uberWebViewState extends State<uberWebView> {
//   final String initialUrl = 'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D';
//   late WebViewController _webViewController;
//   String _htmlContent = '';

//   void _updateHtmlContent(String newHtmlContent) {
//     setState(() {
//       _htmlContent = newHtmlContent;
//       _htmlContent = _htmlContent.replaceAll("\\u003C", "<");
//       if (_htmlContent != "" || _htmlContent != null ) {
//         GlobalState.uberHTML = _htmlContent;
//       }
//     });
//     log('Updated HTML content: $_htmlContent'.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WebView(
//           initialUrl: initialUrl,
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//             _webViewController = webViewController;
//           },
//           onPageFinished: (String url) async {
//             final String content =
//                 await _webViewController.evaluateJavascript('document');
//             _updateHtmlContent(content);
//           },
//           javascriptChannels: Set.from([
//             JavascriptChannel(
//                 name: 'internalChannel',
//                 onMessageReceived: (JavascriptMessage message) {
//                   _updateHtmlContent(message.message);
//                 }),
//           ]),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             final String content =
//                 await _webViewController.evaluateJavascript('document.body.innerHTML');
//             _updateHtmlContent(content);
//           },
//           child: const Icon(Icons.refresh),
//         ),
//       ),
//     );
//   }
// }





// class uberWebView extends StatefulWidget {
//   const uberWebView({Key? key}) : super(key: key);

//   @override
//   uberWebViewState createState() => uberWebViewState();
// }

// class uberWebViewState extends State<uberWebView> {
//   late WebViewController _webViewController;
//    String _currentUrl = '';
//    String _currentHtml = '';
 

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WebView(
//           initialUrl: 'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D',
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (controller) {
//           _webViewController = controller;
//         },
//         onPageFinished: (url) async {
//           // var html = await _webViewController.evaluateJavascript(source: "window.document.getElementsByTagName('html')[0].outerHTML;");
//           setState(() {
//             _currentUrl = url;
//             // _currentHtml = html ?? '';
//           });
//           log('Current URL: $_currentUrl');
//           // log('Current HTML: $_currentHtml'.toString());
//         },
//         navigationDelegate: (request) async {
//           setState(() {
//             _currentUrl = request.url;
//           });
//           log('Update URL: $_currentUrl');
//           // print('Update HTML: $_currentHtml');
//           return NavigationDecision.navigate;
//         },
//         ),
//         bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             // Text(_currentUrl),
//             IconButton(
//               icon: const Icon(Icons.refresh),
//               onPressed: () async {
//                 String? html = await _webViewController.evaluateJavascript('document.documentElement.outerHTML');
//                 setState(() {
//                   _currentHtml = html;
//                 });
//                 _webViewController.reload();
//               },
//             ),
//           ],
//         ),
//       ),
        
        
//         floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//         floatingActionButton: SizedBox(
//           height: 45,
//           width: 45,
//           child: FittedBox(
//             child: FloatingActionButton(
//               backgroundColor: Colors.white,
//               focusColor: Colors.white,
//               onPressed: () async {
//                 const deepLink = 'uber://?client_id=<CLIENT_ID>&action=setPickup&pickup[latitude]=37.775818&pickup[longitude]=-122.418028&pickup[nickname]=UberHQ&pickup[formatted_address]=1455%20Market%20St%2C%20San%20Francisco%2C%20CA%2094103&dropoff[latitude]=37.802374&dropoff[longitude]=-122.405818&dropoff[nickname]=Coit%20Tower&dropoff[formatted_address]=1%20Telegraph%20Hill%20Blvd%2C%20San%20Francisco%2C%20CA%2094133&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383';
//                 if(await canLaunch(deepLink)){
//                   await launch(deepLink);
//                 }
//                 else{
//                   const fallbackUrl = 'uber://?client_id=<CLIENT_ID>&action=setPickup&pickup[latitude]=37.775818&pickup[longitude]=-122.418028&pickup[nickname]=UberHQ&pickup[formatted_address]=1455%20Market%20St%2C%20San%20Francisco%2C%20CA%2094103&dropoff[latitude]=37.802374&dropoff[longitude]=-122.405818&dropoff[nickname]=Coit%20Tower&dropoff[formatted_address]=1%20Telegraph%20Hill%20Blvd%2C%20San%20Francisco%2C%20CA%2094133&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383';
//                   if(await canLaunch(fallbackUrl)){
//                     await launch(fallbackUrl);
//                   }
//                   else{
//                     throw 'Could not launch $deepLink';
//                   }
//                 }
//               },
//               child: const CircleAvatar(
//                 backgroundImage: AssetImage(
//                   'assets/images/uber_icon_full.png',
//                 ),
//                 radius: 26,
//               ),
//             ),
//           ),
//         ),
//       ),
      
//     );
    
//   }

// }


// class uberWebView extends StatefulWidget {
//   const uberWebView({Key? key}) : super(key: key);

//   @override
//   uberWebViewState createState() => uberWebViewState();
// }

// class uberWebViewState extends State<uberWebView> {
//   late WebViewController _controller;
//   String _htmlCode = '';

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WebView(
//            initialUrl:
//               'https://m.uber.com/looking?drop%5B0%5D=%7B%22latitude%22%3A31.59379109999999%2C%22longitude%22%3A74.3506828%2C%22addressLine1%22%3A%22Scheme%20No.%202%22%2C%22addressLine2%22%3A%22Scheme%20No%202%2C%20Lahore%2C%20Punjab%22%2C%22id%22%3A%22ChIJdxhx-RobGTkR5v1Lii-g5CU%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&pickup=%7B%22latitude%22%3A31.53229169999999%2C%22longitude%22%3A74.3528196%2C%22addressLine1%22%3A%22Jail%20Road%22%2C%22addressLine2%22%3A%22Jail%20Rd%2C%20Block%20H%20Gulberg%202%2C%20Lahore%2C%20Punjab%22%2C%22id%22%3A%22EjRKYWlsIFJkLCBCbG9jayBIIEd1bGJlcmcgMiwgTGFob3JlLCBQdW5qYWIsIFBha2lzdGFuIi4qLAoUChIJSS1TpeoEGTkR5jAiNXi0VFgSFAoSCc8qSr38BBk5EWk44xfJjxc6%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&vehicle=10285',
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (controller) {
//           _controller = controller;
//         },
//           onPageFinished: (String url) async {
//           String html = await _controller.evaluateJavascript('document.documentElement.outerHTML');
//           setState(() {
//             _htmlCode = html;
//           });
//           log(_htmlCode.toString());
//         },
//         navigationDelegate: (NavigationRequest request) async {
          
//           // Clear the HTML code when navigating to a new page
//           setState(() {
//             _htmlCode = '';
//           });
//           // log(_htmlCode.toString());
//           return NavigationDecision.navigate;
//         },
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
//                 const deepLink = 'uber://?client_id=<CLIENT_ID>&action=setPickup&pickup[latitude]=37.775818&pickup[longitude]=-122.418028&pickup[nickname]=UberHQ&pickup[formatted_address]=1455%20Market%20St%2C%20San%20Francisco%2C%20CA%2094103&dropoff[latitude]=37.802374&dropoff[longitude]=-122.405818&dropoff[nickname]=Coit%20Tower&dropoff[formatted_address]=1%20Telegraph%20Hill%20Blvd%2C%20San%20Francisco%2C%20CA%2094133&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383';
//                 if(await canLaunch(deepLink)){
//                   await launch(deepLink);
//                 }
//                 else{
//                   const fallbackUrl = 'uber://?client_id=<CLIENT_ID>&action=setPickup&pickup[latitude]=37.775818&pickup[longitude]=-122.418028&pickup[nickname]=UberHQ&pickup[formatted_address]=1455%20Market%20St%2C%20San%20Francisco%2C%20CA%2094103&dropoff[latitude]=37.802374&dropoff[longitude]=-122.405818&dropoff[nickname]=Coit%20Tower&dropoff[formatted_address]=1%20Telegraph%20Hill%20Blvd%2C%20San%20Francisco%2C%20CA%2094133&product_id=a1111c8c-c720-46c3-8534-2fcdd730040d&link_text=View%20team%20roster&partner_deeplink=partner%3A%2F%2Fteam%2F9383';
//                   if(await canLaunch(fallbackUrl)){
//                     await launch(fallbackUrl);
//                   }
//                   else{
//                     throw 'Could not launch $deepLink';
//                   }
//                 }
//               },
//               child: const CircleAvatar(
//                 backgroundImage: AssetImage(
//                   'assets/images/uber_icon_full.png',
//                 ),
//                 radius: 26,
//               ),
//               // onPressed: () {
//               //      StoreRedirect.redirect(androidAppId:'com.ubercab&hl');
//               //   _controller.reload();
//               // },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// class uberWebView extends StatefulWidget {
//   const uberWebView({Key? key}) : super(key: key);

//   @override
//   uberWebViewState createState() => uberWebViewState();
// }

// class uberWebViewState extends State<uberWebView> {
//   final webViewKey = GlobalKey<WebViewContainerState>();
//   late WebViewController _webViewController;
//   String _htmlCode = '';

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WebViewContainer(
//           key: webViewKey,
//           onWebViewCreated: (controller) {
//           _webViewController = controller;
//         },
//           onPageFinished: (url) async {
//            var htmlCode = await _webViewController.evaluateJavascript('document.documentElement.outerHTML');
//           setState(() {
//             _htmlCode = htmlCode;
//           });
//           log(_htmlCode.toString()); 
//            // print HTML code in console
//         },
//         initialUrl:
//               'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D',
//         ),
        
//         floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//         floatingActionButton: SizedBox(
//           height: 40,
//           width: 40,
//           child: FittedBox(
//             child: FloatingActionButton(
//               backgroundColor: Colors.black,
//               focusColor: Colors.white,
//               onPressed: () async {
//                 const deepLink = 'uber://?action=setPickup&pickup=my_location';
//                 if(await canLaunch(deepLink)){
//                   await launch(deepLink);
//                 }
//                 else{
//                   const fallbackUrl = 'uber://?action=setPickup&pickup=my_location';
//                   if(await canLaunch(fallbackUrl)){
//                     await launch(fallbackUrl);
//                   }
//                   else{
//                     throw 'Could not launch $deepLink';
//                   }
//                 }
//               },
//               child: const CircleAvatar(
//                 backgroundImage: AssetImage(
//                   'assets/images/uber_icon_full.png',
//                 ),
//                 radius: 27,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class WebViewContainer extends StatefulWidget {
//   final Function(WebViewController) onWebViewCreated;
//   final Function(String) onPageFinished;
//   final String initialUrl;

//   const WebViewContainer({required Key key, required this.onWebViewCreated, required this.onPageFinished, required this.initialUrl}) : super(key: key);

//   @override
//   WebViewContainerState createState() => WebViewContainerState();
// }

// class WebViewContainerState extends State<WebViewContainer> {
//   late WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: widget.initialUrl,
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebViewCreated: (controller) {
//         _controller = controller;
//         widget.onWebViewCreated(controller);
//       },
//       onPageFinished: widget.onPageFinished,
//     );
//   }
// }