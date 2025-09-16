
class MeditationDetailModel {
  String? id;
  String? category;
  String? title;
  String? videoLink;
  String? img;
  List<UpNext>? upNext;

  MeditationDetailModel({this.id, this.category, this.title, this.videoLink, this.img, this.upNext});

  MeditationDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    category = json["category"];
    title = json["title"];
    videoLink = json["video_link"];
    img = json["img"];
    upNext = json["up_next"] == null ? null : (json["up_next"] as List).map((e) => UpNext.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["category"] = category;
    data["title"] = title;
    data["video_link"] = videoLink;
    data["img"] = img;
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

  UpNext({this.id, this.category, this.title, this.videoLink, this.img});

  UpNext.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    category = json["category"];
    title = json["title"];
    videoLink = json["video_link"];
    img = json["img"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["category"] = category;
    data["title"] = title;
    data["video_link"] = videoLink;
    data["img"] = img;
    return data;
  }
}
