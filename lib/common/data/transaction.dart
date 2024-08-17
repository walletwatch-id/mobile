class Transaction {
  final String id;
  final String userId;
  final String paylaterId;
  final int monthlyInstallment;
  final int period;
  final DateTime transactionDatetime;
  final DateTime firstInstallmentDatetime;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.paylaterId,
    required this.monthlyInstallment,
    required this.period,
    required this.transactionDatetime,
    required this.firstInstallmentDatetime,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      paylaterId: json['paylater_id'],
      monthlyInstallment: json['monthly_installment'],
      period: json['period'],
      transactionDatetime: DateTime.parse(json['transaction_datetime']),
      firstInstallmentDatetime: DateTime.parse(json['first_installment_datetime']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
