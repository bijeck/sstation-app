// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_messaging/firebase_messaging.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i18;
import 'package:sstation/core/services/injections/module.dart' as _i58;
import 'package:sstation/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i29;
import 'package:sstation/features/auth/data/repos/auth_repo_impl.dart' as _i31;
import 'package:sstation/features/auth/domain/repos/auth_repo.dart' as _i30;
import 'package:sstation/features/auth/domain/usecases/reset_password.dart'
    as _i47;
import 'package:sstation/features/auth/domain/usecases/sent_otp_verification.dart'
    as _i48;
import 'package:sstation/features/auth/domain/usecases/sign_in.dart' as _i49;
import 'package:sstation/features/auth/domain/usecases/sign_out.dart' as _i50;
import 'package:sstation/features/auth/domain/usecases/sign_up.dart' as _i51;
import 'package:sstation/features/auth/domain/usecases/verify_phone_number.dart'
    as _i56;
import 'package:sstation/features/auth/presentation/bloc/auth_bloc.dart'
    as _i57;
import 'package:sstation/features/notification/data/datasources/notification_datasource.dart'
    as _i6;
import 'package:sstation/features/notification/data/repos/notification_repo_impl.dart'
    as _i8;
import 'package:sstation/features/notification/domain/repos/notification_repo.dart'
    as _i7;
import 'package:sstation/features/notification/domain/usecases/delete_notifications.dart'
    as _i34;
import 'package:sstation/features/notification/domain/usecases/get_notification.dart'
    as _i37;
import 'package:sstation/features/notification/domain/usecases/get_notifications_list.dart'
    as _i38;
import 'package:sstation/features/notification/domain/usecases/read_all_notification.dart'
    as _i16;
import 'package:sstation/features/notification/domain/usecases/read_notification.dart'
    as _i17;
import 'package:sstation/features/notification/presentation/bloc/notification_bloc.dart'
    as _i44;
import 'package:sstation/features/package/data/datasources/package_datasource.dart'
    as _i9;
import 'package:sstation/features/package/data/repos/package_repo_impl.dart'
    as _i11;
import 'package:sstation/features/package/domain/repos/package_repo.dart'
    as _i10;
import 'package:sstation/features/package/domain/usecases/cancel_package.dart'
    as _i32;
import 'package:sstation/features/package/domain/usecases/get_package.dart'
    as _i39;
import 'package:sstation/features/package/domain/usecases/get_pakages_list.dart'
    as _i40;
import 'package:sstation/features/package/domain/usecases/pay_package.dart'
    as _i12;
import 'package:sstation/features/package/presentation/bloc/package_bloc.dart'
    as _i45;
import 'package:sstation/features/payment/data/datasources/payment_datasource.dart'
    as _i13;
import 'package:sstation/features/payment/data/repos/payment_repo_impl.dart'
    as _i15;
import 'package:sstation/features/payment/domain/repos/payment_repo.dart'
    as _i14;
import 'package:sstation/features/payment/domain/usecase/deposit.dart' as _i35;
import 'package:sstation/features/payment/domain/usecase/withdraw.dart' as _i28;
import 'package:sstation/features/payment/presentation/bloc/payment_bloc.dart'
    as _i46;
import 'package:sstation/features/profile/data/datasources/user_profile_remote_datasource.dart'
    as _i25;
import 'package:sstation/features/profile/data/repos/user_profile_repo_impl.dart'
    as _i27;
import 'package:sstation/features/profile/domain/repos/user_profile_repo.dart'
    as _i26;
import 'package:sstation/features/profile/domain/usecases/change_password.dart'
    as _i33;
import 'package:sstation/features/profile/domain/usecases/init_user_profile.dart'
    as _i43;
import 'package:sstation/features/profile/domain/usecases/update_user_profile.dart'
    as _i54;
import 'package:sstation/features/profile/presentation/bloc/user_profile_bloc.dart'
    as _i55;
import 'package:sstation/features/station/data/datasources/station_datasource.dart'
    as _i19;
import 'package:sstation/features/station/data/repos/station_repo_impl.dart'
    as _i21;
import 'package:sstation/features/station/domain/repos/station_repo.dart'
    as _i20;
import 'package:sstation/features/station/domain/usecase/fetch_stations.dart'
    as _i36;
import 'package:sstation/features/station/presentation/bloc/station_bloc.dart'
    as _i52;
import 'package:sstation/features/transaction/data/datasources/transaction_datasource.dart'
    as _i22;
import 'package:sstation/features/transaction/data/repos/transaction_repo_impl.dart'
    as _i24;
import 'package:sstation/features/transaction/domain/repos/transaction_repo.dart'
    as _i23;
import 'package:sstation/features/transaction/domain/usecases/get_transaction.dart'
    as _i41;
import 'package:sstation/features/transaction/domain/usecases/get_transactions_list.dart'
    as _i42;
import 'package:sstation/features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i53;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.FirebaseMessaging>(
        () => registerModule.firebaseMessaging);
    gh.lazySingleton<_i4.FirebaseStorage>(() => registerModule.firebaseStorage);
    gh.lazySingleton<_i5.HiveInterface>(() => registerModule.hive);
    gh.lazySingleton<_i6.NotificationDatasource>(() =>
        _i6.NotificationDatasourceImpl(hiveAuth: gh<_i5.HiveInterface>()));
    gh.lazySingleton<_i7.NotificationRepo>(
        () => _i8.NotificationRepoImpl(gh<_i6.NotificationDatasource>()));
    gh.lazySingleton<_i9.PackageDatasource>(
        () => _i9.PackageDatasourceImpl(hiveAuth: gh<_i5.HiveInterface>()));
    gh.lazySingleton<_i10.PackageRepo>(
        () => _i11.PackageRepoImpl(gh<_i9.PackageDatasource>()));
    gh.lazySingleton<_i12.PayPackage>(
        () => _i12.PayPackage(gh<_i10.PackageRepo>()));
    gh.lazySingleton<_i13.PaymentDataSource>(
        () => _i13.PaymentDataSourceImpl(hiveAuth: gh<_i5.HiveInterface>()));
    gh.lazySingleton<_i14.PaymentRepo>(
        () => _i15.PaymentRepoImpl(gh<_i13.PaymentDataSource>()));
    gh.lazySingleton<_i16.ReadAllNotifications>(
        () => _i16.ReadAllNotifications(gh<_i7.NotificationRepo>()));
    gh.lazySingleton<_i17.ReadNotification>(
        () => _i17.ReadNotification(gh<_i7.NotificationRepo>()));
    await gh.lazySingletonAsync<_i18.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i19.StationDataSource>(
        () => _i19.StationDataSourceImpl(hiveAuth: gh<_i5.HiveInterface>()));
    gh.lazySingleton<_i20.StationRepo>(
        () => _i21.StationRepoImpl(gh<_i19.StationDataSource>()));
    gh.lazySingleton<_i22.TransactionDatasource>(() =>
        _i22.TransactionDatasourceImpl(hiveAuth: gh<_i5.HiveInterface>()));
    gh.lazySingleton<_i23.TransactionRepo>(
        () => _i24.TransactionRepoImpl(gh<_i22.TransactionDatasource>()));
    gh.lazySingleton<_i25.UserProfileRemoteDataSource>(
        () => _i25.UserProfileRemoteDataSourceImpl(
              hiveAuth: gh<_i5.HiveInterface>(),
              dbClient: gh<_i4.FirebaseStorage>(),
            ));
    gh.lazySingleton<_i26.UserRepo>(
        () => _i27.UserRepoImpl(gh<_i25.UserProfileRemoteDataSource>()));
    gh.lazySingleton<_i28.WithDraw>(
        () => _i28.WithDraw(gh<_i14.PaymentRepo>()));
    gh.lazySingleton<_i29.AuthRemoteDataSource>(
        () => _i29.AuthRemoteDataSourceImpl(
              hiveAuth: gh<_i5.HiveInterface>(),
              prefs: gh<_i18.SharedPreferences>(),
              messaging: gh<_i3.FirebaseMessaging>(),
            ));
    gh.lazySingleton<_i30.AuthRepo>(
        () => _i31.AuthRepoImpl(gh<_i29.AuthRemoteDataSource>()));
    gh.lazySingleton<_i32.CancelPackage>(
        () => _i32.CancelPackage(gh<_i10.PackageRepo>()));
    gh.lazySingleton<_i33.ChangePassword>(
        () => _i33.ChangePassword(gh<_i26.UserRepo>()));
    gh.lazySingleton<_i34.DeleteNotifications>(
        () => _i34.DeleteNotifications(gh<_i7.NotificationRepo>()));
    gh.lazySingleton<_i35.Deposit>(() => _i35.Deposit(gh<_i14.PaymentRepo>()));
    gh.lazySingleton<_i36.FetchStations>(
        () => _i36.FetchStations(gh<_i20.StationRepo>()));
    gh.lazySingleton<_i37.GetNotification>(
        () => _i37.GetNotification(gh<_i7.NotificationRepo>()));
    gh.lazySingleton<_i38.GetNotificationsList>(
        () => _i38.GetNotificationsList(gh<_i7.NotificationRepo>()));
    gh.lazySingleton<_i39.GetPackage>(
        () => _i39.GetPackage(gh<_i10.PackageRepo>()));
    gh.lazySingleton<_i40.GetPackagesList>(
        () => _i40.GetPackagesList(gh<_i10.PackageRepo>()));
    gh.lazySingleton<_i41.GetTransaction>(
        () => _i41.GetTransaction(gh<_i23.TransactionRepo>()));
    gh.lazySingleton<_i42.GetTransactionsList>(
        () => _i42.GetTransactionsList(gh<_i23.TransactionRepo>()));
    gh.lazySingleton<_i43.InitUserProfile>(
        () => _i43.InitUserProfile(gh<_i26.UserRepo>()));
    gh.factory<_i44.NotificationBloc>(() => _i44.NotificationBloc(
          gh<_i38.GetNotificationsList>(),
          gh<_i37.GetNotification>(),
          gh<_i17.ReadNotification>(),
          gh<_i16.ReadAllNotifications>(),
          gh<_i34.DeleteNotifications>(),
        ));
    gh.factory<_i45.PackageBloc>(() => _i45.PackageBloc(
          gh<_i40.GetPackagesList>(),
          gh<_i39.GetPackage>(),
          gh<_i12.PayPackage>(),
          gh<_i32.CancelPackage>(),
        ));
    gh.factory<_i46.PaymentBloc>(() => _i46.PaymentBloc(
          deposit: gh<_i35.Deposit>(),
          withdraw: gh<_i28.WithDraw>(),
        ));
    gh.lazySingleton<_i47.ResetPassword>(
        () => _i47.ResetPassword(gh<_i30.AuthRepo>()));
    gh.lazySingleton<_i48.SentOTPVerification>(
        () => _i48.SentOTPVerification(gh<_i30.AuthRepo>()));
    gh.lazySingleton<_i49.SignIn>(() => _i49.SignIn(gh<_i30.AuthRepo>()));
    gh.lazySingleton<_i50.SignOut>(() => _i50.SignOut(gh<_i30.AuthRepo>()));
    gh.lazySingleton<_i51.SignUp>(() => _i51.SignUp(gh<_i30.AuthRepo>()));
    gh.factory<_i52.StationBloc>(
        () => _i52.StationBloc(gh<_i36.FetchStations>()));
    gh.factory<_i53.TransactionBloc>(() => _i53.TransactionBloc(
          gh<_i42.GetTransactionsList>(),
          gh<_i41.GetTransaction>(),
        ));
    gh.lazySingleton<_i54.UpdateUserProfile>(
        () => _i54.UpdateUserProfile(gh<_i26.UserRepo>()));
    gh.factory<_i55.UserProfileBloc>(() => _i55.UserProfileBloc(
          initUserProfile: gh<_i43.InitUserProfile>(),
          updateUserProfile: gh<_i54.UpdateUserProfile>(),
          changedPassword: gh<_i33.ChangePassword>(),
        ));
    gh.lazySingleton<_i56.VerifyPhoneNumber>(
        () => _i56.VerifyPhoneNumber(gh<_i30.AuthRepo>()));
    gh.factory<_i57.AuthBloc>(() => _i57.AuthBloc(
          signIn: gh<_i49.SignIn>(),
          signUp: gh<_i51.SignUp>(),
          verifyPhoneNumber: gh<_i56.VerifyPhoneNumber>(),
          sentOTPVerification: gh<_i48.SentOTPVerification>(),
          resetPassword: gh<_i47.ResetPassword>(),
          signOut: gh<_i50.SignOut>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i58.RegisterModule {}
