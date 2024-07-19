class Statistic {
  final String id;
  final int month;
  final int year;
  final String personality;
  final double totalTransaction;
  final double totalInstallment;
  final double totalIncome;
  final double ratio;

  Statistic(
      {required this.id, required this.month, required this.year, required this.personality, required this.totalTransaction, required this.totalInstallment, required this.totalIncome, required this.ratio});
}
