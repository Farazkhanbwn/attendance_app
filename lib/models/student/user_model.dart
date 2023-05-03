// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String name;
  String email;
  String password;
  String uid;
  String role;
  String adminId;
  String blueId;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.role,
    required this.adminId,
    required this.blueId,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? uid,
    String? role,
    String? adminId,
    String? blueId,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      role: role ?? this.role,
      adminId: adminId ?? this.adminId,
      blueId: blueId ?? this.blueId,
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
      'blueId': blueId,
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
      blueId: map['blueId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: $password, uid: $uid, role: $role, adminId: $adminId, blueId: $blueId)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.uid == uid &&
        other.role == role &&
        other.adminId == adminId &&
        other.blueId == blueId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        uid.hashCode ^
        role.hashCode ^
        adminId.hashCode ^
        blueId.hashCode;
  }
}
