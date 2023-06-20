
import 'dart:io';

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

class RecognitionCubit extends Cubit<recognitionstate> {
  RecognitionCubit() : super(recognition_initstate());
  static RecognitionCubit get(context) => BlocProvider.of(context);
  late ImagePicker imagePicker;
  File? _image;
  // FacePainter? model;
  var image;
  List<Recognition> recognitions = [];
  List<Face> faces = [];
  //TODO declare detector
  dynamic faceDetector;

  //TODO declare face recognizer
  late Recognizer _recognizer;
  Future imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      emit(camerasuccessstate());
      doFaceDetection();
    }
  }

  //TODO choose image using gallery
  Future imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      emit(gallarysuccessstate());
      doFaceDetection();
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

    //TODO initalize face detector
    faceDetector = FaceDetector(options: options);
    //TODO remove rotation of camera images
    _image = await removeRotation(_image!);

    //TODO passing input to face detector and getting detected faces
    final inputImage = InputImage.fromFile(_image!);
    faces = await faceDetector.processImage(inputImage);

    //TODO call the method to perform face recognition on detected faces
    performFaceRecognition();
    emit(doFaceDetectionstate());
  }

  //TODO remove rotation of camera images
  removeRotation(File inputImage) async {
    final img.Image? capturedImage =
        img.decodeImage(await File(inputImage.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    emit(removerotionstate());
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  //TODO perform Face Recognition
  performFaceRecognition() async {
    image = await _image?.readAsBytes();
    image = await decodeImageFromList(image);
    print("${image.width}   ${image.height}");

    recognitions.clear();
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
      emit(recognizerstate());
      Recognition recognition =
          _recognizer.recognize(faceImg!, face.boundingBox);
      emit(performFaceRecognitionstate());

      if (recognition.distance > 1) {
        recognition.name = "Unknown";
      }
      recognitions.add(recognition);
    }
    drawRectangleAroundFaces();
    emit(performFaceRecognitionstate());
  }

  //TODO draw rectangles
  drawRectangleAroundFaces() async {
    image;
    faces;
    emit(drawRectangleAroundFacesstate());
    // setState(() {
    //   image;
    //   faces;
    // });
  }
}
