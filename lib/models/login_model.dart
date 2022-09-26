class LoginModel {
  late bool status;
   late String message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late double credit;
  late String token;
  UserData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'] ?? '';
    this.phone = json['phone'];
    this.image = json['image'];
    this.points = json['points'];
    this.credit = json["credit"];
    this.token = json['token'];
  }
}
