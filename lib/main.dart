import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'api_management.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late Future<User> jsonResponseResult;
  late Future<Football> fetchFootball;

  @override
  void initState() {
    super.initState();
    // jsonResponseResult = fetchUser();
    fetchFootball = getFootball();
  }

  @override
  Widget build(BuildContext context) {
    // String news = await ApiListener().getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Text(news),
              FutureBuilder(
                  future: fetchFootball,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        color: Colors.grey[200],
                        height: 700,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: ListView.builder(
                              itemCount: 160,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                            snapshot.data!.id[index]['name']),
                                        subtitle: Text(
                                            snapshot.data!.id[index]['code']),
                                        leading: Text(index.toString()),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
//
// class User {
//   final String login;
//   final int id;
//   final String type;
//
//   const User({
//     required this.type,
//     required this.id,
//     required this.login,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       login: json['location'],
//       id: json['id'],
//       type: json['type'],
//     );
//   }
// }

// Future<User> fetchUser() async {
//   final response = await http
//       .get(Uri.parse('https://api.github.com/users/sachitbansal'));
//
//   if (response.statusCode == 200) {
//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
