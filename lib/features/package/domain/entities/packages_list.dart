import 'package:sstation/features/package/domain/entities/package.dart';

class PackagesList {
  final List<Package> packages;
  final bool reachMax;
  final int currentPage;
  PackagesList({
    required this.packages,
    required this.reachMax,
    required this.currentPage,
  });

  PackagesList.reset()
      : packages = [],
        reachMax = false,
        currentPage = 1;

  PackagesList copyWith({
    List<Package>? packages,
    bool? reachMax,
    int? currentPage,
  }) {
    return PackagesList(
      packages: packages ?? this.packages,
      reachMax: reachMax ?? this.reachMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
