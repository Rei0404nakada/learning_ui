import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<String>? tweet;

  Future<List<String>?> getText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tweet = prefs.getStringList('tweetText');
    return tweet;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<String>?>(
              future: getText(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<String>?> snapshot) {
                if (snapshot.hasData) {
                  List<String>? data = snapshot.data;
                  int dataLength = data!.length;
                  return Column(
                    children: <Widget>[
                      for (int i = 0; i < dataLength; i++) ...{
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          child: Text(
                            data[dataLength - i - 1],
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      }
                    ],
                  );
                } else {
                  return const Text('まだなにもおきていません');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
