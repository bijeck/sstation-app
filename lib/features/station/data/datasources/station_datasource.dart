import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/extensions/map_extension.dart';
import 'package:sstation/core/services/api/api_constant.dart';
import 'package:sstation/core/services/api/api_request.dart';
import 'package:sstation/core/utils/log.dart';
import 'package:sstation/features/auth/domain/entities/user_token.dart';
import 'package:sstation/features/station/data/entities/station_list_model.dart';

abstract class StationDataSource {
  const StationDataSource();

  Future<StationsListModel> fetchStations({
    required String? search,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  });
}

@LazySingleton(as: StationDataSource)
class StationDataSourceImpl extends StationDataSource {
  const StationDataSourceImpl({
    required HiveInterface hiveAuth,
  }) : _hiveAuth = hiveAuth;

  final HiveInterface _hiveAuth;

  @override
  Future<StationsListModel> fetchStations({
    required String? search,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  }) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);
      Map<String, dynamic> queryParameters = {
        'search': search ?? '',
        'pageIndex': pageIndex.toString(),
        'pageSize': pageSize.toString(),
        'sortColumn': sortColumn ?? '',
        'sortDir': sortDir != null ? sortDir.toString().split('.').last : '',
      };
      queryParameters.removeWhere((key, value) => value.isEmpty);
      final response = await APIRequest.get(
        url:
            '${ApiConstants.stationsEndpoint}${queryParameters.toQueryString()}',
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      StationsListModel list = StationsListModel.fromJson(response.body);
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
}
