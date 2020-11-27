class UserModel {
  String name;
  final String email;
  final int id;
  final String apiToken;
  final String phone;
  final String role;
  final String userOf;
  final String status;
  final String emailVerifiedAt;
  String storeName;
  String storeId;
  String storeLogo;

  UserModel({
    this.name,
    this.email,
    this.id,
    this.phone,
    this.apiToken,
    this.role,
    this.userOf,
    this.status,
    this.emailVerifiedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        id = json['id'],
        email = json['email'].toString(),
        emailVerifiedAt = json['email_verified'].toString(),
        phone = json['mobile_number'].toString(),
        role = json['role'].toString(),
        userOf = json['user_of'].toString(),
        apiToken = json['api_token'].toString(),
        status = json['status'].toString();
}
