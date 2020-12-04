class User {
  String id;
  String name;
  String nickname;
  String password;
  String email;

  User({this.id, this.name, this.nickname, this.password, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nickname = json['nickname'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? '';
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['email'] = this.email;
    return data;
  }
}