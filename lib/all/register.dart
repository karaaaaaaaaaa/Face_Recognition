// import 'dart:io';
// import 'package:Face_Recognition/ML/Recognition.dart';
// // import 'package:Face_Recognition/all/cubits/recognitioncubit/recognitioncubit.dart';
// import 'package:Face_Recognition/all/cubits/recognitionstate/recognitionstate.dart';
// import 'package:Face_Recognition/all/cubits/RegisterCubit%20copy/RegisterCubit.dart';
// import 'package:Face_Recognition/all/cubits/registerstate%20copy/registestate.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img;

// import '../HomeScreen.dart';
// import '../ML/Recognizer.dart';

// class register extends StatelessWidget {
//   const register({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var image = RegisterCubit.get(context).image;

//     return BlocProvider(
//       create: (context) => RegisterCubit(),
//       child: BlocConsumer<RegisterCubit, registerstate>(
//         builder: (context, state) {
//           double screenWidth = MediaQuery.of(context).size.width;
//           double screenHeight = MediaQuery.of(context).size.height;
//    showFaceRegistrationDialogue(File cropedFace, Recognition recognition) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Face Registration",
//             style: TextStyle(color: Color.fromARGB(255, 231, 9, 9)),
//             textAlign: TextAlign.center),
//         alignment: Alignment.center,
//         content: SizedBox(
//           height: 340,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Image.file(
//                 cropedFace,
//                 width: 200,
//                 height: 200,
//               ),
//               SizedBox(
//                 width: 200,
//                 child: TextField(
//                     controller: RegisterCubit.get(context).textEditingController,
//                     decoration: const InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: "Enter Name")),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     HomeScreen.registered.putIfAbsent(
//                         RegisterCubit.get(context).textEditingController.text, () => recognition);
//                     RegisterCubit.get(context).textEditingController.text = "";
//                     Navigator.pop(context);
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text("Face Registered"),
//                     ));
//                   },
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.blue, minimumSize: const Size(200, 40)),
//                   child: const Text("Register"))
//             ],
//           ),
//         ),
//         contentPadding: EdgeInsets.zero,
//       ),
//     );
//   }

//           return 
//           Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           image != null
//               ? Container(
//                   margin: const EdgeInsets.only(
//                       top: 60, left: 30, right: 30, bottom: 0),
//                   child: FittedBox(
//                     child: SizedBox(
//                       width: image.width.toDouble(),
//                       height: image.width.toDouble(),
//                       child: CustomPaint(
//                         painter:
//                             FacePainter(facesList: RegisterCubit.get(context).faces, imageFile: image),
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(
//                   margin: const EdgeInsets.only(top: 100),
//                   child: Image.asset(
//                     "images/logo.png",
//                     width: screenWidth - 100,
//                     height: screenWidth - 100,
//                   ),
//                 ),

//           Container(
//             height: 50,
//           ),

//           //section which displays buttons for choosing and capturing images
//           Container(
//             margin: const EdgeInsets.only(bottom: 50),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Card(
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(200))),
//                   child: InkWell(
//                     onTap: () {
//                       RegisterCubit.get(context).imgFromGallery();
//                     },
//                     child: SizedBox(
//                       width: screenWidth / 2 - 70,
//                       height: screenWidth / 2 - 70,
//                       child: Icon(Icons.image,
//                           color: Colors.blue, size: screenWidth / 7),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(200))),
//                   child: InkWell(
//                     onTap: () {
//                      RegisterCubit.get(context).imgFromCamera();
//                     },
//                     child: SizedBox(
//                       width: screenWidth / 2 - 70,
//                       height: screenWidth / 2 - 70,
//                       child: Icon(Icons.camera,
//                           color: Colors.blue, size: screenWidth / 7),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//  },
//         listener: (context, state) {},
//       ),
//     );
//   }
// }

// class FacePainter extends CustomPainter {
//   List<Face> facesList;
//   dynamic imageFile;
//   FacePainter({required this.facesList, required this.imageFile});

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (imageFile != null) {
//       canvas.drawImage(imageFile, Offset.zero, Paint());
//     }

//     Paint p = Paint();
//     p.color = Colors.red;
//     p.style = PaintingStyle.stroke;
//     p.strokeWidth = 3;

//     for (Face face in facesList) {
//       canvas.drawRect(face.boundingBox, p);
//     }

//     Paint p2 = Paint();
//     p2.color = Colors.green;
//     p2.style = PaintingStyle.stroke;
//     p2.strokeWidth = 3;

//     Paint p3 = Paint();
//     p3.color = Colors.yellow;
//     p3.style = PaintingStyle.stroke;
//     p3.strokeWidth = 1;
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
