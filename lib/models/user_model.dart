class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? bg_image;
  String? bio;
  bool? isEmailVerified;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.uid,
    this.isEmailVerified,
    this.image,
    this.bio,
    this.bg_image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uid = json['uid'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    bg_image = json['bg_image'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'isEmailVerified': isEmailVerified,
      'bio':bio,
      'image':image,
      'bg_image':bg_image,
    };
  }
}
