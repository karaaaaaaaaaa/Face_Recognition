import 'package:Face_Recognition/ShopLoginCubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project/modules/ShopLoginCubit/state.dart';


// import '../../shared/components/constants/constants.dart';
// import '../../shared/network/remote/dio_helper.dart';

class socialLoginCubit extends Cubit<socialLoginStates> {
  socialLoginCubit(initialState) : super(socialInitialState());
  static socialLoginCubit get(context) => BlocProvider.of(context);
  // late socialLoginModel loginModel;

  void userLogin({required String email, required String password}) {
    emit(socialLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(socialloginSuccessState(value.user!.uid));
      print(value.user!.email);
    }).catchError((error) {
      print(error.toString());
      emit(socialLoginErrorState(error.toString()));
    });
    //  DioHelper.postData(
    //    lang: 'en',
    //     token: '',
    //      url: Login,
    //      data: {
    //        'email':email,
    //        'password':password,
    //      }).then((value) {
    //    loginModel= socialLoginModel.formJson(value.data);
    //       print(loginModel.status);
    //        emit(socialSuccessState(loginModel));
    //  }).catchError((error){
    //    print(error.toString());
    //    emit(socialLoginErrorState(error.toString()));
    //  });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(socialLoginPasswordVisibility());
  }
}
