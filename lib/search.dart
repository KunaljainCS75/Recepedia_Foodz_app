import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:foodz_app/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:foodz_app/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:math' as math;
import 'RecipeView.dart';

void changeStatusBarColor(){
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black38,
          statusBarIconBrightness: Brightness.light
      ));
}

class Search extends StatefulWidget {
  String query;
  Search(this.query);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
  String numResults = "0";


  getRecipe(query) async{

    indices.shuffle();

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

    numResults = recipelist.length.toString();
    recipelist.forEach((Recipe) {
      print(Recipe.appLabel);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    changeStatusBarColor();
    super.initState();
    getRecipe(widget.query);
    print(indices);
    print(recipelist.length);
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
    final _random = math.Random();
    var dish = dish_names[_random.nextInt(dish_names.length)];

    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.pink,
                          Colors.white
                        ],
                        stops: [
                          0.185,
                          0.185
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if ((searchBar.text).replaceAll(" ", "") ==
                                    "") {
                                  print("Blank Search");
                                }
                                else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search(searchBar.text)));
                                }
                              },
                              child: Container(
                                child: Icon(
                                  Icons.search_sharp,
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              ),
                            ),
                            Expanded(
                                child: TextField(
                                  controller: searchBar,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.black87,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search $dish",
                                      hintStyle: const TextStyle(
                                          color: Colors.white70)),
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

                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      margin: EdgeInsets.fromLTRB(10, 0, 140, 0),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.,
                        children: [
                          Text(
                            "Results for your search...",
                            style: GoogleFonts.lora(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0,10,0,0),
                      child: Column(
                        children: [
                          isLoading? SizedBox(height: 10, width: 370, child: LinearProgressIndicator(

                              color: Colors.blue, borderRadius: BorderRadius.circular(20),)
                          ): ListView
                          .builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recipelist.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeView(recipelist[index].appUrl)));
                              },
                              child: Card(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        recipelist[index].appImgUrl,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        height: 200,
                                      ),
                                    ),
                                    Positioned(
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child:
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.zero,
                                                    topRight: Radius.zero,
                                                    bottomLeft: Radius.circular(
                                                        20),
                                                    bottomRight: Radius
                                                        .circular(20)),
                                                color: Colors.black54
                                            ),
                                            child: Text(
                                              recipelist[index].appLabel,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,

                                              ),))
                                    ),
                                    Positioned(
                                      right: 0,
                                      left: 253,
                                      child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.zero,
                                                  topRight: Radius.circular(20),
                                                  bottomLeft: Radius.zero,
                                                  bottomRight: Radius.zero)
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.local_fire_department,
                                                size: 20,),
                                              Text(recipelist[index].appCalories
                                                      .toString().substring(
                                                      0, 6) + " kcal",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900
                                                ),),
                                            ],
                                          )),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 28,
                                      left: 253,
                                      child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.zero,
                                                  topRight: Radius.zero,
                                                  bottomLeft: Radius.circular(
                                                      20),
                                                  bottomRight: Radius.zero)
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.access_time,
                                                size: 20, color: Colors.white,),
                                              Text(" " + recipelist[index].appTime.substring(0,3) + " minutes",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w900
                                                ),),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.zero,
                              bottomRight: Radius.circular(100),
                              bottomLeft: Radius.zero
                          ),
                          color: Colors.deepOrange
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

                      child: ListView.builder(
                        itemCount: recipeCategoryList.length, shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          int randomIndex = indices[index];
                          return Container(

                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Search(recipeCategoryList[randomIndex]["heading"])));
                              },
                              child: Card(
                                margin: EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60)
                                ),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.zero,
                                          topRight: Radius.circular(50),
                                          bottomRight: Radius.zero,
                                          bottomLeft: Radius.circular(50)
                                      ),
                                      child: Image.network(
                                          recipeCategoryList[randomIndex]["imgUrl"],
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10
                                          ),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.zero,
                                                  topRight: Radius.circular(50),
                                                  bottomRight: Radius.zero,
                                                  bottomLeft: Radius.circular(
                                                      50)
                                              ),
                                              color: Colors.black26
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                recipeCategoryList[randomIndex]["heading"],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                ),
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
