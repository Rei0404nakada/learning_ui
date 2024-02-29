import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<String>? tweet;
  List<bool> select = [];
  void selectList() {
    for (var i = 0; i < tweet!.length; i++) {
      select.add(false);
    }
  }

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
                  selectList();
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
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 45),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data[dataLength - i - 1],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.chat_bubble_outline),
                                    iconSize: 18,
                                    color: Colors.grey,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.cached),
                                    iconSize: 18,
                                    color: Colors.grey,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        select[dataLength - i - 1] =
                                            !select[dataLength - i - 1];
                                        print(i);
                                      });
                                    },
                                    icon: select[dataLength - i - 1]
                                        ? const Icon(Icons.favorite)
                                        : const Icon(Icons.favorite_outline),
                                    iconSize: 18,
                                    color: select[dataLength - i - 1]
                                        ? Colors.pink
                                        : Colors.grey,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.save_alt_sharp),
                                    iconSize: 18,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      }
                    ],
                  );
                } else {
                  return const Text(
                    'まだなにもおきていません',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
