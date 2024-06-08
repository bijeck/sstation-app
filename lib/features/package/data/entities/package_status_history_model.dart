import 'dart:convert';
import 'package:sstation/core/extensions/string_extension.dart';
import 'package:sstation/features/package/domain/entities/package_status_history.dart';

class PackageStatusHistoryModel extends PackageStatusHistory {
  PackageStatusHistoryModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.description,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'name': name,
      'description': description,
      'status': status.name,
    };
  }

  factory PackageStatusHistoryModel.fromMap(Map<String, dynamic> map) {
    return PackageStatusHistoryModel(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      status: (map['status'] as String).toPackageStatus(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageStatusHistoryModel.fromJson(String source) =>
      PackageStatusHistoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PackageStatusHistory(id: $id, createdAt: $createdAt, name: $name, description: $description, status: $status)';
  }
}
