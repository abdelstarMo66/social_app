class PostModel {
  String? name;
  String? uId;
  String? image;
  String? post_image;
  String? text;
  String? date_time;

  PostModel({
     this.name,
     this.text,
     this.date_time,
      this.uId,
     this.post_image,
     this.image,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    post_image = json['post_image'];
    date_time = json['date_time'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'uid': uId,
      'date_time':date_time,
      'image':image,
      'post_image':post_image,
    };
  }
}
