import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:uber_scrape/utils/gloablState.dart';

class HtmlScreen extends StatelessWidget {
  // final String htmlContent;

  const HtmlScreen({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTML View'),
      ),
      body: SingleChildScrollView(
        child: Html(data: GlobalState.uberHTML),
      ),
    );
  }
}
