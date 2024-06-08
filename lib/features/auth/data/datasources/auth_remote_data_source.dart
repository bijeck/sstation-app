import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/services/api/api_constant.dart';
import 'package:sstation/core/services/api/api_request.dart';
import 'package:sstation/core/utils/log.dart';
import 'package:sstation/features/auth/data/models/user_token_model.dart';
import 'package:sstation/features/auth/domain/entities/user_token.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<UserTokenModel> signIn({
    required String phoneNumber,
    required String password,
  });

  Future<void> signUp({
    required String phoneNumber,
    required String fullName,
    required String password,
    required String token,
  });

  Future<void> verifyPhoneNumber({required String phoneNumber});

  Future<String> sentOTPVerification(
      {required String phoneNumber, required String otp});
  Future<void> resetPassword({
    required String newPassword,
    required String token,
  });
  Future<void> signOut();
}

@LazySingleton(
  as: AuthRemoteDataSource,
)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required HiveInterface hiveAuth,
    required SharedPreferences prefs,
    required FirebaseMessaging messaging,
  })  : _hiveAuth = hiveAuth,
        _messaging = messaging;

  final HiveInterface _hiveAuth;
  final FirebaseMessaging _messaging;

  @override
  Future<UserTokenModel> signIn({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await APIRequest.post(
        url: '${ApiConstants.authEndpoint}/login',
        body: {
          'username': phoneNumber,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      var token = UserTokenModel.fromJson(response.body);

      if (!await _hiveAuth.boxExists('token')) {
        await _hiveAuth.openBox('token');
      }
      if (!_hiveAuth.isBoxOpen('token')) {
        await _hiveAuth.openBox('token');
      }

      var tokenBox = _hiveAuth.box('token');

      if (tokenBox.containsKey('fcmToken')) {
        String fcmToken = tokenBox.get('fcmToken');
        final response = await APIRequest.post(
          url: ApiConstants.devicesEndpoint,
          body: {
            'token': fcmToken,
          },
          token: token.accessToken,
        );

        logger.i('Devices response : $response');
      } else {
        _messaging.getToken().then((value) async {
          await tokenBox.put('fcmToken', value);
          await APIRequest.post(
            url: ApiConstants.devicesEndpoint,
            body: {
              'token': value,
            },
            token: token.accessToken,
          );
        });
      }

      await tokenBox.put('userToken', token);
      logger.i('Sign in token : $token');
      return token;
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
  Future<String> sentOTPVerification(
      {required String phoneNumber, required String otp}) async {
    try {
      final response = await APIRequest.post(
        url: '${ApiConstants.authEndpoint}/verify-otp',
        body: {
          'phoneNumber': phoneNumber,
          'otp': otp,
        },
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      var payload = jsonDecode(response.body);
      return payload['accessToken'];
    } on ServerException {
      rethrow;
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Issue with the server',
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> verifyPhoneNumber({required String phoneNumber}) async {
    try {
      final response = await APIRequest.post(
        url: '${ApiConstants.authEndpoint}/send-otp',
        body: {
          'phoneNumber': phoneNumber,
        },
      );
      logger.i(
          ' code ${response.statusCode.toString()} message ${jsonDecode(response.body).toString()}');
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
        message: 'Issue with the server',
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> signUp({
    required String phoneNumber,
    required String fullName,
    required String password,
    required String token,
  }) async {
    logger
        .i('phone number :$phoneNumber, name: $fullName, password: $password');
    try {
      final response = await APIRequest.patch(
        url: '${ApiConstants.usersEndpoint}/set-password',
        body: {
          'fullName': fullName,
          'newPassword': password,
        },
        token: token,
      );

      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
    } catch (e, s) {
      logger.e(e);
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Issue with the server',
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> resetPassword({
    required String newPassword,
    required String token,
  }) async {
    try {
      final response = await APIRequest.post(
        url: '${ApiConstants.usersEndpoint}/reset-password',
        body: {
          'newPassword': newPassword,
        },
        token: token,
      );

      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Issue with the server',
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);
      if (!await _hiveAuth.boxExists('token')) {
        await _hiveAuth.openBox('token');
      }
      if (!_hiveAuth.isBoxOpen('token')) {
        await _hiveAuth.openBox('token');
      }

      var tokenBox = _hiveAuth.box('token');

      if (tokenBox.containsKey('fcmToken')) {
        String fcmToken = tokenBox.get('fcmToken');
        var response = await APIRequest.delete(
          url: ApiConstants.devicesEndpoint,
          body: {
            'token': fcmToken,
          },
          token: userToken.accessToken,
        );
        logger.d('Devices response : ${response.body.toString()}');
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Issue with the server',
        statusCode: '505',
      );
    }
  }
}
