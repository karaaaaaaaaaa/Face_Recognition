import 'package:Face_Recognition/RecognitionScreen.dart';
import 'package:Face_Recognition/RegistrationScreen.dart';
import 'package:Face_Recognition/Settings/Settings_Screen.dart';
import 'package:Face_Recognition/all/recognition.dart';
import 'package:Face_Recognition/layout/fristpage.dart';
import 'package:Face_Recognition/layout/secound.dart';
import 'package:Face_Recognition/socialCubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ML/Recognition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static Map<String, Recognition> registered = Map();
  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  @override
  int index = 0;
  List<Widget> pages = [firstlayout(), secoundlayout(), setting()];
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 18,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Register"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ]),
    );
  }
}
