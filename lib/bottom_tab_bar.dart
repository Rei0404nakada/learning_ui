import 'package:flutter/material.dart';
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
      body: display[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('home'),
        ],
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
