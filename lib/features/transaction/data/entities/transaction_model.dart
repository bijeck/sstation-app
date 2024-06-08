import 'dart:convert';

import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/extensions/string_extension.dart';
import 'package:sstation/core/extensions/transaction_method.extension.dart';
import 'package:sstation/core/extensions/transaction_status_extension.dart';
import 'package:sstation/core/extensions/transaction_type_extension.dart';
import 'package:sstation/features/transaction/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel({
    required super.id,
    required super.createdAt,
    required super.description,
    required super.amount,
    required super.status,
    required super.type,
    required super.url,
    required super.method,
  });
  TransactionModel copyWith({
    String? id,
    String? createdAt,
    String? description,
    double? amount,
    TransactionStatus? status,
    TransactionType? type,
    String? url,
    TransactionMethod? method,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      type: type ?? this.type,
      url: url ?? this.url,
      method: method ?? this.method,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'description': description,
      'amount': amount,
      'status': status.title,
      'type': type.title,
      'url': url,
      'method': method.title,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      createdAt: map['createdAt'] ?? '',
      description: map['description'] ?? '',
      amount: map['amount'].toDouble(),
      status: (map['status'] as String).toTransactionStatus(),
      type: (map['type'] as String).toTransactionType(),
      url: map['url'] ?? '',
      method: (map['method'] as String).toTransactionMethod(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, createdAt: $createdAt, description: $description, amount: $amount, status: $status, type: $type, url: $url, method: $method)';
  }
}
