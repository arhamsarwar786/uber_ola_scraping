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
        // await Navigator.push(context, MaterialPageRoute(builder: (context) => const RootScreen()));
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