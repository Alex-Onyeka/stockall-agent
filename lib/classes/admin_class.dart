class AdminClass {
  final String id;
  final String userId;
  final int level;
  final String? name;

  AdminClass({
    required this.id,
    required this.userId,
    required this.level,
    this.name,
  });

  factory AdminClass.fromJson(Map<String, dynamic> json) {
    return AdminClass(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      level: json['level'] as int,
      name: json['name'] as String?,
    );
  }
}
