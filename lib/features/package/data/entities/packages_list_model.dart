import 'dart:convert';

import 'package:sstation/features/package/data/entities/package_model.dart';
import 'package:sstation/features/package/domain/entities/packages_list.dart';

class PackagesListModel extends PackagesList {
  PackagesListModel({
    required super.packages,
    required super.reachMax,
    required super.currentPage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packages': packages.map((x) => (x as PackageModel).toMap()).toList(),
      'reachMax': reachMax,
      'currentPage': currentPage,
    };
  }

  factory PackagesListModel.fromMap(Map<String, dynamic> map) {
    return PackagesListModel(
      packages: List<PackageModel>.from(
        (map['contends'] as List<dynamic>).map<PackageModel>(
          (x) => PackageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      reachMax: !map['hasNextPage'],
      currentPage: map['page'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackagesListModel.fromJson(String source) =>
      PackagesListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PackagesList(products: $packages, reachMax: $reachMax, currentPage: $currentPage)';
}
