import 'package:Face_Recognition/layout/secound.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../all/components/components/components.dart';
import '../socialCubit/cubit.dart';
import '../socialCubit/state.dart';

class firstlayout extends StatelessWidget {
  const firstlayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Socialcubit, cubitStates>(
      builder: (context, state) {
        var model = Socialcubit.get(context).model!;
        return Scaffold(
          body: Column(
            children: [
              Image.asset(
                "images/wellcome.png",
                width: double.infinity,
                height: 600,
              ),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.all(10),
                  child:RichText(text:TextSpan(children:<TextSpan> [
                     TextSpan(text:"knowing that your efforts today will shape your success tomorrow.. Sir :"
                  ,style: TextStyle(fontSize: 18, wordSpacing: 0.5,color: Colors.black) ),
                   TextSpan(text:" ${model.name}"
                  ,style: TextStyle(fontSize: 18, wordSpacing: 0.5,color: Colors.blue) ),
                  ])
                  
                
                  

                  ) ,
                  
                  // Text(
                  //   ' knowing that your efforts today will shape your success tomorrow.. Sir :  ${model.name}',
                  //   style: TextStyle(fontSize: 18, wordSpacing: 0.5),
                  // )
                  
                  ),
              Spacer(),
          
              // Container(
              //     width: 200,
              //     margin: EdgeInsets.all(20),
              //     child: ElevatedButton(
              //         onPressed: () {
                       
              //             print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
              //             navigateTo(context, secoundlayout());
                       
              //         },
              //         child: Icon(
              //           Icons.arrow_forward_ios_rounded,
              //           size: 32,
              //         ))),
          
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
