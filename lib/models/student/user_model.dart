// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String name;
  String email;
  String password;
  String uid;
  String role;
  String adminId;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.role,
    required this.adminId,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? uid,
    String? role,
    String? adminId,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      role: role ?? this.role,
      adminId: adminId ?? this.adminId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'uid': uid,
      'role': role,
      'adminId': adminId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      uid: map['uid'] as String,
      role: map['role'] as String,
      adminId: map['adminId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: $password, uid: $uid, role: $role, adminId: $adminId)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.uid == uid &&
        other.role == role &&
        other.adminId == adminId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        uid.hashCode ^
        role.hashCode ^
        adminId.hashCode;
  }
}
