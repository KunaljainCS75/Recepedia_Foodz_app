import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void startApp(){
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, "/home", arguments:
      {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    startApp();

    return Scaffold(
        body: Container(

          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("images/img_8.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const SizedBox(
                height: 270,
              ),


              const SizedBox(
                height: 20,
              ),
              Text("Recipedia",
                style:
                GoogleFonts.artifika(textStyle : const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),),
              ),
              const SizedBox(height: 5),

              Text("There is no single recipe for success",
                style:
                GoogleFonts.ubuntu(textStyle : const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),),
              ),

              const SizedBox(
                height: 10,
              ),

              const SpinKitThreeBounce(
                color: Colors.white,
                size: 30.0,),

              const SizedBox(
                height: 255,
              ),

              Text("Developed by KunalCS221075",
                style:
                GoogleFonts.alice(textStyle : const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),),
              ),



            ],
          ),
        )
      );
  }
}
