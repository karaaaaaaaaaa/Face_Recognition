import 'dart:io';

import 'package:Face_Recognition/all/cubits/registerstate%20copy/registestate.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../../../ML/Recognition.dart';
import '../../../ML/Recognizer.dart';
import '../../../RecognitionScreen.dart';
import '../../../RegistrationScreen.dart';
import '../recognitionstate/recognitionstate.dart';

class RegisterCubit extends Cubit<registerstate> {
  RegisterCubit() : super(register_initstate());
  static RegisterCubit get(context) => BlocProvider.of(context);
  // late ImagePicker imagePicker;
  File? _image;
  // FacePainter? model;
  var image;
  List<Recognition> recognitions = [];
  List<Face> faces = [];
  //TODO declare detector
  dynamic faceDetector;

  //TODO declare face recognizer
  late Recognizer _recognizer;
  var picker = ImagePicker();
  Future imgFromCamera() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      // emit(camerasuccessstate());
      doFaceDetection();
      emit(registercamerasuccessstate());

    }else {
      print('No Image Selected');
      emit(CamreaImageErrorState());
    }
  }
  // File? profileImageFile;
  // // var picker = ImagePicker();
  // Future getProfileImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     profileImageFile = File(pickedFile.path);
  //     print(pickedFile.path.toString());
  //     emit(SocialEditUserProfileImageSuccessState());
  //   } else {
  //     print('No Image Selected');
  //     emit(SocialEditUserProfileImageErrorState());
  //   }
  // }


  //TODO choose image using gallery
  Future imgFromGallery() async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doFaceDetection();
      emit(registergallarysuccessstate());

    }else {
      print('No Image Selected');
      emit(GallaryImageErrorState());
    }
  }

  TextEditingController textEditingController = TextEditingController();
  final options = FaceDetectorOptions(
      enableClassification: false,
      enableContours: false,
      enableLandmarks: false);

  //TODO initalize face detector

  doFaceDetection() async {
    faces.clear();
    final options = FaceDetectorOptions(
        enableClassification: false,
        enableContours: false,
        enableLandmarks: false);
    emit(registerdoFaceDetectionstate1());


    //TODO initalize face detector
    faceDetector = FaceDetector(options: options);
    emit(registerdoFaceDetectionstate());

    //TODO remove rotation of camera images
    _image = await removeRotation(_image!);

    //TODO passing input to face detector and getting detected faces
    final inputImage = InputImage.fromFile(_image!);
    faces = await faceDetector.processImage(inputImage);

    //TODO call the method to perform face recognition on detected faces
    performFaceRecognition();
    emit(registerdoFaceDetectionstate());
  }

  //TODO remove rotation of camera images
  removeRotation(File inputImage) async {
    final img.Image? capturedImage =
        img.decodeImage(await File(inputImage.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    emit(removerotionstateregister());
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  //TODO perform Face Recognition
  performFaceRecognition() async {
    image = await _image?.readAsBytes();
    image = await decodeImageFromList(image);
    print("${image.width}   ${image.height}");

    
    for (Face face in faces) {
      Rect faceRect = face.boundingBox;
      num left = faceRect.left < 0 ? 0 : faceRect.left;
      num top = faceRect.top < 0 ? 0 : faceRect.top;
      num right =
          faceRect.right > image.width ? image.width - 1 : faceRect.right;
      num bottom =
          faceRect.bottom > image.height ? image.height - 1 : faceRect.bottom;
      num width = right - left;
      num height = bottom - top;

      //TODO crop face
      File cropedFace = await FlutterNativeImage.cropImage(_image!.path,
          left.toInt(), top.toInt(), width.toInt(), height.toInt());
      final bytes = await File(cropedFace.path).readAsBytes();
      final img.Image? faceImg = img.decodeImage(bytes);
      _recognizer = Recognizer();
      emit(register_recognizerstate());
      Recognition recognition =
          _recognizer.recognize(faceImg!, face.boundingBox);
          
      emit(performFaceregisterstate());

    }
    drawRectangleAroundFaces();
  

    emit(performFaceregisterstate());
  }

  //TODO draw rectangles
  drawRectangleAroundFaces() async {
    image = await _image?.readAsBytes();
    image = await decodeImageFromList(image);
    print("${image.width}   ${image.height}");
    image;
    faces;
    emit(registerdrawRectangleAroundFacesstate());
    // setState(() {
    //   image;
    //   faces;
    // });
  }
}
