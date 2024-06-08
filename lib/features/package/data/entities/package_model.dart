import 'dart:convert';

import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/extensions/string_extension.dart';
import 'package:sstation/features/package/data/entities/package_status_history_model.dart';
import 'package:sstation/features/package/domain/entities/package.dart';
import 'package:sstation/features/package/domain/entities/package_status_history.dart';
import 'package:sstation/features/profile/data/entities/user_model.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';
import 'package:sstation/features/station/data/entities/station_model.dart';
import 'package:sstation/features/station/domain/entities/station.dart';

class PackageModel extends Package {
  PackageModel({
    required super.id,
    required super.createdAt,
    required super.exprireReceiveGoods,
    required super.name,
    required super.description,
    required super.priceCod,
    required super.isCod,
    required super.barcode,
    required super.status,
    required super.weight,
    required super.height,
    required super.width,
    required super.length,
    required super.volume,
    required super.location,
    required super.sender,
    required super.receiver,
    required super.totalDays,
    required super.totalPrice,
    required super.serviceFee,
    required super.formatTotalPrice,
    required super.formatServiceFee,
    required super.packageImages,
    required super.packageStatusHistories,
    required super.station,
  });

  PackageModel copyWith({
    String? id,
    String? createdAt,
    String? exprireReceiveGoods,
    String? name,
    String? description,
    double? priceCod,
    bool? isCod,
    String? barcode,
    PackageStatus? status,
    int? weight,
    int? height,
    int? width,
    int? length,
    int? volume,
    String? location,
    LocalUser? sender,
    LocalUser? receiver,
    int? totalDays,
    double? totalPrice,
    double? serviceFee,
    String? formatTotalPrice,
    String? formatServiceFee,
    List<String>? packageImages,
    List<PackageStatusHistory>? packageStatusHistories,
    Station? station,
  }) {
    return PackageModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      exprireReceiveGoods: exprireReceiveGoods ?? this.exprireReceiveGoods,
      name: name ?? this.name,
      description: description ?? this.description,
      priceCod: priceCod ?? this.priceCod,
      isCod: isCod ?? this.isCod,
      barcode: barcode ?? this.barcode,
      status: status ?? this.status,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      width: width ?? this.width,
      length: length ?? this.length,
      volume: volume ?? this.volume,
      location: location ?? this.location,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      totalDays: totalDays ?? this.totalDays,
      totalPrice: totalPrice ?? this.totalPrice,
      serviceFee: serviceFee ?? this.serviceFee,
      formatTotalPrice: formatTotalPrice ?? this.formatTotalPrice,
      formatServiceFee: formatServiceFee ?? this.formatServiceFee,
      packageImages: packageImages ?? this.packageImages,
      packageStatusHistories:
          packageStatusHistories ?? this.packageStatusHistories,
      station: station ?? this.station,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'exprireReceiveGoods': exprireReceiveGoods,
      'name': name,
      'description': description,
      'priceCod': priceCod,
      'isCod': isCod,
      'barcode': barcode,
      'status': status.name,
      'weight': weight,
      'height': height,
      'width': width,
      'length': length,
      'volume': volume,
      'location': location,
      'sender': (sender as LocalUserModel).toMap(),
      'receiver': (receiver as LocalUserModel).toMap(),
      'totalDays': totalDays,
      'totalPrice': totalPrice,
      'serviceFee': serviceFee,
      'formatTotalPrice': formatTotalPrice,
      'formatServiceFee': formatServiceFee,
      'packageImages': packageImages,
      'packageStatusHistories': packageStatusHistories
          .map((x) => (x as PackageStatusHistoryModel).toMap())
          .toList(),
      'station': (station as StationModel).toMap(),
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      exprireReceiveGoods: map['exprireReceiveGoods'] ?? '',
      name: map['name'] as String,
      description: map['description'] as String,
      priceCod: map['priceCod'].toDouble(),
      isCod: map['isCod'] as bool,
      barcode: map['barcode'] ?? '',
      status: (map['status'] as String).toPackageStatus(),
      weight: map['weight'] as int,
      height: map['height'] as int,
      width: map['width'] as int,
      length: map['length'] as int,
      volume: map['volume'] as int,
      location: map['location'] as String,
      sender: LocalUserModel.fromMap(map['sender'] as Map<String, dynamic>),
      receiver: LocalUserModel.fromMap(map['receiver'] as Map<String, dynamic>),
      totalDays: map['totalDays'] as int,
      totalPrice: map['totalPrice'].toDouble(),
      serviceFee: map['serviceFee'].toDouble(),
      formatTotalPrice: map['formatTotalPrice'] as String,
      formatServiceFee: map['formatServiceFee'] as String,
      packageImages: List<String>.from((map['packageImages'] as List<dynamic>)
          .map((e) => e['imageUrl'] ?? '')),
      packageStatusHistories: List<PackageStatusHistory>.from(
        (map['packageStatusHistories'] as List<dynamic>)
            .map<PackageStatusHistory>(
          (x) => PackageStatusHistoryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      station: StationModel.fromMap(map['station'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Package(id: $id, createdAt: $createdAt, name: $name, exprireReceiveGoods: $exprireReceiveGoods)';
  }
}
