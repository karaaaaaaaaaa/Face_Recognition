import 'package:Face_Recognition/all/HomeScreen.dart';
import 'package:Face_Recognition/login/loginscreen.dart';
import 'package:Face_Recognition/socialCubit/cubit.dart';
import 'package:Face_Recognition/socialCubit/state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Settings/Settings_Screen.dart';
import 'all/components/bloc_observer.dart';
import 'all/components/constants/constants.dart';

import 'layout/secound.dart';
import 'network/local/cash_helper.dart';
import 'network/remote/dio_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  Widget widget;

  uid = CashHelper.getData(
    key: 'uId',
  );
  print(uid);
  print(
      "/////////////////////////// uid ///////////////////////////////////////");
  if (uid != null) {
    widget = HomeScreen();
  } else {
    widget = loginScreen();
  }
  runApp(myApp(
    startWidget: widget,
  ));
}

class myApp extends StatelessWidget {
  // const myApp({super.key});
  Widget? startWidget;
  myApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
    
          BlocProvider(create: (context) => Socialcubit()..GetuserData())
        ],
        child: BlocConsumer<Socialcubit, cubitStates>(
            builder: (context, state) {
              ThemeData lite = ThemeData(
                  appBarTheme: AppBarTheme(
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ));
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lite,
                home: loginScreen(),
              );
            },
            listener: (context, state) {}));
  }
}
