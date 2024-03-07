import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late List<String>? tweet;
  List<bool> favoriteSelect = [];
  List<bool> cachedSelect = [];
  String userName = 'rei';
  String userId = '@Gamusiro__';

  void saveFavorite() async {
    List<String> favoriteString = [];
    for (var i = 0; i < favoriteSelect.length; i++) {
      if (favoriteSelect[i]) {
        favoriteString.add('true');
      } else {
        favoriteString.add('false');
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriteSave', favoriteString);
  }

  Future<List<String>?> getText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tweet = prefs.getStringList('tweetText');
    if (favoriteSelect.length != tweet!.length) {
      for (var i = 0; i < tweet!.length; i++) {
        favoriteSelect.add(false);
      }
      print('favoriteSelect$favoriteSelect');
      print('tweet!$tweet');
    }
    if (cachedSelect.length != tweet!.length) {
      for (var i = 0; i < tweet!.length; i++) {
        cachedSelect.add(false);
      }
      print('cachedSelect$cachedSelect');
    }
    return tweet;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
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
                          padding: const EdgeInsets.only(
                              top: 20, right: 10, bottom: 0, left: 20),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      userName,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    userId,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 45),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        data[dataLength - i - 1],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
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
                                    onPressed: () {
                                      setState(() {
                                        cachedSelect[dataLength - i - 1] =
                                            !cachedSelect[dataLength - i - 1];
                                      });
                                    },
                                    icon: const Icon(Icons.cached),
                                    iconSize: 18,
                                    color: cachedSelect[dataLength - i - 1]
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        favoriteSelect[dataLength - i - 1] =
                                            !favoriteSelect[dataLength - i - 1];
                                        saveFavorite();
                                        print(i);
                                      });
                                    },
                                    icon: favoriteSelect[dataLength - i - 1]
                                        ? const Icon(Icons.favorite)
                                        : const Icon(Icons.favorite_outline),
                                    iconSize: 18,
                                    color: favoriteSelect[dataLength - i - 1]
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
