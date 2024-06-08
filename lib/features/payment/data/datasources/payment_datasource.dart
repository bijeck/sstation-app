import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/enums/payment.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/services/api/api_constant.dart';
import 'package:sstation/core/services/api/api_request.dart';
import 'package:sstation/core/utils/log.dart';
import 'package:sstation/features/auth/domain/entities/user_token.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class PaymentDataSource {
  const PaymentDataSource();

  Future<void> deposit({
    required int money,
    required PaymentProvider provider,
  });
  Future<void> withdraw({
    required int money,
    required String id,
    required PaymentProvider provider,
  });
}

@LazySingleton(as: PaymentDataSource)
class PaymentDataSourceImpl extends PaymentDataSource {
  const PaymentDataSourceImpl({
    required HiveInterface hiveAuth,
  }) : _hiveAuth = hiveAuth;
  final HiveInterface _hiveAuth;
  @override
  Future<void> deposit({
    required int money,
    required PaymentProvider provider,
  }) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final redirectResponse = await APIRequest.post(
        url:
            '${ApiConstants.paymentEndpoint}/deposit?returnUrl=${ApiConstants.appLink}',
        body: {
          'amount': money,
          'method': provider.name,
        },
        token: userToken.accessToken,
      );

      if (redirectResponse.statusCode != 200) {
        logger.e(
            'Could not finalize api due to: ${redirectResponse.body.toString()}');
        throw ServerException(
          message: redirectResponse.body.toString(),
          statusCode: redirectResponse.statusCode.toString(),
        );
      }
      logger.i(redirectResponse.body.replaceAll('"', ''));
      var url = Uri.parse(redirectResponse.body.replaceAll('"', ''));
      await launchUrl(url, mode: LaunchMode.externalApplication);
      // return;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Please try again later',
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> withdraw({
    required int money,
    required String id,
    required PaymentProvider provider,
  }) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final redirectResponse = await APIRequest.post(
        url: '${ApiConstants.paymentEndpoint}/withdraw',
        body: {
          'amount': money,
        },
        token: userToken.accessToken,
      );

      if (redirectResponse.statusCode != 200) {
        logger.e(
            'Could not finalize api due to: ${redirectResponse.body.toString()}');
        if (redirectResponse.statusCode == 400) {
          throw ServerException(
            message: (jsonDecode(redirectResponse.body)
                as Map<String, dynamic>)['errors']['amount'][0],
            statusCode: redirectResponse.statusCode.toString(),
          );
        } else {
          throw ServerException(
            message: redirectResponse.body.toString(),
            statusCode: redirectResponse.statusCode.toString(),
          );
        }
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Please try again later',
        statusCode: '505',
      );
    }
  }
}
