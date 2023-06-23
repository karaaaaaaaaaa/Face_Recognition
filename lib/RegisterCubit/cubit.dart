import 'package:Face_Recognition/RegisterCubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/userModel.dart';

class socialRegisterCubit extends Cubit<socialRegisterStates> {
  socialRegisterCubit(initialState) : super(socialRegisterInitialState());
  static socialRegisterCubit get(context) => BlocProvider.of(context);
  // late socialLoginModel  loginModel;

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(socialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      Createuser(
        email: email,
        name: name,
        uid: value.user!.uid,
        phone: phone,
      );
      // emit(socialRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(socialRegisterErrorState(error.toString()));
    });
    ;
  }

  void Createuser({
    required String email,
    required String name,
    required String phone,
    String bio = 'write your Job....',
    String image =
        "https://img.freepik.com/premium-photo/young-caucasian-man-holding-invisaling-isolated-pink-background-looking-up-while-smiling_1368-352865.jpg?w=996",
    String Coverimage =
        "https://img.freepik.com/premium-photo/happy-mother-her-little-son-having-fun-autumn-forest-mom-child-hugging_106029-228.jpg?w=826",
    String? uid,
    bool IsEmailVerfied = false,
  }) {
    SocialuserModel model = SocialuserModel(
        email: email,
        name: name,
        phone: phone,
        uid: uid!,
        IsEmailVerfied: IsEmailVerfied,
        image: image,
        bio: bio,
        Coverimage: Coverimage);
        FirebaseFirestore.instance.collection("user").doc(uid).set(model.toMap()).then((value) {
           emit(socialcreateuserSuccessState());
        }).catchError((error) {
      print("sssssssssssssssssssssss${error.toString()}ssssssssssss");
      emit(socialcreateuserErrorState(error.toString()));
    });
    // FirebaseFirestore.instance
    //     .collection("user")
    //     .doc(uid)
    //     .set(model.toMap())
    //     .then((value) {
    //   emit(socialcreateuserSuccessState());
    // }).catchError((error) {
    //   print("sssssssssssssssssssssss${error.toString()}ssssssssssss");
    //   emit(socialcreateuserErrorState(error.toString()));
    // });
    
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(socialRegisterPasswordVisibility());
  }
}
