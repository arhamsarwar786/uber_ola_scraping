import 'dart:developer';

import "package:flutter/material.dart";
  import 'package:http/http.dart' as http;


class DemoTest extends StatelessWidget {
  const DemoTest({super.key});


Future<String> fetchURLContent() async {
  final response = await http.get(Uri.parse('https://book.olacabs.com/?utm_source=partner_header&pickup_name=Mumbai%20Central%20railway%20station%20building%2C%20Mumbai%20Central%20Mumbai%20Maharashtra%20India&lat=18.969539&lng=72.819329&drop_lat=19.0972728&drop_lng=72.8747333&drop_name=Mumbai%20Airport%20Lounge%20-%20Adani%20Lounge%2C%20%E0%A4%9B%E0%A4%A4%E0%A5%8D%E0%A4%B0%E0%A4%AA%E0%A4%A4%E0%A4%BF%20%E0%A4%B6%E0%A4%BF%E0%A4%B5%E0%A4%BE%E0%A4%9C%E0%A5%80%20%E0%A4%85%E0%A4%82%E0%A4%A4%E0%A4%B0%E0%A5%8D%E0%A4%B0%E0%A4%BE%E0%A4%B7%E0%A5%8D%E0%A4%9F%E0%A5%8D%E0%A4%B0%E0%A5%80%E0%A4%AF%20%E0%A4%B9%E0%A4%B5%E0%A4%BE%E0%A4%88%E0%A4%85%E0%A4%A1%E0%A5%8D%E0%A4%A1%E0%A4%BE%20%E0%A4%95%E0%A5%8D%E0%A4%B7%E0%A5%87%E0%A4%A4%E0%A5%8D%E0%A4%B0%20%E0%A4%AC%E0%A4%BE%E0%A4%82%E0%A4%A6%E0%A5%8D%E0%A4%B0%E0%A4%BE%20%E0%A4%9F%E0%A4%B0%E0%A5%8D%E0%A4%AE%E0%A4%BF%E0%A4%A8%E0%A4%B8%20Vile%20Parle%20East%20Vile%20Parle%20Mumbai%20Maharashtra%20India&pickup='),headers: {
    "accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
  });

  if (response.statusCode == 200) {
  debugger();
    return response.body;
  } else {
  debugger();

    throw Exception('Failed to fetch URL');
  }

}


  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(onPressed: (){
      fetchURLContent();
    },child: Text("HIT"),),);
  }
}