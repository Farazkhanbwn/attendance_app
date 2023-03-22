// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddAdminModel {
  String? cnic;
  String? name;
  String? password;
  String? rollId;
  AddAdminModel({
    this.cnic,
    this.name,
    this.password,
    this.rollId,
  });

  AddAdminModel copyWith({
    String? cnic,
    String? name,
    String? password,
    String? rollId,
  }) {
    return AddAdminModel(
      cnic: cnic ?? this.cnic,
      name: name ?? this.name,
      password: password ?? this.password,
      rollId: rollId ?? this.rollId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cnic': cnic,
      'name': name,
      'password': password,
      'rollId': rollId,
    };
  }

  factory AddAdminModel.fromMap(Map<String, dynamic> map) {
    return AddAdminModel(
      cnic: map['cnic'] != null ? map['cnic'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      rollId: map['rollId'] != null ? map['rollId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddAdminModel.fromJson(String source) =>
      AddAdminModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddAdminModel(cnic: $cnic, name: $name, password: $password, rollId: $rollId)';
  }

  @override
  bool operator ==(covariant AddAdminModel other) {
    if (identical(this, other)) return true;

    return other.cnic == cnic &&
        other.name == name &&
        other.password == password &&
        other.rollId == rollId;
  }

  @override
  int get hashCode {
    return cnic.hashCode ^ name.hashCode ^ password.hashCode ^ rollId.hashCode;
  }
}
