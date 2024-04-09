import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:foodz_app/RecipeView.dart';
import 'package:foodz_app/profile.dart';
import 'package:foodz_app/search.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:foodz_app/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


void changeStatusBarColor(){
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black38,
                                 statusBarIconBrightness: Brightness.light
    ));
}


class home extends StatefulWidget {


  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {


  bool isLoading = true;

  TextEditingController searchBar = TextEditingController();

  List<RecipeModel> recipelist = <RecipeModel>[];
  List recipeCategoryList = [{"imgUrl": "https://img.freepik.com/premium-photo/chole-bhature-spicy-chick-peas-curry-also-known-as-chole-channa-masala-is-traditional-north-indian-main-course-recipe-usually-served-with-fried-puri-bhature-selective-focus_726363-296.jpg?w=2000", "heading": "Spicy"},
    {"imgUrl": "https://5.imimg.com/data5/SELLER/Default/2020/11/DP/RX/KB/44184428/mix-sweets-500x500.jpg", "heading": "Desserts"},
    {"imgUrl": "https://th.bing.com/th/id/OIP.LJCmlWv2xddY0z29pXLOZgHaE8?rs=1&pid=ImgDetMain", "heading": "Breakfast"},
    {"imgUrl": "https://wallpapercave.com/wp/wp4166407.jpg", "heading": "Juice"},
    {"imgUrl": "https://static.standard.co.uk/s3fs-public/thumbnails/image/2017/08/16/12/noodlesbowl1608a.jpg?width=1200&width=1200&auto=webp&quality=75", "heading": "Noodles"},
  ];

  List indices = [0,1,2,3,4];

  List<RecipeModel> recipelist_2 = <RecipeModel>[];
  List recipeCategoryList_2 = [{"imgUrl": "https://th.bing.com/th/id/OIP.hwNV7AeTvrYYzmMJe4GNlAHaFi?rs=1&pid=ImgDetMain", "heading": "Sandwiches"},
    {"imgUrl": "https://th.bing.com/th/id/OIP.roADcSzQIAjibHlPQomK8AHaEh?rs=1&pid=ImgDetMain", "heading": "Curry"},
    {"imgUrl": "https://th.bing.com/th/id/OIP.-eHlnvRLkqxCxEKd1GILmgAAAA?w=340&h=510&rs=1&pid=ImgDetMain", "heading": "Pasta"},
    {"imgUrl": "https://th.bing.com/th/id/OIP.Yz48HJ1anMw9jqNwkItdWgHaE7?rs=1&pid=ImgDetMain", "heading": "Burgers"},
    {"imgUrl": "https://d4fcp1q4cnzm9.cloudfront.net/contents/oe/2s/w920_oe2swjme9jn5oz8n.jpg", "heading": "Rice"},
    {"imgUrl": "https://assets.cntraveller.in/photos/60ba1ef8002baf698cc67527/16:9/w_1024%2Cc_limit/homemade-paneer-recipes-1366x768.jpg", "heading": "Paneer"},
  ];

  List indices_2 = [0,1,2,3,4];


  getRecipe(query) async{

        indices.shuffle();
        indices_2.shuffle();

        String url = "https://api.edamam.com/search?q=$query&app_id=a4f5f7f2&app_key=4a324d4d76487da036fac6c4204fe0cb";
        Response response = await http.get(Uri.parse(url));

        Map data = jsonDecode(response.body);
        log(data.toString());

        data["hits"].forEach((element){
          RecipeModel recipeModel = RecipeModel();
          recipeModel = RecipeModel.fromMap(element["recipe"]);
          recipelist.add(recipeModel);

          setState((){
            isLoading = false;
          });

          log(recipelist.toString());
    });

    recipelist.forEach((Recipe) {
      print(Recipe.appLabel);
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    changeStatusBarColor();
    super.initState();
    getRecipe(searchBar.text);
    print(indices);
  }

  @override
  Widget build(BuildContext context) {

    var dish_names = [
      "Chhole Bhature",
      "Pasta",
      "Apple Juice",
      "Samosa",
      "French Fries",
      "laddoo",
      "biryani"
    ];
    final _random = new math.Random();
    var dish = dish_names[_random.nextInt(dish_names.length)];


    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.pink,
                    Colors.white
                  ],
                  stops: [
                    0.245,
                    0.245
                  ]
                )
              ),
            ),
            SingleChildScrollView(
              child: Column(

                //SEARCH BAR

                children: [
                  SafeArea(
                    child: Container(
                      //Search bar container
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if ((searchBar.text).replaceAll(" ", "") == ""){
                                print("Blank Search");
                              }
                              else{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchBar.text)));
                              }
                            },
                            child: Container(
                              child: Icon(
                                Icons.search_sharp,
                                color: Colors.black45,
                              ),
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            ),
                          ),
                          Expanded(
                              child: TextField(
                                controller: searchBar,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.black87,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search $dish",
                                    hintStyle: const TextStyle(color: Colors.black45,
                                    )),
                              )),
                          GestureDetector(
                            child: Image.asset(
                              'images/img_9.png', height: 40, width: 40,
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => profile()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    margin: EdgeInsets.fromLTRB(0,0,50,0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        Text("Is this Cooking Time ???", style:
                        TextStyle(
                            fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),
                        Text("Search and Get the best food recipes today...",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),)
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(15,10,10,10),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                          topRight: Radius.zero,
                          bottomRight: Radius.circular(100),
                          bottomLeft: Radius.zero
                      ),
                      color: Colors.deepOrange
                    ),
                    child: Text(
                      "Today's Special",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white)),
                    ),
                  ),
                  Container(
                    height: 190,

                    child: Container(
                          
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Search("veg momos")));
                            },
                            child: Card(
                              margin: EdgeInsets.fromLTRB(0,20,0,10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60)
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.zero,
                                                                    topRight: Radius.circular(50),
                                                                    bottomRight: Radius.zero,
                                                                    bottomLeft: Radius.circular(50)
                                    ),
                                    child: Image.network("https://bitemeup.com/wp-content/uploads/2021/06/Untitled-design-14-4.png",
                                                         height: 200, width: 370, fit: BoxFit.cover),
                                  ),
                                  Positioned(
                                      left: 0,  top: 0,
                                      right: 0, bottom: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10
                                        ),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.zero,
                                                                          topRight: Radius.circular(50),
                                                                          bottomRight: Radius.zero,
                                                                          bottomLeft: Radius.circular(50)
                                          ),
                                          color: Colors.black26
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Hot Vegetarian Momos",
                                          style: GoogleFonts.lora(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(15,10,10,10),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                            topRight: Radius.zero,
                            bottomRight: Radius.circular(100),
                            bottomLeft: Radius.zero
                        ),
                        color: Colors.purple
                    ),
                    child: Text(
                      "Select from Categories",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white)),
                    ),
                  ),
                  Container(
                    height: 190,

                    child: ListView.builder(itemCount: recipeCategoryList.length, shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        int randomIndex = indices[index];
                        return Container(

                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Search(recipeCategoryList[randomIndex]["heading"])));
                            },
                            child: Card(
                              margin: EdgeInsets.fromLTRB(20,20,20,20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.zero,
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.zero,
                                        bottomLeft: Radius.circular(50)
                                    ),
                                    child: Image.network(recipeCategoryList[randomIndex]["imgUrl"],
                                        height: 200, width: 200, fit: BoxFit.cover),
                                  ),
                                  Positioned(
                                      left: 0,  top: 0,
                                      right: 0, bottom: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10
                                        ),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.zero,
                                                topRight: Radius.circular(50),
                                                bottomRight: Radius.zero,
                                                bottomLeft: Radius.circular(50)
                                            ),
                                            color: Colors.black26
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              recipeCategoryList[randomIndex]["heading"],
                                              style: GoogleFonts.lora(
                                                  textStyle: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(15,10,10,10),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                            topRight: Radius.zero,
                            bottomRight: Radius.circular(100),
                            bottomLeft: Radius.zero
                        ),
                        color: Colors.green
                    ),
                    child: Text(
                      "Quick Recipes",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white)),
                    ),
                  ),
                  Container(
                    height: 190,

                    child: ListView.builder(itemCount: recipeCategoryList.length, shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        int randomIndex = indices_2[index];
                        return Container(

                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Search(recipeCategoryList_2[randomIndex]["heading"])));
                            },
                            child: Card(
                              margin: EdgeInsets.fromLTRB(20,20,20,20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.zero,
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.zero,
                                        bottomLeft: Radius.circular(50)
                                    ),
                                    child: Image.network(recipeCategoryList_2[randomIndex]["imgUrl"],
                                        height: 200, width: 200, fit: BoxFit.cover),
                                  ),
                                  Positioned(
                                      left: 0,  top: 0,
                                      right: 0, bottom: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10
                                        ),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.zero,
                                                topRight: Radius.circular(50),
                                                bottomRight: Radius.zero,
                                                bottomLeft: Radius.circular(50)
                                            ),
                                            color: Colors.black26
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              recipeCategoryList_2[randomIndex]["heading"],
                                              style: GoogleFonts.lora(
                                                  textStyle: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
