import 'package:flutter/material.dart';
import 'package:learning_ui/home.dart';
import 'package:learning_ui/inputPage.dart';

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
      backgroundColor: Color.fromARGB(255, 0, 20, 30),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 20, 30),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 0, 16, 24),
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 0, 20, 30)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/image/IMG_3614.jpg'),
              ),
              accountName: Text('rei'),
              accountEmail: Text('@Gamusiro__'),
            ),
            ListTile(
              leading: const Icon(
                Icons.perm_identity_outlined,
                color: Colors.white,
              ),
              title: const Text(
                'プロフィール',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
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
              icon: Icon(
                Icons.home_sharp,
              ),
              label: 'home',
              tooltip: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'いいね',
              tooltip: 'いいね',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cached),
              label: 'リツイート',
              tooltip: 'リツイート',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delete_outline),
              label: '消去',
              tooltip: '消去',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 0, 20, 30),
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
