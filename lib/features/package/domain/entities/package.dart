import 'package:sstation/core/enums/package.dart';
import 'package:sstation/features/package/domain/entities/package_status_history.dart';
import 'package:sstation/features/profile/domain/entities/user.dart';
import 'package:sstation/features/station/domain/entities/station.dart';

class Package {
  final String id;
  final String createdAt;
  final String exprireReceiveGoods;
  final String name;
  final String description;
  final double priceCod;
  final bool isCod;
  final String barcode;
  final PackageStatus status;
  final int weight;
  final int height;
  final int width;
  final int length;
  final int volume;
  final String location;
  final LocalUser sender;
  final LocalUser receiver;
  final int totalDays;
  final double totalPrice;
  final double serviceFee;
  final String formatTotalPrice;
  final String formatServiceFee;
  final List<String> packageImages;
  final List<PackageStatusHistory> packageStatusHistories;
  final Station station;
  Package({
    required this.id,
    required this.createdAt,
    required this.exprireReceiveGoods,
    required this.name,
    required this.description,
    required this.priceCod,
    required this.isCod,
    required this.barcode,
    required this.status,
    required this.weight,
    required this.height,
    required this.width,
    required this.length,
    required this.volume,
    required this.location,
    required this.sender,
    required this.receiver,
    required this.totalDays,
    required this.totalPrice,
    required this.serviceFee,
    required this.formatTotalPrice,
    required this.formatServiceFee,
    required this.packageImages,
    required this.packageStatusHistories,
    required this.station,
  });
}
