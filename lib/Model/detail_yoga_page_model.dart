
class DetailYogaPageModel {
  String? id;
  String? category;
  String? subCategory;
  String? title;
  String? videoLink;
  String? img;
  String? popular;
  String? weightLoss;
  List<UpNext>? upNext;

  DetailYogaPageModel({this.id, this.category, this.subCategory, this.title, this.videoLink, this.img, this.popular, this.weightLoss, this.upNext});

  DetailYogaPageModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    category = json["category"];
    subCategory = json["sub_category"];
    title = json["title"];
    videoLink = json["video_link"];
    img = json["img"];
    popular = json["popular"];
    weightLoss = json["weight_loss"];
    upNext = json["up_next"] == null ? null : (json["up_next"] as List).map((e) => UpNext.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["category"] = category;
    data["sub_category"] = subCategory;
    data["title"] = title;
    data["video_link"] = videoLink;
    data["img"] = img;
    data["popular"] = popular;
    data["weight_loss"] = weightLoss;
    if(upNext != null) {
      data["up_next"] = upNext?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class UpNext {
  String? id;
  String? category;
  String? subCategory;
  String? title;
  String? videoLink;
  String? img;
  String? popular;
  String? weightLoss;

  UpNext({this.id, this.category, this.subCategory, this.title, this.videoLink, this.img, this.popular, this.weightLoss});

  UpNext.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    category = json["category"];
    subCategory = json["sub_category"];
    title = json["title"];
    videoLink = json["video_link"];
    img = json["img"];
    popular = json["popular"];
    weightLoss = json["weight_loss"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["category"] = category;
    data["sub_category"] = subCategory;
    data["title"] = title;
    data["video_link"] = videoLink;
    data["img"] = img;
    data["popular"] = popular;
    data["weight_loss"] = weightLoss;
    return data;
  }
}
