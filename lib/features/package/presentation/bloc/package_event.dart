part of 'package_bloc.dart';

sealed class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}

class GetPackageEvent extends PackageEvent {
  const GetPackageEvent({
    this.id,
    this.package,
  });
  final String? id;
  final Package? package;
}

class GetPackagesListEvent extends PackageEvent {
  final String? name;
  final PackageStatus? status;
  final UserType? type;
  final String? from;
  final String? to;
  const GetPackagesListEvent({
    this.name,
    this.status,
    this.type,
    this.from,
    this.to,
  });
}

class PackagesLoadMoreEvent extends PackageEvent {
  final String? name;
  final PackageStatus? status;
  final UserType? type;
  final String? from;
  final String? to;
  const PackagesLoadMoreEvent({
    this.name,
    this.status,
    this.type,
    this.from,
    this.to,
  });
}

class PayPackageEvent extends PackageEvent {
  final String id;
  final double totalPrice;

  const PayPackageEvent({
    required this.id,
    required this.totalPrice,
  });
}

class CancelPackageEvent extends PackageEvent {
  final String id;
  final String reason;

  const CancelPackageEvent({
    required this.id,
    required this.reason,
  });
}
