// To parse this JSON data, do
//
//     final adddishmodel = adddishmodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Adddishmodel adddishmodelFromJson(String str) => Adddishmodel.fromJson(json.decode(str));

String adddishmodelToJson(Adddishmodel data) => json.encode(data.toJson());

class Adddishmodel {
  Adddishmodel({
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.image,
    @required this.timeTaken,
    @required this.status,
    @required this.category,
    @required this.ingredient,
    @required this.video,
  });

  String name;
  String description;
  int price;
  int timeTaken;
  String image;
  String status;
  List category;
  String video;
  List<dishIngredient> ingredient;

  factory Adddishmodel.fromJson(Map<String, dynamic> json) => Adddishmodel(
    name: json["name"] == null ? null : json["name"],
    image:json['image']==null?null:json['image'],
    description: json["description"] == null ? null : json["description"],
    price: json["price"] == null ? null : json["price"],
    timeTaken: json["time_taken"] == null ? null : json["time_taken"],
    status: json["status"] == null ? null : json["status"],
    category: json["category"] == null ? null : json["category"],
    video: json["video"] == null ? null : json["video"],
    ingredient: json["ingredient"] == null ? null : List<dishIngredient>.from(json["ingredient"].map((x) => dishIngredient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "image":image==null?null:image,
    "description": description == null ? null : description,
    "price": price == null ? null : price,
    "time_taken": timeTaken == null ? null : timeTaken,
    "status": status == null ? null : status,
    "video": video == null ? null : video,
    "category": category == null ? null : category,
    "ingredient": ingredient == null ? null : List<dynamic>.from(ingredient.map((x) => x.toJson())),
  };
}

class dishIngredient {
  dishIngredient({
     this.name,
     this.quantity,
     this.units,
     this.required,
  });

  String name;
  int quantity;
  String units;
  int required;

  factory dishIngredient.fromJson(Map<String, dynamic> json) => dishIngredient(
    name: json["name"] == null ? null : json["name"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    units: json["units"] == null ? null : json["units"],
    required: json["required"] == null ? null : json["required"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "quantity": quantity == null ? null : quantity,
    "units": units == null ? null : units,
    "required": required == null ? null : required,
  };
}
