class UserClass {
  String? userId;
  DateTime? createdAt;
  String password;
  String name;
  String? lastName;
  String email;
  String? phone;
  String? referralCode;
  String? role;

  UserClass({
    this.userId,
    this.createdAt,
    required this.password,
    required this.name,
    this.lastName,
    required this.email,
    this.phone,
    this.referralCode,
    this.role,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      userId: json['uuid'],
      createdAt: DateTime.tryParse(
        json['created_at'] ?? '',
      ),
      name: json['first_name'],
      lastName: json['last_name'] as String?,
      email: json['email'] ?? '',
      phone: json['phone'],
      password: json['password'] ?? '',
      referralCode: json['ref_code'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson({bool includeUserId = true}) {
    final map = {
      'first_name': name,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
    };

    if (includeUserId && userId != null) {
      map['uuid'] = userId;
    }
    if (createdAt != null) {
      map['created_at'] = createdAt!.toIso8601String();
    }

    return map;
  }
}
