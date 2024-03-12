import 'package:flutter/material.dart';
import 'package:learning_ui/bottom_tab_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void saveText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = prefs.getStringList('tweetText') ?? [];
    data.add(_controller.text);
    prefs.setStringList('tweetText', data);
  }

  bool emptyChecker() {
    RegExp regExp = RegExp(r'^\s*$');
    if (_controller.text.isEmpty == true || regExp.hasMatch(_controller.text)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    print(_deviceWidth);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 20, 30),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 20, 30),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomTabBar()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: emptyChecker() == true
                      ? null
                      : () {
                          saveText();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomTabBar()),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      disabledBackgroundColor:
                          Colors.blueAccent.withOpacity(0.6),
                      disabledForegroundColor: Colors.white.withOpacity(0.6)),
                  child: const Text('ポストする'),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: _deviceWidth * 0.1,
                    height: _deviceWidth * 0.1,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/image/IMG_3614.jpg'),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    maxLines: null,
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'いまどうしてる？',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      setState(() {});
                    },
                    autofocus: true,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
