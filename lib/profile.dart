import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodz_app/home.dart';
import 'package:google_fonts/google_fonts.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    changeStatusBarColor();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "Profile details",
          style: GoogleFonts.kumbhSans(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.white)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(145, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Image(
                  image: AssetImage("images/img_10.png"),
                  height: 120,
                  width: 120,
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.fromLTRB(24, 30, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("First_Name"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "KunaaL",
                  style: GoogleFonts.lora(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  "---------------------------------------------------------------------------------------------------",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 10,),

                Text("Last_Name"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "A7_Shef",
                  style: GoogleFonts.lora(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  "---------------------------------------------------------------------------------------------------",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 10,),

                Text("E-mail ID"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "kunaljain75@gmail.com",
                  style: GoogleFonts.lora(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  "---------------------------------------------------------------------------------------------------",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 10,),

                Text("Phone No."),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "+9187707*****",
                  style: GoogleFonts.lora(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  "---------------------------------------------------------------------------------------------------",
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 10,),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
