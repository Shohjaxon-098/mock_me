class AccountsChangeModel {
  final String name;
  final String surname;
  final String birth;
  final String region;
  final String phoneNumber;
  final String image;
  final String email;

  AccountsChangeModel({
    required this.name,
    required this.surname,
    required this.birth,
    required this.region,
    required this.phoneNumber,
    required this.image,
    required this.email,
  });

  factory AccountsChangeModel.fromJson(Map<String, dynamic> json) {
    return AccountsChangeModel(
      name: json['name'],
      surname: json['surname'],
      birth: json['birth'],
      region: json['region'],
      phoneNumber: json['phone_number'],
      image: json['image'],
      email: json['email'],
    );
  }
}
