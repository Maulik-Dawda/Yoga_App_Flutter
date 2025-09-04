
class RecommendedYogaModel {
  String? id;
  String? category;
  String? subCategory;
  String? title;
  String? videoLink;
  String? img;
  String? popular;
  String? weightLoss;

  RecommendedYogaModel({this.id, this.category, this.subCategory, this.title, this.videoLink, this.img, this.popular, this.weightLoss});

  RecommendedYogaModel.fromJson(Map<String, dynamic> json) {
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
