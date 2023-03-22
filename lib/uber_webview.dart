// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, avoid_print, prefer_collection_literals, deprecated_member_use, avoid_types_as_parameter_names, must_be_immutable

import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


// class uberWebView extends StatefulWidget {
//   const uberWebView({super.key});


//   @override
//   uberWebViewState createState() => uberWebViewState();
// }

// class uberWebViewState extends State<uberWebView> {
//   late WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WebView(
//            initialUrl:'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D',
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//           _loadHtmlFromAssets();
//         },
//         // onPageFinished: (String url) async {
//         //   String html = await _controller.evaluateJavascript('document.documentElement.outerHTML');
//         //   log(html.toString());
//         // },
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
//                 radius: 27,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   _loadHtmlFromAssets() async {
//     String fileText = await rootBundle.loadString('assets/html/help.html');
//     _controller.loadUrl( Uri.dataFromString(
//         fileText,
//         mimeType: 'text/html',
//         encoding: Encoding.getByName('utf-8')
//     ).toString());
//   }
// }




class uberWebView extends StatefulWidget {
  const uberWebView({Key? key}) : super(key: key);

  @override
  uberWebViewState createState() => uberWebViewState();
}

class uberWebViewState extends State<uberWebView> {
  late WebViewController _controller;
  String _htmlCode = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
           initialUrl:
              'https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
          _controller = controller;
        },
          onPageFinished: (String url) async {
          String html = await _controller.evaluateJavascript('document.documentElement.outerHTML');
          setState(() {
            _htmlCode = html;
          });
          log(_htmlCode.toString());
        },
        navigationDelegate: (NavigationRequest request) async {
          
          // Clear the HTML code when navigating to a new page
          setState(() {
            _htmlCode = '';
          });
          // log(_htmlCode.toString());
          return NavigationDecision.navigate;
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
                radius: 27,
              ),
            ),
          ),
        ),
      ),
    );
  }
}




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