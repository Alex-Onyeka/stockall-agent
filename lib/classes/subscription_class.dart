class SubscriptionClass {
  final String subscriptionId;
  final DateTime createdDate;
  final String userId;
  final int plan;
  final DateTime? nextPayment;
  final DateTime? lastPayment;
  final double? amount;
  final int? duration;

  SubscriptionClass({
    required this.subscriptionId,
    required this.createdDate,
    required this.userId,
    required this.plan,
    this.nextPayment,
    this.amount,
    this.duration,
    this.lastPayment,
  });

  factory SubscriptionClass.fromJson(
    Map<String, dynamic> json,
  ) {
    return SubscriptionClass(
      subscriptionId: json['subscription_id'] as String,
      createdDate: DateTime.parse(
        json['created_at'] as String,
      ),
      userId: json['user_id'] as String,
      plan: json['plan'] as int,
      nextPayment: json['next_payment'] != null
          ? DateTime.parse(json['next_payment'] as String)
          : null,
      lastPayment: json['last_payment'] != null
          ? DateTime.parse(json['last_payment'] as String)
          : null,
      amount: (json['amount'] as num?)?.toDouble(),
      duration: json['duration'] as int?,
    );
  }
}
