import 'package:flutter/material.dart';
import 'package:stockallagent/constants/constants_main.dart';

class ShopInfo {
  final double shopId;
  final DateTime shopCreatedAt;
  final String shopName;
  final DateTime? lastActivity;
  final bool isTrial;
  final bool isExpired;
  final double? remainingDays;
  final double shopBranches;
  final String? country;
  final String? state;
  final String? city;
  final String? shopAddress;
  final String? userName;
  final double? totalStaffs;
  final String? userPhone;
  final String? userEmail;
  final String? userRole;
  final double? currentPlan;
  final double? oldPlan;
  final DateTime? subscriptionCreatedAt;
  final DateTime? subscriptionNextPayment;
  final DateTime? subscriptionLastPayment;

  // Agent information
  String? agentFirstName;
  String? agentLastName;
  String? agentEmail;
  String? agentPhone;
  double? agentRoleId;
  String? agentUuid;
  String? agentAndShopUuid;
  List<Comment>? agentComments;

  final bool isActive;
  final bool isSemiActive;
  final bool isInactive;

  ShopInfo({
    required this.shopId,
    required this.shopCreatedAt,
    required this.shopName,
    this.lastActivity,
    required this.isTrial,
    required this.isExpired,
    this.remainingDays,
    required this.totalStaffs,
    required this.shopBranches,
    this.country,
    this.state,
    this.city,
    this.shopAddress,
    this.userName,
    this.userPhone,
    this.userEmail,
    this.userRole,
    this.currentPlan,
    this.oldPlan,
    this.subscriptionCreatedAt,
    this.subscriptionNextPayment,
    this.subscriptionLastPayment,
    this.agentFirstName,
    this.agentLastName,
    this.agentEmail,
    this.agentPhone,
    this.agentRoleId,
    this.agentComments,
    this.agentUuid,
    this.agentAndShopUuid,
    required this.isActive,
    required this.isSemiActive,
    required this.isInactive,
  });
  factory ShopInfo.fromJson(Map<String, dynamic> json) {
    return ShopInfo(
      shopId: (json['shop_id'] as num).toDouble(),
      shopCreatedAt: DateTime.parse(
        json['shop_created_at'].toString(),
      ),
      shopName: json['shop_name'] as String,
      lastActivity: json['last_activity'] != null
          ? DateTime.tryParse(
              json['last_activity'].toString(),
            )
          : null,
      isTrial: json['is_trial'] as bool? ?? false,
      totalStaffs: (json['total_staffs'] as num).toDouble(),
      isExpired: json['is_expired'] as bool? ?? false,
      remainingDays: (json['remaining_days'] as num?)
          ?.toDouble(),
      shopBranches:
          (json['shop_branches'] as num?)?.toDouble() ??
          0.0,
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      shopAddress: json['shop_address'] as String?,
      userName: json['user_name'] as String?,
      userPhone: json['user_phone'] as String?,
      userEmail: json['user_email'] as String?,
      userRole: json['user_role'] as String?,
      currentPlan: (json['current_plan'] as num?)
          ?.toDouble(),
      oldPlan: (json['old_plan'] as num?)?.toDouble(),
      subscriptionCreatedAt:
          json['subscription_created_at'] != null
          ? DateTime.tryParse(
              json['subscription_created_at'].toString(),
            )
          : null,
      subscriptionNextPayment:
          json['subscription_next_payment'] != null
          ? DateTime.tryParse(
              json['subscription_next_payment'].toString(),
            )
          : null,
      subscriptionLastPayment:
          json['subscription_last_payment'] != null
          ? DateTime.tryParse(
              json['subscription_last_payment'].toString(),
            )
          : null,

      // Agent information
      agentFirstName: json['agent_first_name'] as String?,
      agentLastName: json['agent_last_name'] as String?,
      agentUuid: json['agent_uuid'] as String?,
      agentAndShopUuid:
          json['agent_and_shop_uuid'] as String?,
      agentEmail: json['agent_email'] as String?,
      agentPhone: json['agent_phone'] as String?,
      agentRoleId: (json['agent_role_id'] as num?)
          ?.toDouble(),
      agentComments: json['agent_comments'] != null
          ? (json['agent_comments'] as List)
                .map((comment) => Comment.fromJson(comment))
                .toList()
          : null,
      // Activity status
      isActive: json['isActive'] as bool? ?? false,

      isSemiActive: json['isSemiActive'] as bool? ?? false,

      isInactive: json['isInactive'] as bool? ?? false,
    );
  }

  ShopInfo copyWith({
    double? shopId,
    DateTime? shopCreatedAt,
    String? shopName,
    DateTime? lastActivity,
    bool? isTrial,
    bool? isExpired,
    double? remainingDays,
    double? shopBranches,
    String? country,
    String? state,
    String? city,
    String? shopAddress,
    String? userName,
    double? totalStaffs,
    String? userPhone,
    String? userEmail,
    String? userRole,
    double? currentPlan,
    double? oldPlan,
    DateTime? subscriptionCreatedAt,
    DateTime? subscriptionNextPayment,
    DateTime? subscriptionLastPayment,
    String? agentFirstName,
    String? agentLastName,
    String? agentEmail,
    String? agentPhone,
    double? agentRoleId,
    String? agentUuid,
    String? agentAndShopUuid,
    List<Comment>? agentComments,
    bool? isActive,
    bool? isSemiActive,
    bool? isInactive,
  }) {
    return ShopInfo(
      shopId: shopId ?? this.shopId,
      shopCreatedAt: shopCreatedAt ?? this.shopCreatedAt,
      shopName: shopName ?? this.shopName,
      lastActivity: lastActivity ?? this.lastActivity,
      isTrial: isTrial ?? this.isTrial,
      isExpired: isExpired ?? this.isExpired,
      remainingDays: remainingDays ?? this.remainingDays,
      shopBranches: shopBranches ?? this.shopBranches,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      shopAddress: shopAddress ?? this.shopAddress,
      userName: userName ?? this.userName,
      totalStaffs: totalStaffs ?? this.totalStaffs,
      userPhone: userPhone ?? this.userPhone,
      userEmail: userEmail ?? this.userEmail,
      userRole: userRole ?? this.userRole,
      currentPlan: currentPlan ?? this.currentPlan,
      oldPlan: oldPlan ?? this.oldPlan,
      subscriptionCreatedAt:
          subscriptionCreatedAt ??
          this.subscriptionCreatedAt,
      subscriptionNextPayment:
          subscriptionNextPayment ??
          this.subscriptionNextPayment,
      subscriptionLastPayment:
          subscriptionLastPayment ??
          this.subscriptionLastPayment,
      agentFirstName: agentFirstName ?? this.agentFirstName,
      agentLastName: agentLastName ?? this.agentLastName,
      agentEmail: agentEmail ?? this.agentEmail,
      agentPhone: agentPhone ?? this.agentPhone,
      agentRoleId: agentRoleId ?? this.agentRoleId,
      agentUuid: agentUuid ?? this.agentUuid,
      agentAndShopUuid:
          agentAndShopUuid ?? this.agentAndShopUuid,
      agentComments: agentComments ?? this.agentComments,
      isActive: isActive ?? this.isActive,
      isSemiActive: isSemiActive ?? this.isSemiActive,
      isInactive: isInactive ?? this.isInactive,
    );
  }

  String currentPlanName() {
    if (isExpired) {
      return 'Expired';
    } else if (isTrial) {
      return 'Trial';
    } else {
      double plan = currentPlan ?? 0;
      switch (plan) {
        case 0:
          return 'Free Plan';
        case 1:
          return 'Basic Plan';
        case 2:
          return 'Standard Plan';
        case 3:
          return 'Premium Plan';
        case 4:
          return 'Silver Plan';
        case 5:
          return 'Gold Plan';
        default:
          return 'Free Plan';
      }
    }
  }

  String oldPlanName() {
    double plan = oldPlan ?? 3;
    switch (plan) {
      case 0:
        return 'Free Plan';
      case 1:
        return 'Basic Plan';
      case 2:
        return 'Standard Plan';
      case 3:
        return 'Premium Plan';
      case 4:
        return 'Silver Plan';
      case 5:
        return 'Gold Plan';
      default:
        return 'Free Plan';
    }
  }

  String getRemainingDays() {
    final totalDays = (remainingDays ?? 0).round();
    final isNegative = totalDays < 0;
    final absoluteDays = totalDays.abs();

    if (absoluteDays <= 30) {
      return '${isNegative ? '-' : ''}$absoluteDays '
          '${absoluteDays == 1 ? 'day' : 'days'}';
    }

    final months = absoluteDays ~/ 30;
    final remainingDayss = absoluteDays % 30;

    final monthString =
        '${isNegative ? '-' : ''}$months '
        '${months == 1 ? 'month' : 'months'}';

    if (remainingDayss == 0) {
      return monthString;
    }

    return '$monthString, '
        '$remainingDayss ${remainingDayss == 1 ? 'day' : 'days'}';
  }

  List<Comment> getComments() {
    List<Comment> temp = agentComments ?? [];
    temp.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return temp;
  }

  Color activeColor() {
    return isActive
        ? Colors.green
        : isSemiActive
        ? Colors.amber
        : Colors.grey;
  }

  String activeText() {
    return isActive
        ? 'Active'
        : isSemiActive
        ? "Semi-Active"
        : 'In-active';
  }

  String getLastSeen() {
    return lastActivity != null
        ? formatDateOrDaysAgo(lastActivity!)
        : 'Not Set';
  }
}

class Comment {
  final String? uuid;
  final String agentUuid;
  final String agentName;
  final DateTime createdAt;
  final String comment;

  Comment({
    this.uuid,
    required this.agentUuid,
    required this.agentName,
    required this.createdAt,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      uuid: json['uuid']?.toString(),
      agentUuid: json['agent_uuid'].toString(),
      agentName: json['agent_name'].toString(),
      createdAt: DateTime.parse(
        json['created_at'].toString(),
      ),
      comment: json['comment'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'agent_uuid': agentUuid,
      'agent_name': agentName,
      'created_at': createdAt.toIso8601String(),
      'comment': comment,
    };
  }
}
