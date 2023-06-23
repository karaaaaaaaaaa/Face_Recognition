import 'package:Face_Recognition/all/HomeScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../RegisterCubit/cubit.dart';
import '../RegisterCubit/state.dart';
import '../all/components/components/components.dart';

class socialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailControl = TextEditingController();
  var phoneControl = TextEditingController();
  var nameControl = TextEditingController();
  var passwordControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          socialRegisterCubit(socialRegisterInitialState),
      child: BlocConsumer<socialRegisterCubit, socialRegisterStates>(
        listener: (context, state) {
          if (state is socialcreateuserSuccessState) {
            navigateAndFinish(context, HomeScreen());
          }
       },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Register',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.black),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              'Register now To register your presence, sir',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormText(
                                control: nameControl,
                                onTap: () {},
                                onChanged: (value) {
                                  print(value);
                                },
                                onSubmit: () {},
                                type: TextInputType.name,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Name Can not be Empty';
                                  else
                                    return null;
                                },
                                label: 'Name',
                                prefix: Icons.person),
                            SizedBox(
                              height: 15,
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
                                onSubmit: (value) {},
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Password is to Short';
                                  else
                                    return null;
                                },
                                isPassword:
                                    socialRegisterCubit.get(context).isPassword,
                                label: 'Password',
                                prefix: Icons.lock,
                                suffix: socialRegisterCubit.get(context).suffix,
                                suffixClicked: () {
                                  socialRegisterCubit
                                      .get(context)
                                      .changePasswordVisibility();
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormText(
                                control: phoneControl,
                                onTap: () {},
                                onChanged: (value) {
                                  print(value);
                                },
                                onSubmit: () {},
                                type: TextInputType.phone,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Phone Can not be Empty';
                                  else
                                    return null;
                                },
                                label: 'phone',
                                prefix: Icons.phone),
                            SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! socialRegisterLoadingState,
                              builder: (context) => defaultButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    socialRegisterCubit
                                        .get(context)
                                        .userRegister(
                                            email: emailControl.text,
                                            password: passwordControl.text,
                                            phone: phoneControl.text,
                                            name: nameControl.text);
                                  }
                                },
                                text: 'Register',
                              ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ]),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
