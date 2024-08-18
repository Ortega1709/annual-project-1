import 'package:e_commerce/core/shared/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.adresse,
    required super.commune,
    required super.ville,
    required super.created,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: '',
      email: map["email"],
      name: map["name"],
      adresse: map["adresse"],
      commune: map["commune"],
      ville: map["ville"],
      created: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": "",
      "email": email,
      "emailVisibility": true,
      "password": "password",
      "passwordConfirm": "password",
      "name": name,
      "adresse": adresse,
      "commune": commune,
      "ville": ville
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? adresse,
    String? commune,
    String? ville,
    String? created,
  }) {
    return UserModel(
      id: id?? this.id,
      email: email?? this.email,
      name: name?? this.name,
      adresse: adresse?? this.adresse,
      commune: commune?? this.commune,
      ville: ville?? this.ville,
      created: created?? this.created,
    );
  }
}
