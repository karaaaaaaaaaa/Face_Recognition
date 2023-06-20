import 'dart:io';
import 'dart:math';
import 'package:Face_Recognition/socialCubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../all/components/constants/constants.dart';
import '../models/CommentModel.dart';
import '../models/userModel.dart';




class Socialcubit extends Cubit<cubitStates> {
  Socialcubit() : super(initstate());
  static Socialcubit get(context) => BlocProvider.of(context);
  SocialuserModel? model;
  void GetuserData() {
    emit(Getuserloadingstate());
    FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
      print(value.data());
      model = SocialuserModel.FromJson(value.data()!);
      emit(GetuserSuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(Getusererrorstate(error));
    });
  }

 

  int navindex = 0;
  void changebottomnav(value) {
    if (value == 1) {
      Getalluser();
    }
    if (value == 2) {
      emit(bottomnavPOSTstate());
    } else {
      navindex = value;

      emit(bottomnavstate());
    }
  }

  File? profileImageFile;
  var picker = ImagePicker();
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImageFile = File(pickedFile.path);
      print(pickedFile.path.toString());
      emit(SocialEditUserProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialEditUserProfileImageErrorState());
    }
  }

  File? CoverImageFile;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CoverImageFile = File(pickedFile.path);
      print(pickedFile.path.toString());
      emit(SocialEditUserCoverImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialEditUserCoverImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("user/${Uri.file(profileImageFile!.path).pathSegments.last}")
        .putFile(profileImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialuploadUserProfileImageSuccessState());
        updateUser(bio: bio, name: name, phone: phone, image: value);
        print(value);
      }).catchError((error) {
        emit(SocialuploadUserProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialuploadUserProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("user/${Uri.file(CoverImageFile!.path).pathSegments.last}")
        .putFile(CoverImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialuploadUserCoverImageSuccessState());
        updateUser(bio: bio, name: name, phone: phone, cover: value);
        print(value);
      }).catchError((error) {
        emit(SocialuploadUserCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialuploadUserCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(SocialUpdateLoadingState());
    SocialuserModel modelMap = SocialuserModel(
        name: name,
        phone: phone,
        bio: bio,
        Coverimage: cover ?? model!.Coverimage,
        image: image ?? model!.image,
        email: model!.email,
        uid: model!.uid,
        IsEmailVerfied: false);
    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uid)
        .update(modelMap.toMap())
        .then((value) {
      GetuserData();
    }).catchError((error) {
      emit(SocialUpdateErrorState());
    });
  }

  File? postImageFile;

  Future getpostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImageFile = File(pickedFile.path);
      print(pickedFile.path.toString());
      emit(SocialcreatepostImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialcreatepostImageErrorState());
    }
  }



  void createComment(
      {required String postId,
      required String comment,
      required String dataTime}) {
    // emit(SocialCreateCommentPostsLoadingState());
    // commentList.add(comment);
    // print(_commentModel!.text??'null');
    CommentModel commentModel = CommentModel(
      name: model!.name,
      image: model!.image,
      uid: model!.uid,
      text: comment,
      dateTime: dataTime,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Comments')
        .doc(model!.uid)
        .collection('user Comment')
        .add(commentModel.toMap())
        .then((value) {
      emit(SocialcommentPostsSuccessState());
      getComments(postId);
    }).catchError((error) {
      emit(SocialcommentPostsErrorState(error.toString()));
    });
  }

  List<String> commentList = [];
  List<CommentModel> commentModelList = [];
  String? newPostId;

  void getComments(String postId) {
    emit(SocialGetCommentPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Comments')
        .doc(model!.uid)
        .collection('user Comment')
        .orderBy('dateTime')
        .get()
        .then((value) {
      commentModelList.clear();
      commentList.clear();
      value.docs.forEach((element) {
        // commentModel=   CommentModel.fromJson(element.data());
        commentModelList.add(CommentModel.fromJson(element.data()));
        commentList.add(element.id);
        emit(SocialGetCommentPostsSuccessState(postId));
      });
      print(postId + ' 3');
      newPostId = postId;
      print(newPostId);
      emit(SocialGetCommentPostsSuccessState(postId));
    }).catchError((error) {
      emit(SocialGetCommentPostsErrorState(error.toString()));
      print(error);
    });
  }

  List<SocialuserModel> users = [];

  void Getalluser() {
    users = [];
    emit(GetAlluserloadingstate());
    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach(
        (element) {
          if (element.data()['uid'] != model!.uid)
            users.add(SocialuserModel.FromJson(element.data()));
        },
      );
      emit(GetAlluserSuccessstate());
    }).catchError((error) {
      print(error.toString());

      emit(GetAllusererrorstate(error.toString()));
    });
  }

}
