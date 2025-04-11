import 'dart:convert';

Farmer farmerFromJson(String str) => Farmer.fromJson(json.decode(str));

String farmerToJson(Farmer data) => json.encode(data.toJson());

class Farmer {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String area;
  final String agromethod;
  final String description;
  final String profileImage;
  final String password;
  final String token;

  Farmer({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.area,
    required this.agromethod,
    required this.description,
    required this.password,
    required this.profileImage,
    required this.token,
  });

  // Factory constructor to create a Farmer object from a JSON map
  factory Farmer.fromJson(Map<String, dynamic> json) => Farmer(
    id: json["_id"] ?? "", // Default to an empty string if null
    fullName: json["fullName"] ?? "Unknown", // Default value if missing
    email: json["email"] ?? "unknown@example.com", // Default email
    state: json["state"] ?? "Unknown",
    city: json["city"] ?? "Unknown",
    profileImage: json["profileImage"] ?? "",
    locality: json["locality"] ?? "Unknown",
    area: json["area"] ?? "Unknown",
    agromethod: json["agromethod"] ?? "Unknown",
    description: json["description"] ?? "Unknown",
    password: json["password"] ?? "", // Default empty if missing
    token: json["token"] ?? "", // Default empty if missing
  );

  // Convert the Farmer object to JSON
  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "state": state,
    "city": city,
    "profileImage": profileImage,
    "locality": locality,
    "area": area,
    "agromethod": agromethod,
    "description": description,
    "password": password,
    "token": token,
  };
}
