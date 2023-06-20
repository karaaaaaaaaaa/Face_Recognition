import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../all/components/components/components.dart';

import '../socialCubit/cubit.dart';
import '../socialCubit/state.dart';



class EditProfileScreen extends StatelessWidget {
  // const EditProfileScreen({super.key});
  var biocontr = TextEditingController();
  var namecontr = TextEditingController();
  var phonecontr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Socialcubit, cubitStates>(
        builder: (context, state) {
          var model = Socialcubit.get(context).model;
          var profileImageFile = Socialcubit.get(context).profileImageFile;
          var CoverImageFile = Socialcubit.get(context).CoverImageFile;
          phonecontr.text = Socialcubit.get(context).model!.phone;
          namecontr.text = Socialcubit.get(context).model!.name;
          biocontr.text = Socialcubit.get(context).model!.bio;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Edit Profile",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                defaultTextButton(
                    onTap: () {
                      Socialcubit.get(context).updateUser(
                          name: namecontr.text,
                          phone: phonecontr.text,
                          bio: biocontr.text);
                    },
                    text: "UPDATE"),
                SizedBox(
                  width: 10,
                )
              ],
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
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
                                    image: CoverImageFile == null
                                        ? NetworkImage('${model!.Coverimage}')
                                        : FileImage(CoverImageFile)
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Socialcubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                    radius: 22,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 25,
                                    ))),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 71,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 66,
                                backgroundImage: profileImageFile == null
                                    ? NetworkImage(
                                        ('${model!.image}'),
                                      )
                                    : FileImage(profileImageFile)
                                        as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Socialcubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                    radius: 22,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 25,
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (Socialcubit.get(context).profileImageFile != null ||
                      Socialcubit.get(context).CoverImageFile != null)
                    Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        if (Socialcubit.get(context).profileImageFile != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  onTap: () {
                                      Socialcubit.get(context).uploadProfileImage(
                                        name: namecontr.text,
                                        phone: phonecontr.text,
                                        bio: biocontr.text);
                                  },
                                  text: "UpLoad Profile ",
                                  textSize: 15,
                                  radius: 10),
                              SizedBox(
                                height: 4,
                              ),
                              if (state is SocialUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                        SizedBox(
                          width: 7,
                        ),
                        if (Socialcubit.get(context).CoverImageFile != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  onTap: () {
                                    Socialcubit.get(context).uploadCoverImage(
                                        name: namecontr.text,
                                        phone: phonecontr.text,
                                        bio: biocontr.text);
                                  },
                                  text: "UpLoad Cover ",
                                  textSize: 15,
                                  radius: 10),
                              SizedBox(
                                height: 4,
                              ),
                              if (state is SocialUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                        SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                  if (Socialcubit.get(context).profileImageFile != null ||
                      Socialcubit.get(context).CoverImageFile != null)
                    SizedBox(
                      height: 5,
                    ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormText(
                              control: namecontr,
                              type: TextInputType.name,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please Edit name";
                                }
                                return null;
                              },
                              label: "Name",
                              prefix: Icons.person),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormText(
                              control: biocontr,
                              type: TextInputType.name,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please Edit Bio";
                                }
                                return null;
                              },
                              label: "you Job",
                              prefix: Icons.work),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultFormText(
                              control: phonecontr,
                              type: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please Edit phone";
                                }
                                return null;
                              },
                              label: "phone",
                              prefix: Icons.phone),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
