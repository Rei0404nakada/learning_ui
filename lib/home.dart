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
  String userImagePass = 'assets/image/IMG_3614.jpg';

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
    double _deviceWidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: false,
          floating: true,
          snap: true,
          backgroundColor: Color(0xFF15202B),
          expandedHeight: 40,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'aaa',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Align(
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
                                    top: 10, right: 10, bottom: 0, left: 10),
                                width: _deviceWidth,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      width: _deviceWidth * 0.12,
                                      height: _deviceWidth * 0.12,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage(userImagePass),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 14,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: Text(
                                                        userName,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      userId,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    const Text(
                                                      '・00分',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  data[dataLength - i - 1],
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.chat_bubble_outline),
                                                iconSize: 18,
                                                color: Colors.grey,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    cachedSelect[dataLength -
                                                            i -
                                                            1] =
                                                        !cachedSelect[
                                                            dataLength - i - 1];
                                                  });
                                                },
                                                icon: const Icon(Icons.cached),
                                                iconSize: 18,
                                                color: cachedSelect[
                                                        dataLength - i - 1]
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    favoriteSelect[dataLength -
                                                            i -
                                                            1] =
                                                        !favoriteSelect[
                                                            dataLength - i - 1];
                                                    saveFavorite();
                                                    print(i);
                                                  });
                                                },
                                                icon: favoriteSelect[
                                                        dataLength - i - 1]
                                                    ? const Icon(Icons.favorite)
                                                    : const Icon(
                                                        Icons.favorite_outline),
                                                iconSize: 18,
                                                color: favoriteSelect[
                                                        dataLength - i - 1]
                                                    ? Colors.pink
                                                    : Colors.grey,
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.save_alt_sharp),
                                                iconSize: 18,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            },
                            const SizedBox(
                              height: 54,
                            )
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
          ),
        )
      ],
    );
  }
}
