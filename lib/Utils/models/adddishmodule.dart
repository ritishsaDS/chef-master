// To parse this JSON data, do
//
//     final adddishmodel = adddishmodelFromJson(jsonString);

import 'dart:convert';

Adddishmodel adddishmodelFromJson(String str) => Adddishmodel.fromJson(json.decode(str));

String adddishmodelToJson(Adddishmodel data) => json.encode(data.toJson());

class Adddishmodel {
  Adddishmodel({
    this.name,
    this.description,
    this.price,
    this.timeTaken,
    this.status,
    this.category,
    this.ingredient,
    this.dishImage,
    this.video,
  });

  String name;
  String description;
  String price;
  String timeTaken;
  String status;
  List<String> category;
  List<Ingredient> ingredient;
  String dishImage;
  String video;

  factory Adddishmodel.fromJson(Map<String, dynamic> json) => Adddishmodel(
    name: json["name"],
    description: json["description"],
    price: json["price"],
    timeTaken: json["time_taken"],
    status: json["status"],
    category: List<String>.from(json["category"].map((x) => x)),
    ingredient: List<Ingredient>.from(json["ingredient"].map((x) => Ingredient.fromJson(x))),
    dishImage: json["dish_image"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "price": price,
    "time_taken": timeTaken,
    "status": status,
    "category": List<dynamic>.from(category.map((x) => x)),
    "ingredient": List<dynamic>.from(ingredient.map((x) => x.toJson())),
    "dish_image": dishImage,
    "video": video,
  };
}

class Ingredient {
  Ingredient({
    this.name,
  });

  String name;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
