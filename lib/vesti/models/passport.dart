// lib/models/passport.dart
import 'dart:convert';

Passport passportFromJson(String str) => Passport.fromJson(json.decode(str));

String passportToJson(Passport data) => json.encode(data.toJson());

class Passport {
  String id;
  String firstName;
  String lastName;
  String passportNumber;
  String dateOfBirth;
  String expirationDate;
  String passportUrlImage;
  String userId;

  Passport({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.passportNumber,
    required this.dateOfBirth,
    required this.expirationDate,
    required this.passportUrlImage,
    required this.userId,
  });

  factory Passport.fromJson(Map<String, dynamic> json) => Passport(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        passportNumber: json["passportNumber"],
        dateOfBirth: json["dateOfBirth"],
        expirationDate: json["expirationDate"],
        passportUrlImage: json["passportUrlImage"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "passportNumber": passportNumber,
        "dateOfBirth": dateOfBirth,
        "expirationDate": expirationDate,
        "passportUrlImage": passportUrlImage,
        "userId": userId,
      };
}
