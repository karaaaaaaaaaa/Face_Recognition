

class SocialuserModel {
  late String name;
  late String email;
  late String phone;
  late String uid;
  late String image;
  late String Coverimage;
  late String bio;
  late bool IsEmailVerfied;
  SocialuserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.bio,
    required this.image,
    required this.Coverimage,
    required this.IsEmailVerfied,
  });
  SocialuserModel.FromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
    bio = json['bio'];
    Coverimage = json['Coverimage'];
    IsEmailVerfied = json['IsEmailVerfied'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email' :email,
     'name':name,
    'phone' :phone,
    'uid' :uid,
    'image' :image,
    'Coverimage' :Coverimage,
    'bio' :bio,
    'IsEmailVerfied' :IsEmailVerfied,
    };
  }
}
