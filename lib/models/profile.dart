import 'dart:convert';

// ignore_for_file: constant_identifier_names, unnecessary_const, non_constant_identifier_names

class User {

  final String image;
  final String name;
  final String email;
  final String phone;
  final String gender;

  const User({
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  


  User copyWith({
    String? image,
    String? name,
    String? email,
    String? phone,
    String? gender,
  }) {
    return User(
      image: image ?? this.image,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(image: $image, name: $name, email: $email, phone: $phone, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.image == image &&
      other.name == name &&
      other.email == email &&
      other.phone == phone &&
      other.gender == gender;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      gender.hashCode;
  }
}


class UserPrefernces{
  static const MyUser =  User(
    image: "https://res.cloudinary.com/practicaldev/image/fetch/s--AUy_lRQk--/c_fill,f_auto,fl_progressive,h_320,q_auto,w_320/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/731756/8fc92f26-beed-427b-8f98-2ee186963428.jpeg",
     name: "Shreyam MAity",
      email: 'sm8967724231@gmuil.com',
       phone: '9002394195',
        gender: 'Male'
        );
}