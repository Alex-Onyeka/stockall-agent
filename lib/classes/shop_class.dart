// class ShopClass {
//   final int? shopId;
//   final DateTime createdAt;
//   final String userId;
//   String name;
//   String? phoneNumber;
//   String? refCode;
//   bool isHeadQuaters;

//   ShopClass({
//     this.shopId,
//     required this.createdAt,
//     required this.userId,
//     required this.name,
//     this.phoneNumber,
//     this.refCode,
//     required this.isHeadQuaters,
//   });

//   factory ShopClass.fromJson(Map<String, dynamic> json) {
//     return ShopClass(
//       shopId: json['shop_id'] as int?,
//       createdAt: DateTime.parse(
//         json['created_at'] as String,
//       ),
//       userId: json['user_id'] as String,
//       name: json['name'] as String,
//       phoneNumber: json['phone_number'] as String?,
//       refCode: json['ref_code'] as String?,
//       isHeadQuaters: json['is_head_quarters'] as bool,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       // 'shop_id': shopId,
//       'created_at': createdAt.toIso8601String(),
//       'user_id': userId,
//       'name': name,
//       'phone_number': phoneNumber,
//       'ref_code': refCode,
//     };
//   }
// }
