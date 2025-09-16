
class DietDetailModel {
  String? id;
  String? category;
  String? title;
  String? videoLink;
  String? img;
  String? popular;
  String? youMustTry;
  List<String>? ingredients;
  List<String>? instructions;
  List<String>? nutritions;
  String? veg;
  List<UpNext>? upNext;

  DietDetailModel({this.id, this.category, this.title, this.videoLink, this.img, this.popular, this.youMustTry, this.ingredients, this.instructions, this.nutritions, this.veg, this.upNext});

  DietDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    category = json["category"];
    title = json["title"];
    videoLink = json["video_link"];
    img = json["img"];
    popular = json["popular"];
    youMustTry = json["you_must_try"];
    ingredients = json["ingredients"] == null ? null : List<String>.from(json["ingredients"]);
    instructions = json["instructions"] == null ? null : List<String>.from(json["instructions"]);
    nutritions = json["nutritions"] == null ? null : List<String>.from(json["nutritions"]);
    veg = json["veg"];
    upNext = json["up_next"] == null ? null : (json["up_next"] as List).map((e) => UpNext.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["category"] = category;
    data["title"] = title;
    data["video_link"] = videoLink;
    data["img"] = img;
    data["popular"] = popular;
    data["you_must_try"] = youMustTry;
    if(ingredients != null) {
      data["ingredients"] = ingredients;
    }
    if(instructions != null) {
      data["instructions"] = instructions;
    }
    if(nutritions != null) {
      data["nutritions"] = nutritions;
    }
    data["veg"] = veg;
    if(upNext != null) {
      data["up_next"] = upNext?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class UpNext {
  String? id;
  String? category;
  String? title;
  String? videoLink;
  String? img;
  String? popular;
  String? youMustTry;
  List<String>? ingredients;
  List<String>? instructions;
  List<String>? nutritions;
  String? veg;

  UpNext({this.id, this.category, this.title, this.videoLink, this.img, this.popular, this.youMustTry, this.ingredients, this.instructions, this.nutritions, this.veg});

  UpNext.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    category = json["category"];
    title = json["title"];
    videoLink = json["video_link"];
    img = json["img"];
    popular = json["popular"];
    youMustTry = json["you_must_try"];
    ingredients = json["ingredients"] == null ? null : List<String>.from(json["ingredients"]);
    instructions = json["instructions"] == null ? null : List<String>.from(json["instructions"]);
    nutritions = json["nutritions"] == null ? null : List<String>.from(json["nutritions"]);
    veg = json["veg"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["category"] = category;
    data["title"] = title;
    data["video_link"] = videoLink;
    data["img"] = img;
    data["popular"] = popular;
    data["you_must_try"] = youMustTry;
    if(ingredients != null) {
      data["ingredients"] = ingredients;
    }
    if(instructions != null) {
      data["instructions"] = instructions;
    }
    if(nutritions != null) {
      data["nutritions"] = nutritions;
    }
    data["veg"] = veg;
    return data;
  }
}
