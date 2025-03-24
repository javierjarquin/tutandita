class Usermodel {
  final String email;
  final String password;

  Usermodel({required this.email, required this.password});

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
