
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home.dart';


class RecipeView extends StatefulWidget {
  String url;
  RecipeView(this.url){
  }

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.pink,
        title: Text(
          "Recipedia",
          style: GoogleFonts.kumbhSans(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.white)),
        ),
      ),

      body: Container(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            setState(() {
              controller.complete(webViewController);
            });
          },
        ),
        )
      );
  }
}
