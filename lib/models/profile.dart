// ignore_for_file: constant_identifier_names, unnecessary_const, non_constant_identifier_names

class User{

  final String image;
  final String name;
  final String email;
  final String phone;
  final String gender;

  const User({required this.image, required this.name, required this.email, required this.phone, required this.gender});

  

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