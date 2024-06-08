import 'package:equatable/equatable.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/utils/core_utils.dart';

class Transaction extends Equatable {
  final String id;
  final String createdAt;
  final String description;
  final double amount;
  final TransactionStatus status;
  final TransactionType type;
  final String url;
  final TransactionMethod method;
  const Transaction({
    required this.id,
    required this.createdAt,
    required this.description,
    required this.amount,
    required this.status,
    required this.type,
    required this.url,
    required this.method,
  });

  @override
  List<Object?> get props => [CoreUtils.parseDateFromTimestamp(createdAt)];
}
