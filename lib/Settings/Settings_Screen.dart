import 'dart:math';

import 'package:Face_Recognition/Settings/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../all/components/components/components.dart';
import '../layout/EditProfileScreen.dart';
import '../login/loginscreen.dart';
import '../socialCubit/cubit.dart';
import '../socialCubit/state.dart';

class setting extends StatelessWidget {
  const setting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Socialcubit, cubitStates>(
        builder: (context, state) {
          // SocialuserModel model;
          var model = Socialcubit.get(context).model!;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('${model.Coverimage}')),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 71,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 66,
                          backgroundImage: NetworkImage(
                            ('${model.image}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                defaultText(
                    text: '${model.name}', size: 18, fw: FontWeight.w600),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${model.bio}",
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height:50,
                ),
               
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Edit your Information'),
                    )),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: Icon(
                          Icons.edit,
                          size: 16,
                        )),

                  ],
                ),
                 SizedBox(height: 50,),
                 OutlinedButton(
                  style: ButtonStyle(padding:MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 100))),
                  onPressed:  () {
                      navigateAndFinish(context, loginScreen());
                    }, child: Text("logout"),),
               
              ]),
            ),
          );
        },
        listener: (context, state) {});
  }
}
