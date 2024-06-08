import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:sstation/features/profile/data/entities/device_model.dart';
import 'package:sstation/features/profile/data/entities/wallet_model.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';
part 'user_model.g.dart';
@HiveType(typeId: 5)
class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.id,
    required super.userName,
    required super.phoneNumber,
    required super.fullName,
    required super.avatarUrl,
    required super.email,
    required super.wallet,
    required super.devices,
  });

  // const LocalUserModel.empty()
  //     : this(
  //         id: '',
  //         userName: '',
  //         phoneNumber: '',
  //         fullName: '',
  //         avatarUrl: '',
  //         expiredTime: 0,
  //       );

  // const LocalUserModel.sample()
  //     : this(
  //         id: '112',
  //         userName: '0989437700',
  //         phoneNumber: '0989437700',
  //         fullName: 'Hanni Mais',
  //         avatarUrl: '',
  //         expiredTime: 0,
  //       );

  LocalUserModel copyWith({
    String? id,
    String? userName,
    String? phoneNumber,
    String? fullName,
    String? avatarUrl,
    String? email,
    WalletModel? wallet,
    List<DeviceModel>? devices,
  }) {
    return LocalUserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      wallet: wallet ?? this.wallet,
      devices: devices ?? this.devices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'email': email,
      'wallet': WalletModel(id: wallet.id, balance: wallet.balance).toMap(),
      'devices': devices
          .map((x) => DeviceModel(id: x.id, token: x.token).toMap())
          .toList(),
    };
  }

  factory LocalUserModel.fromMap(Map<String, dynamic> map) {
    return LocalUserModel(
      id: map['id'] as String,
      userName: map['userName'] as String,
      phoneNumber: map['phoneNumber']??'',
      fullName: map['fullName']??'',
      avatarUrl: map['avatarUrl'] ?? '',
      email: map['email'] ?? '',
      wallet: WalletModel.fromMap(map['wallet'] as Map<String, dynamic>),
      devices: List<DeviceModel>.from(
        (map['devices'] as List<dynamic>).map<DeviceModel>(
          (x) => DeviceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalUserModel.fromJson(String source) =>
      LocalUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
