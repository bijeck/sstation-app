import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/package.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/enums/user.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/extensions/map_extension.dart';
import 'package:sstation/core/services/api/api_constant.dart';
import 'package:sstation/core/services/api/api_request.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/core/utils/log.dart';
import 'package:sstation/features/auth/domain/entities/user_token.dart';
import 'package:sstation/features/package/data/entities/package_model.dart';
import 'package:sstation/features/package/data/entities/packages_list_model.dart';

abstract class PackageDatasource {
  const PackageDatasource();

  Future<PackagesListModel> getPackagesList({
    required String? name,
    required PackageStatus? status,
    required UserType? type,
    required String? from,
    required String? to,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  });
  Future<PackageModel> getPackage({
    required String id,
  });
  Future<void> payPackage({
    required String id,
    required double totalPrice,
  });
  Future<void> cancelPackage({
    required String id,
    required String reason,
  });
}

@LazySingleton(as: PackageDatasource)
class PackageDatasourceImpl extends PackageDatasource {
  const PackageDatasourceImpl({
    required HiveInterface hiveAuth,
  }) : _hiveAuth = hiveAuth;

  final HiveInterface _hiveAuth;

  @override
  Future<PackagesListModel> getPackagesList({
    required String? name,
    required PackageStatus? status,
    required UserType? type,
    required String? from,
    required String? to,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  }) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      Map<String, dynamic> queryParameters = {
        'name': name ?? '',
        'status': status != null ? status.name : '',
        'type': type != null ? type.name : '',
        'from': from != null ? CoreUtils.reformatDate(from) : '',
        'to': to != null ? CoreUtils.reformatDate(to) : '',
        'pageIndex': pageIndex.toString(),
        'pageSize': pageSize.toString(),
        'sortColumn': sortColumn ?? '',
        'sortDir': sortDir != null ? sortDir.name : '',
      };
      queryParameters.removeWhere((key, value) => value.isEmpty);

      final response = await APIRequest.get(
        url:
            '${ApiConstants.packagesEndpoint}${queryParameters.toQueryString()}',
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
       logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      PackagesListModel list = PackagesListModel.fromJson(response.body);
      return list;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server error',
        statusCode: '500',
      );
    }
  }

  @override
  Future<PackageModel> getPackage({required String id}) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final response = await APIRequest.get(
        url: '${ApiConstants.packagesEndpoint}/$id',
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      PackageModel package = PackageModel.fromJson(response.body);
      return package;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server error',
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> payPackage({
    required String id,
    required double totalPrice,
  }) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final response = await APIRequest.post(
        url: '${ApiConstants.packagesEndpoint}/$id/payment',
        body: {
          'totalPrice': totalPrice,
        },
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server error',
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> cancelPackage({required String id, required String reason}) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final response = await APIRequest.post(
        url: '${ApiConstants.packagesEndpoint}/$id/cancel',
        body: {
          'reason': reason,
        },
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Server error',
        statusCode: '500',
      );
    }
  }
}
