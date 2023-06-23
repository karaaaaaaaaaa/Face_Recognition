
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../HomeScreen.dart';
import '../social_Register/ShopRegisterScreen.dart';
import '../LoginCubit/cubit.dart';
import '../LoginCubit/state.dart';
import '../all/components/components/components.dart';
import '../network/local/cash_helper.dart';

class loginScreen extends StatelessWidget {
  // const loginScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailControl = TextEditingController();
  var passwordControl = TextEditingController();
  // var emailControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => socialLoginCubit(socialInitialState),
      child: BlocConsumer<socialLoginCubit, socialLoginStates>(
          builder: (context, State) => Scaffold(
            
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.black),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              'Login now To register your presence, sir',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultFormText(
                                control: emailControl,
                                onTap: () {},
                                onChanged: (value) {
                                  print(value);
                                },
                                onSubmit: () {},
                                type: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Email Can not be Empty';
                                  else
                                    return null;
                                },
                                label: 'Email',
                                prefix: Icons.email),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormText(
                                control: passwordControl,
                                type: TextInputType.visiblePassword,
                                onTap: () {},
                                onChanged: (value) {
                                  print(value);
                                },
                                onSubmit: (value) {
                                  if (formKey.currentState!.validate()) {
                                    socialLoginCubit.get(context).userLogin(
                                        email: emailControl.text,
                                        password: passwordControl.text);
                                  }
                                },
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Password is to Short';
                                  else
                                    return null;
                                },
                                isPassword:
                                    socialLoginCubit.get(context).isPassword,
                                label: 'Password',
                                prefix: Icons.lock,
                                suffix: socialLoginCubit.get(context).suffix,
                                suffixClicked: () {
                                  socialLoginCubit
                                      .get(context)
                                      .changePasswordVisibility();
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: State is! socialLoadingState,
                              builder: (context) => defaultButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    socialLoginCubit.get(context).userLogin(
                                        email: emailControl.text,
                                        password: passwordControl.text);
                                    
                                  }
                                },
                                text: 'Login',
                              ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't Have an Account?",
                                  style: TextStyle(fontSize: 15),
                                ),
                                defaultTextButton(
                                    onTap: () {
                                      navigateTo(
                                          context, socialRegisterScreen());
                                    },
                                    text: 'Register')
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              )),
          listener: (BuildContext context, state) {
            if (state is socialLoginErrorState) {
              showToast(text: state.error, state: ToastState.Error);
            }
            if (state is socialloginSuccessState) {
              CashHelper.saveData(key: 'uId', value: state.uid).then((value) {
                navigateAndFinish(context, HomeScreen());
              }).catchError((onError) {
                print(onError);
              });
            }
          }),
    );
  }
}
