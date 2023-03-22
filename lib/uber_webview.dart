// ignore_for_file: camel_case_types, avoid_print, prefer_collection_literals, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class uberWebView extends StatefulWidget {
  const uberWebView({Key? key}) : super(key: key);

  @override
  uberWebViewState createState() => uberWebViewState();
}

class uberWebViewState extends State<uberWebView> {
  late final WebViewController _controller;
  // final Uri _url1 = Uri.parse('https://auth.uber.com/v2/?breeze_local_zone=dca11&next_url=https%3A%2F%2Fm.uber.com%2F&state=lSiz3gpn8PSJM6ZYM3A_UkG24kwaH8AtQ54vYuGaf4s%3D');

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
             //
                  onPressed: () async {
                    print("helo");
                const deepLink = 'uber://?action=setPickup&pickup=my_location';
                if(await canLaunch(deepLink)){
                  await launch(deepLink);
                }
                else{
                  const fallbackUrl = 'uber://?action=setPickup&pickup=my_location';
                  if(await canLaunch(fallbackUrl)){
                    await launch(fallbackUrl);
                  }
                  else{
                    throw 'Could not launch $deepLink';
                  }
                }
              },
          
             // onPressed: _launchUber,
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/uber_icon_full.png',
                ),
                radius: 27,
              ),
              // onPressed: () {
              //      StoreRedirect.redirect(androidAppId:'com.ubercab&hl');
              //   _controller.reload();
              // },
            ),
          ),
        ),
      ),
    );
  }
   
              // onPressed: () async {
              //   String deepLink = 'https://m.uber.com/ul/?client_id=<CLIENT_ID>';
              //   if(await canLaunch(deepLink)){
              //     await launch(deepLink);
              //   }
              //   else{
              //     await launch('https://m.uber.com/?client_id=<CLIENT_ID>');
              //   }
              // },
              
              // https://www.uber.com/pk/en/
  JavascriptChannel _extractDataJSChannel(BuildContext context) {
    return JavascriptChannel(
          name: 'Flutter',
          onMessageReceived: (JavascriptMessage message) {
                String pageBody = message.message;
                print('page body: $pageBody');
          },
       );
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
