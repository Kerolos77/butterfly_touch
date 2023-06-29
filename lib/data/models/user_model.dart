class UserModel {
  late String userId;
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String score;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.score,
  });

  UserModel.fromJson(dynamic json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    score = json['score'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['score'] = score;
    return map;
  }
}
