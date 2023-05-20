// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? blueID;
  String? password;
  String? userEmail;
  String? userId;
  String? userName;
  String? userRoll;
  UserModel({
    this.blueID,
    this.password,
    this.userEmail,
    this.userId,
    this.userName,
    this.userRoll,
  });

  UserModel copyWith({
    String? blueID,
    String? password,
    String? userEmail,
    String? userId,
    String? userName,
    String? userRoll,
  }) {
    return UserModel(
      blueID: blueID ?? this.blueID,
      password: password ?? this.password,
      userEmail: userEmail ?? this.userEmail,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userRoll: userRoll ?? this.userRoll,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'blueID': blueID,
      'password': password,
      'userEmail': userEmail,
      'userId': userId,
      'userName': userName,
      'userRoll': userRoll,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      blueID: map['blueID'] != null ? map['blueID'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userRoll: map['userRoll'] != null ? map['userRoll'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(blueID: $blueID, password: $password, userEmail: $userEmail, userId: $userId, userName: $userName, userRoll: $userRoll)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.blueID == blueID &&
        other.password == password &&
        other.userEmail == userEmail &&
        other.userId == userId &&
        other.userName == userName &&
        other.userRoll == userRoll;
  }

  @override
  int get hashCode {
    return blueID.hashCode ^
        password.hashCode ^
        userEmail.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        userRoll.hashCode;
  }
}
