import 'package:meta/meta.dart';

class UserData {
  int id;
  final String name;
  final String branch;
  final String semester;
  final String userType;
  final String enrollment;
  final String email;
  final String password;
  final String token;

  UserData({
    @required this.name,
    @required this.branch,
    @required this.semester,
    @required this.userType,
    @required this.enrollment,
    @required this.email,
    @required this.password,
    @required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'branch': branch,
      'semester': semester,
      'userType': userType,
      'enrollment': enrollment,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  static UserData fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'],
      branch: map['branch'],
      semester: map['semester'],
      userType: map['userType'],
      enrollment: map['enrollment'],
      email: map['email'],
      password: map['password'],
      token: map['token'],
    );
  }
}
