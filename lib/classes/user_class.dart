class UserClass {
  String? userId;
  DateTime? createdAt;
  String password;
  String name;
  String? lastName;
  String email;
  String? phone;
  String? referralCode;

  UserClass({
    this.userId,
    this.createdAt,
    required this.password,
    required this.name,
    this.lastName,
    required this.email,
    this.phone,
    this.referralCode,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      userId: json['user_id'],
      createdAt: DateTime.tryParse(
        json['created_at'] ?? '',
      ),
      name: json['name'],
      lastName: json['last_name'] as String?,
      email: json['email'] ?? '',
      phone: json['phone'],
      password: json['password'] ?? '',
      referralCode: json['referral_code'] as String?,
    );
  }

  Map<String, dynamic> toJson({bool includeUserId = true}) {
    final map = {
      'name': name,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
    };

    if (includeUserId && userId != null) {
      map['user_id'] = userId;
    }
    if (createdAt != null) {
      map['created_at'] = createdAt!.toIso8601String();
    }

    return map;
  }
}
