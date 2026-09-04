class UserClass {
  String? userId;
  DateTime? createdAt;
  String password;
  String name;
  String? lastName;
  String email;
  String? phone;
  String? referralCode;
  // String? role;
  int roleId;

  UserClass({
    this.userId,
    this.createdAt,
    required this.password,
    required this.name,
    this.lastName,
    required this.email,
    this.phone,
    this.referralCode,
    // this.role,
    required this.roleId,
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
      // role: json['role'] as String?,
      roleId: json['role_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': name,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      // 'role': role,
      'role_id': roleId,
    };
  }

  UserClass copyWith({
    String? userId,
    DateTime? createdAt,
    String? name,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    String? role,
    int? roleId,
    String? referralCode,
  }) {
    return UserClass(
      password: password ?? this.password,
      name: name ?? this.name,
      email: email ?? this.email,
      roleId: roleId ?? this.roleId,
      createdAt: createdAt ?? this.createdAt,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      referralCode: referralCode ?? this.referralCode,
      // role: role ?? this.role,
      userId: userId ?? this.userId,
    );
  }
}
