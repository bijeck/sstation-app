import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:sstation/features/profile/domain/entities/device.dart';
part 'device_model.g.dart';
@HiveType(typeId: 7)
class DeviceModel extends Device{
  const DeviceModel({
    required super.id,
    required super.token,
  });

  DeviceModel copyWith({
    int? id,
    String? token,
  }) {
    return DeviceModel(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'token': token,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      id: map['id'] as int,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) => DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}