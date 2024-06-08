

import 'package:sstation/core/enums/package.dart';

class PackageStatusHistory {
  final int id;
  final String createdAt;
  final String name;
  final String description;
  final PackageStatus status;
  PackageStatusHistory({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.status,
  });

  PackageStatusHistory copyWith({
    int? id,
    String? createdAt,
    String? name,
    String? description,
    PackageStatus? status,
  }) {
    return PackageStatusHistory(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}
