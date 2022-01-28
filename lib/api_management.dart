import 'package:http/http.dart' as http;
import 'dart:convert';

class Football{
  final String name;
  final List id;
  final String type;

  const Football({
    required this.type,
    required this.id,
    required this.name,
  });

  factory Football.fromJson(Map<String, dynamic> json) {
    return Football(
      name: json['get'],
      id: json['response'],
      type: json['response'][2]['name'],
    );
  }
}

Future<Football> getFootball() async {
  var headers = {
    'x-rapidapi-key': 'a7dbeb2fab3e104747401da06f624046',
    'x-rapidapi-host': 'v3.football.api-sports.io'
  };
  var request = http.Request('GET', Uri.parse('https://v3.football.api-sports.io/countries'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    return Football.fromJson(jsonDecode(await response.stream.bytesToString()));
  }
  else {
    throw Exception('Failed to load album');
  }
}