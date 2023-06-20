import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../ML/Recognition.dart';
import '../ML/Recognizer.dart';

class admin extends StatelessWidget {
  // const admin({super.key});
    final dynamic result;
  final String isMale;
  final String age;
  admin({
required this.age,
required this.isMale,
required this.result,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text("${age }"),
              SizedBox(height: 22,),
              Row(
                children: [
                  SizedBox(width: 20,),

                  Container(width: 100,
                  height: 200,
                  child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                                    width: result.width.toDouble(),
                                    height: result.width.toDouble(),
                                    child: CustomPaint(
                                      // size: Size(20, 20),
                                      painter: FacePainter(
                                        // facesList: recognitions,
                                        imageFile: result,
                                      ),
                                    ),
                  ),
                  ),),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("data"),
                       SizedBox(height: 22,),
      // Spacer(),
            // Center(child: Text(isMale)),
            Center(child: Text("${isMale }",style: TextStyle(color: Colors.grey),)),
                    ],
                  ),
                ],
              ),
                // Container(
                //             margin: const EdgeInsets.only(
                //                 top: 60, left: 30, right: 30, bottom: 0),
                //             child: FittedBox(
                //               // fit: BoxFit.cover,
                //               child: SizedBox(
                //                 width: result.width.toDouble(),
                //                 height: result.width.toDouble(),
                //                 child: CustomPaint(
                //                   // size: Size(20, 20),
                //                   painter: FacePainter(
                //                     // facesList: recognitions,
                //                     imageFile: result,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                
                          SizedBox(
                            height: 20,
                          ),
          // CircleAvatar(child: Image(image: result) ,radius: 33,),
              SizedBox(height: 22,),
      // Spacer(),
            // Center(child: Text(isMale)),
            Center(child: Text("${isMale }",style: TextStyle(color: Colors.grey),)),
          ],
        ),
      ),
    );
  }
  
}
class FacePainter extends CustomPainter {
  // List<Recognition> facesList;
  dynamic imageFile;
  late Recognition rectangle;
  FacePainter({
    // required this.facesList,
    required this.imageFile,
    // required this.rectangle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }

    Paint p = Paint();
    p.color = Colors.red;
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 3;

    // for (rectangle in facesList) {
    //   canvas.drawRect(rectangle.location, p);
    //   TextSpan span = TextSpan(
    //       style: const TextStyle(color: Colors.white, fontSize: 90),
    //       text: "${rectangle.name}  ${rectangle.distance.toStringAsFixed(2)}");
    //   TextPainter tp = TextPainter(
    //       text: span,
    //       textAlign: TextAlign.left,
    //       textDirection: TextDirection.ltr);
    //   tp.layout();
    //   tp.paint(canvas, Offset(rectangle.location.left, rectangle.location.top));
    //   print("${rectangle.name} ");
    // }

    Paint p2 = Paint();
    p2.color = Colors.green;
    p2.style = PaintingStyle.stroke;
    p2.strokeWidth = 3;

    Paint p3 = Paint();
    p3.color = Colors.yellow;
    p3.style = PaintingStyle.stroke;
    p3.strokeWidth = 1;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
