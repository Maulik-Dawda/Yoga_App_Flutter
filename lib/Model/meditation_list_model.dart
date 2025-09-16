
class MeditationListModel {
  String? id;
  String? category;
  String? title;
  String? videoLink;
  String? img;

  MeditationListModel({this.id, this.category, this.title, this.videoLink, this.img});

  MeditationListModel.fromJson(Map<String, dynamic> json) {
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
