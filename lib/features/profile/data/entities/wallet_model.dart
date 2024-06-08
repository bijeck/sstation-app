// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:sstation/features/profile/domain/entities/wallet.dart';
part 'wallet_model.g.dart';
@HiveType(typeId: 6)
class WalletModel extends Wallet {
  const WalletModel({
    required super.id,
    required super.balance,
  });

  const WalletModel.sample() : this(id: 23, balance: 300);

  WalletModel copyWith({
    int? id,
    int? balance,
  }) {
    return WalletModel(
      id: id ?? this.id,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'balance': balance,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'] as int,
      balance: map['balance'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
