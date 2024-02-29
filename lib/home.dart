import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late List<String>? tweet;
  List<bool> select = [];

  void saveFavorite() async {
    List<String> favoriteString = [];
    for (var i = 0; i < select.length; i++) {
      if (select[i]) {
        favoriteString.add('true');
      } else {
        favoriteString.add('false');
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriteSave', favoriteString);
    print('favoriteString$favoriteString');
  }

  Future<List<String>?> getText() async {
    // List<bool> favoriteBool = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // List<String> favorite = prefs.getStringList('favoriteSave') ?? [];
    tweet = prefs.getStringList('tweetText');
    // print('favorite$favorite');
    // for (var i = 0; i < favorite.length; i++) {
    //   if (favorite[i] == 'true') {
    //     favoriteBool.add(true);
    //   } else {
    //     favoriteBool.add(false);
    //   }
    // }

    // if (favoriteBool.isNotEmpty) {
    //   print('favoriteBool$favoriteBool');
    //   select = favoriteBool;
    // }
    if (select.length != tweet!.length) {
      // select.add(false);
      // select = [false, false, false, false, false, false];
      for (var i = 0; i < tweet!.length; i++) {
        select.add(false);
      }
      print('select$select');
      print('tweet!$tweet');
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
                                        saveFavorite();
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
