part of 'package_bloc.dart';

sealed class PackageState extends Equatable {
  const PackageState();

  @override
  List<Object> get props => [];
}

final class PackageInitial extends PackageState {}

final class PackagePaymentIniting extends PackageState {}

final class PackagesLoading extends PackageState {}

final class PackagesEmpty extends PackageState {}

final class PackagesError extends PackageState {
  final String message;
  const PackagesError({required this.message});
  @override
  List<Object> get props => [message];
}

final class PackagesListLoaded extends PackageState {
  final PackagesList packages;
  const PackagesListLoaded({
    required this.packages,
  });

  @override
  List<Object> get props =>
      [packages.packages.length, packages.reachMax, packages.currentPage];
}

final class PackageLoaded extends PackageState {
  final Package package;
  const PackageLoaded({required this.package});
}

final class PackagePaidSuccess extends PackageState {}

final class PackagePaidFailed extends PackageState {
  final String message;
  const PackagePaidFailed({required this.message});
  @override
  List<Object> get props => [message];
}

final class PackageCancelSuccess extends PackageState {}
