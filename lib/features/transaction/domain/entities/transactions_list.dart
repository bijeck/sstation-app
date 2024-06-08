import 'package:sstation/features/transaction/domain/entities/transaction.dart';

class TransactionsList {
  final List<Transaction> transactions;
  final bool reachMax;
  final int currentPage;
  TransactionsList({
    required this.transactions,
    required this.reachMax,
    required this.currentPage,
  });

  TransactionsList.reset()
      : transactions = [],
        reachMax = false,
        currentPage = 1;

  TransactionsList copyWith({
    List<Transaction>? transactions,
    bool? reachMax,
    int? currentPage,
  }) {
    return TransactionsList(
      transactions: transactions ?? this.transactions,
      reachMax: reachMax ?? this.reachMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
