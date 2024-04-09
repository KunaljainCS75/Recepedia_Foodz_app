import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodz_app/profile.dart';
import 'Loading.dart';
import 'home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black38,
    statusBarIconBrightness: Brightness.light
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Recipedia",
        routes: {
          "/" : (context) => Loading(),
         "/home" : (context) => home(),
          "/profile" : (context) => profile(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "LATO",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        );
  }
}
