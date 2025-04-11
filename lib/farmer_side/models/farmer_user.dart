import 'dart:convert';

class FarmerUser {
  String id;
  String fullName;
  String email;
  String state;
  String city;
  String locality;
  final String area;
  final String agromethod;
  final String description;
  final String profileImage;
  String role;
  String password;

  FarmerUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.area,
    required this.agromethod,
    required this.description,
    required this.profileImage,
    required this.role,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "_id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "area": area,
      "agromethod": agromethod,
      "description": description,
      "profileImage": profileImage,
      "role": role,
      "password": password,
    };
  }

  String toJson() => json.encode(toMap());

  factory FarmerUser.fromMap(Map<String, dynamic> map) {
    return FarmerUser(
      id: map["_id"] as String? ?? "", // Avoid null errors
      fullName: map["fullName"] as String? ?? "",
      email: map["email"] as String? ?? "",
      state: map["state"] as String? ?? "",
      city: map["city"] as String? ?? "",
      locality: map["locality"] as String? ?? "",
      area: map["area"] as String? ?? "",
      agromethod: map["agromethod"] as String? ?? "",
      description: map["description"] as String? ?? "",
      profileImage: map["profileImage"] as String? ?? "",
      role: map["role"] as String? ?? "",
      password: map["password"] as String? ?? "",
    );
  }

  factory FarmerUser.fromJson(String source) =>
      FarmerUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
