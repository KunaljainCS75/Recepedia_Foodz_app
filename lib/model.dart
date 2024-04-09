class RecipeModel
{
 late String appLabel;
 late String appImgUrl;
 late double appCalories;
 late String appUrl;
 late String appTime;


 RecipeModel({this.appCalories = 0.000, this.appImgUrl = "IMAGE", this.appLabel = "LABEL", this.appUrl = "URL",
              this.appTime = "TOTALTIME"});
 //use {} to have optional parameters // use simple () for required params

 factory RecipeModel.fromMap(Map recipe)
 {
  return RecipeModel(
   appLabel: recipe["label"],
   appCalories: recipe["calories"],
   appImgUrl: recipe["image"],
   appUrl: recipe["url"],
   appTime: recipe["totalTime"].toString()
  );
 }

}