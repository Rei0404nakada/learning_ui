import 'package:flutter/material.dart';
import 'package:learning_ui/inputPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int selectedIndex = 0;
  int onPressedCounter = 0;

  List<Widget> display = [Home(), Signal(), Network(), Battery()];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onPressedController() {
    onPressedCounter += 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          backgroundColor: Colors.black,
        ),
      ),
      body: display[selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp),
              label: 'home',
              tooltip: 'home',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.signal_cellular_alt),
              label: 'signal',
              tooltip: 'signal',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.network_check_sharp),
              label: 'network',
              tooltip: 'network',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.battery_charging_full_outlined),
              label: 'battery',
              tooltip: 'battery',
              backgroundColor: Colors.black,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          enableFeedback: false,
          iconSize: 25,
          selectedItemColor: Colors.amber,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          unselectedItemColor: Colors.grey,
        ),
      ),
      floatingActionButton: Visibility(
        visible: selectedIndex == 0,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const InputPage()),
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

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
                  return Column(
                    children: <Widget>[
                      for (int i = 0; i < data!.length; i++) ...{
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          )),
                          child: Text(
                            data[i],
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

class Signal extends StatelessWidget {
  const Signal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('signal'),
        ],
      ),
    );
  }
}

class Network extends StatelessWidget {
  const Network({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('network'),
        ],
      ),
    );
  }
}

class Battery extends StatelessWidget {
  const Battery({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('battery'),
        ],
      ),
    );
  }
}
