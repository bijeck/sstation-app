// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/enums/user.dart';
import 'package:sstation/core/utils/messages.dart';
import 'package:sstation/features/package/domain/entities/package.dart';

import 'package:sstation/features/package/domain/entities/packages_list.dart';
import 'package:sstation/features/package/domain/usecases/cancel_package.dart';
import 'package:sstation/features/package/domain/usecases/get_package.dart';
import 'package:sstation/features/package/domain/usecases/get_pakages_list.dart';
import 'package:sstation/features/package/domain/usecases/pay_package.dart';

part 'package_event.dart';
part 'package_state.dart';

@Injectable()
class PackageBloc extends Bloc<PackageEvent, PackageState> {
  PackagesList packages = PackagesList(
    packages: [],
    currentPage: 1,
    reachMax: false,
  );
  PackageBloc(
    GetPackagesList getPackagesList,
    GetPackage getPackage,
    PayPackage payPackage,
    CancelPackage cancelPackage,
  )   : _getPackagesList = getPackagesList,
        _getPackage = getPackage,
        _payPackage = payPackage,
        _cancelPackage = cancelPackage,
        super(PackageInitial()) {
    // on<PackageEvent>((event, emit) {
    //   emit(PackagesLoading());
    // });
    on<PackagesLoadMoreEvent>(_loadMoreHandler);
    on<GetPackagesListEvent>(_getPackagesListHandler);
    on<GetPackageEvent>(_getPackageHandler);
    on<PayPackageEvent>(_payPackageHandler);
    on<CancelPackageEvent>(_cancelPackageHandler);
  }

  final GetPackagesList _getPackagesList;
  final GetPackage _getPackage;
  final PayPackage _payPackage;
  final CancelPackage _cancelPackage;

  Future<void> _loadMoreHandler(
    PackagesLoadMoreEvent event,
    Emitter<PackageState> emit,
  ) async {
    // logger.d('Load more packages');
    bool isInitial = packages.currentPage == 1;
    if (isInitial) {
      emit(PackagesLoading());
    }
    final result = await _getPackagesList(GetPackagesListParams(
      name: event.name,
      status: event.status,
      type: event.type,
      from: event.from,
      to: event.to,
      pageIndex: isInitial ? 1 : packages.currentPage,
      pageSize: 4,
    ));
    result.fold(
      (failure) => emit(PackagesError(message: AppMessage.serverError)),
      (loadedPackages) {
        if (loadedPackages.packages.isEmpty) {
          packages = PackagesList(
              packages: packages.packages + loadedPackages.packages,
              currentPage: packages.currentPage,
              reachMax: loadedPackages.reachMax);
          emit(PackagesListLoaded(packages: packages));
        } else {
          //Adding products to existing list
          packages = PackagesList(
              packages: packages.packages + loadedPackages.packages,
              currentPage: packages.currentPage + 1,
              reachMax: loadedPackages.reachMax);
          emit(PackagesListLoaded(packages: packages));
        }
      },
    );
  }

  Future<void> _getPackagesListHandler(
    GetPackagesListEvent event,
    Emitter<PackageState> emit,
  ) async {
    bool isInitial = true;
    packages = PackagesList.reset();
    if (isInitial) {
      emit(PackagesLoading());
    }
    final result = await _getPackagesList(GetPackagesListParams(
      name: event.name,
      status: event.status,
      type: event.type,
      pageIndex: 1,
      pageSize: 4,
      from: event.from,
      to: event.to,
    ));
    result
        .fold((failure) => emit(PackagesError(message: AppMessage.serverError)),
            (loadedPackages) {
      if (loadedPackages.packages.isEmpty) {
        emit(PackagesEmpty());
      } else {
        packages = PackagesList(
            packages: loadedPackages.packages,
            currentPage: packages.currentPage + 1,
            reachMax: loadedPackages.reachMax);
        emit(PackagesListLoaded(packages: packages));
      }
    });
  }

  Future<void> _getPackageHandler(
    GetPackageEvent event,
    Emitter<PackageState> emit,
  ) async {
    emit(PackagesLoading());
    final result = await _getPackage(
      GetPackageParams(
        id: event.id,
        package: event.package,
      ),
    );
    result.fold(
      (failure) => emit(PackagesError(message: AppMessage.serverError)),
      (loadedPackage) => emit(PackageLoaded(package: loadedPackage)),
    );
  }

  Future<void> _payPackageHandler(
    PayPackageEvent event,
    Emitter<PackageState> emit,
  ) async {
    emit(PackagePaymentIniting());
    final result = await _payPackage(
      PayPackageParams(
        id: event.id,
        totalPrice: event.totalPrice,
      ),
    );
    result.fold(
      (failure) => emit(PackagePaidFailed(message: AppMessage.serverError)),
      (_) => emit(PackagePaidSuccess()),
    );
  }

  Future<void> _cancelPackageHandler(
    CancelPackageEvent event,
    Emitter<PackageState> emit,
  ) async {
    emit(PackagePaymentIniting());
    final result = await _cancelPackage(
      CancelPackageParams(
        id: event.id,
        reason: event.reason,
      ),
    );
    result.fold(
      (failure) => emit(PackagesError(message: AppMessage.serverError)),
      (_) => emit(PackageCancelSuccess()),
    );
  }
}
