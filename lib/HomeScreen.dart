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
  List<Widget> pages = [
    firstlayout(),
    secoundlayout(),
    setting()
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:pages[index],
      //  Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Container(
      //         margin: const EdgeInsets.only(top: 100),
      //         child: Image.asset(
      //           "images/logo.png",
      //           width: screenWidth - 40,
      //           height: screenWidth - 40,
      //         )),
      //     Container(
      //       margin: const EdgeInsets.only(bottom: 50),
      //       child: Column(
      //         children: [
      //           ElevatedButton(
      //             onPressed: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => const RegistrationScreen()));
      //             },
      //             style: ElevatedButton.styleFrom(
      //                 minimumSize: Size(screenWidth - 30, 50)),
      //             child: const Text("Register"),
      //           ),
      //           Container(
      //             height: 20,
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => const recognition()));
      //             },
      //             style: ElevatedButton.styleFrom(
      //                 minimumSize: Size(screenWidth - 30, 50)),
      //             child: const Text("Recognize"),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
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
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Register"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ]),
    );
  }
}
