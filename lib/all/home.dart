import 'package:Face_Recognition/RecognitionScreen.dart';
import 'package:Face_Recognition/RegistrationScreen.dart';
import 'package:Face_Recognition/all/admin.dart';
import 'package:Face_Recognition/all/cubits/recognitioncubit/RecognitionCubit.dart';
import 'package:Face_Recognition/all/cubits/registercubit%20copy/RegisterCubit.dart';
import 'package:Face_Recognition/all/cubits/registerstate%20copy/registestate.dart';
import 'package:Face_Recognition/all/recognition.dart';
import 'package:Face_Recognition/all/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ML/Recognition.dart';

// import 'ML/Recognition.dart';
int index = 0;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static Map<String, Recognition> registered = Map();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegisterCubit(),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(),
          ),
        ],
        child: BlocConsumer<RegisterCubit, registerstate>(
          builder: (context, state) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: Image.asset(
                        "images/logo.png",
                        width: screenWidth - 40,
                        height: screenWidth - 40,
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(screenWidth - 30, 50)),
                          child: const Text("Register"),
                        ),
                        Container(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecognitionScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(screenWidth - 30, 50)),
                          child: const Text("Recognize"),
                        ),
                        Container(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => admin(
                                        age: null!,
                                        isMale: null!,
                                        result: null!)));
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(screenWidth - 30, 50)),
                          child: const Text("admin"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: index,
                  onTap: (value) {
                    index = value;
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: "home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "home"),
                  ]),
            );
          },
          listener: (context, state) {},
        ));
  }
}
