import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/sort_direction.dart';
import 'package:sstation/core/enums/transaction.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/extensions/map_extension.dart';
import 'package:sstation/core/services/api/api_constant.dart';
import 'package:sstation/core/services/api/api_request.dart';
import 'package:sstation/core/utils/core_utils.dart';
import 'package:sstation/core/utils/log.dart';
import 'package:sstation/features/auth/domain/entities/user_token.dart';
import 'package:sstation/features/transaction/data/entities/transaction_model.dart';
import 'package:sstation/features/transaction/data/entities/transactions_list_model.dart';

abstract class TransactionDatasource {
  const TransactionDatasource();

  Future<TransactionsListModel> getTransactionsList({
    required TransactionType? type,
    required String? from,
    required String? to,
    required int pageIndex,
    required int pageSize,
    required String? sortColumn,
    required SortDirection? sortDir,
  });
  Future<TransactionModel> getTransaction({
    required String? id,
  });
}

@LazySingleton(as: TransactionDatasource)
class TransactionDatasourceImpl extends TransactionDatasource {
  const TransactionDatasourceImpl({
    required HiveInterface hiveAuth,
  }) : _hiveAuth = hiveAuth;

  final HiveInterface _hiveAuth;

  @override
  Future<TransactionModel> getTransaction({required String? id}) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final response = await APIRequest.get(
        url: '${ApiConstants.transactionsEndpoint}/$id',
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      TransactionModel transaction = TransactionModel.fromJson(response.body);
      return transaction;
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
  Future<TransactionsListModel> getTransactionsList({
    required TransactionType? type,
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
            '${ApiConstants.transactionsEndpoint}${queryParameters.toQueryString()}',
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      TransactionsListModel list =
          TransactionsListModel.fromJson(response.body);
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
