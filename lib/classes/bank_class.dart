class BankClass {
  final int? bankId;
  final DateTime? createdDate;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final String userId;

  BankClass({
    this.bankId,
    this.createdDate,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    required this.userId,
  });

  factory BankClass.fromJson(Map<String, dynamic> json) {
    return BankClass(
      bankId: json['id'] as int?,
      createdDate: DateTime.parse(
        json['created_at'] as String,
      ),
      bankName: json['bank_name'] as String,
      accountName: json['account_name'] as String,
      accountNumber: json['account_number'] as String,
      userId: json['agent_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bank_name': bankName,
      'account_name': accountName,
      'account_number': accountNumber,
      'agent_id': userId,
    };
  }
}
