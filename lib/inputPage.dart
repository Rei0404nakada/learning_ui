import 'package:flutter/material.dart';
import 'package:learning_ui/bottom_tab_bar.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _controller = TextEditingController();

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomTabBar()),
                    );
                  },
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomTabBar()),
                    );
                  },
                  child: const Text('ポストする'),
                ),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'いまどうしてる？',
                border: InputBorder.none,
              ),
              onChanged: (text) {
                print('Current text: $text');
              },
            ),
          ],
        ),
      ),
    );
  }
}
