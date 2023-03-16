import 'package:flutter/material.dart';
import 'package:uber_scrape/utils/color_constants.dart';

class SearchScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title;
  const SearchScreen(this.title, {super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          // _handlePressButton(context);
        }),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.title)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: "Search ${widget.title}",
                    border: const OutlineInputBorder()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
