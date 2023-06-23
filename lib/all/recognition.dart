// import 'dart:io';
// import 'package:Face_Recognition/ML/Recognition.dart';
// import 'package:Face_Recognition/all/cubits/recognitioncubit/RecognitionCubit.dart';
// import 'package:Face_Recognition/all/cubits/recognitionstate/recognitionstate.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img;

// import '../ML/Recognizer.dart';

// class recognition extends StatelessWidget {
//   const recognition({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var image = RecognitionCubit.get(context).image;
//     return BlocProvider(
//       create: (context) => RecognitionCubit(),
//       child: BlocConsumer<RecognitionCubit, recognitionstate>(
//         builder: (context, state) {
//           double screenWidth = MediaQuery.of(context).size.width;
//           double screenHeight = MediaQuery.of(context).size.height;
//           return Scaffold(
//             body: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 image != null
//                     ? Column(
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 margin: const EdgeInsets.only(
//                                     top: 60, left: 30, right: 30, bottom: 0),
//                                 child: FittedBox(
//                                   child: SizedBox(
//                                     width: image.width.toDouble(),
//                                     height: image.width.toDouble(),
//                                     child: CustomPaint(
//                                       painter: FacePainter(
//                                         facesList: RecognitionCubit
//                                             .get(context)
//                                             .recognitions,
//                                         imageFile: image,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               // Text("${model!.rectangle.name}"),
//                               SizedBox(
//                                 height: 60,
//                               ),
//                               // TextFormField(
//                               //   controller:,
//                               //   decoration: InputDecoration(label: Text('name')

//                               // ,border: InputBorder.none),),
//                               // Text("kareem"),

//                               Container(
//                                   padding: EdgeInsets.all(10),
//                                   color: Colors.grey,
//                                   child: Text(
//                                       "time of comming  ${TimeOfDay.now().format(context)}")),
//                             ],
//                           ),
//                         ],
//                       )
//                     : Container(
//                         margin: const EdgeInsets.only(top: 100),
//                         child: Image.asset(
//                           "images/logo.png",
//                           width: screenWidth - 100,
//                           height: screenWidth - 100,
//                         ),
//                       ),

//                 Container(
//                   height: 50,
//                 ),

//                 //section which displays buttons for choosing and capturing images
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 50),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Card(
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(200))),
//                         child: InkWell(
//                           onTap: () {
//                             RecognitionCubit.get(context).imgFromGallery();
//                           },
//                           child: SizedBox(
//                             width: screenWidth / 2 - 70,
//                             height: screenWidth / 2 - 70,
//                             child: Icon(Icons.image,
//                                 color: Colors.blue, size: screenWidth / 7),
//                           ),
//                         ),
//                       ),
//                       Card(
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(200))),
//                         child: InkWell(
//                           onTap: () {
//                             RecognitionCubit.get(context).imgFromCamera();
//                           },
//                           child: SizedBox(
//                             width: screenWidth / 2 - 70,
//                             height: screenWidth / 2 - 70,
//                             child: Icon(Icons.camera,
//                                 color: Colors.blue, size: screenWidth / 7),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//         listener: (context, state) {},
//       ),
//     );
//   }
// }

// class FacePainter extends CustomPainter {
//   List<Recognition> facesList;
//   dynamic imageFile;
//   late Recognition rectangle;
//   FacePainter({
//     required this.facesList,
//     required this.imageFile,
//     // required this.rectangle,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (imageFile != null) {
//       canvas.drawImage(imageFile, Offset.zero, Paint());
//     }

//     Paint p = Paint();
//     p.color = Colors.red;
//     p.style = PaintingStyle.stroke;
//     p.strokeWidth = 3;

//     for (rectangle in facesList) {
//       canvas.drawRect(rectangle.location, p);
//       TextSpan span = TextSpan(
//           style: const TextStyle(color: Colors.white, fontSize: 90),
//           text: "${rectangle.name}  ${rectangle.distance.toStringAsFixed(2)}");
//       TextPainter tp = TextPainter(
//           text: span,
//           textAlign: TextAlign.left,
//           textDirection: TextDirection.ltr);
//       tp.layout();
//       tp.paint(canvas, Offset(rectangle.location.left, rectangle.location.top));
//       print("${rectangle.name} ");
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
