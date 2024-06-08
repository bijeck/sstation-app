import 'dart:convert';

import 'package:sstation/features/transaction/data/entities/transaction_model.dart';
import 'package:sstation/features/transaction/domain/entities/transactions_list.dart';

class TransactionsListModel extends TransactionsList {
  TransactionsListModel({
    required super.transactions,
    required super.reachMax,
    required super.currentPage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactions':
          transactions.map((x) => (x as TransactionModel).toMap()).toList(),
      'reachMax': reachMax,
      'currentPage': currentPage,
    };
  }

  factory TransactionsListModel.fromMap(Map<String, dynamic> map) {
    return TransactionsListModel(
      transactions: List<TransactionModel>.from(
        (map['contends'] as List<dynamic>).map<TransactionModel>(
          (x) => TransactionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      reachMax: !map['hasNextPage'],
      currentPage: map['page'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionsListModel.fromJson(String source) =>
      TransactionsListModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TransactionsList(transactions: $transactions, reachMax: $reachMax, currentPage: $currentPage)';
}
