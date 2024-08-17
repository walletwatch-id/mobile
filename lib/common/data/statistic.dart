class Statistic {
  final String id;
  final int month;
  final int year;
  String personality;
  double totalTransaction;
  double totalInstallment;
  double totalIncome;
  double ratio;

  Statistic(
      {required this.id, required this.month, required this.year, required this.personality, required this.totalTransaction, required this.totalInstallment, required this.totalIncome, required this.ratio});
}
