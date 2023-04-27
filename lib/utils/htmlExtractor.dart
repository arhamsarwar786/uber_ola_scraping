import "package:http/http.dart" as http;

getHtml(url) async {
  final response = await http.get(Uri.parse('$url'), headers: {
    "accept":
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
  });

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return null;
  }
}
