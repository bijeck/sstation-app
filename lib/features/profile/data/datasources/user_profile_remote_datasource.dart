import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sstation/core/errors/exceptions.dart';
import 'package:sstation/core/services/api/api_constant.dart';
import 'package:sstation/core/services/api/api_request.dart';
import 'package:sstation/core/utils/log.dart';
import 'package:sstation/features/auth/domain/entities/user_token.dart';
import 'package:sstation/features/profile/data/entities/user_model.dart';

abstract class UserProfileRemoteDataSource {
  const UserProfileRemoteDataSource();

  Future<LocalUserModel> initUserProfile();

  Future<void> updateUserProfile({
    required String userId,
    required String fullName,
    required String email,
    required String avatarUrl,
    required File? newImage,
  });

  Future<void> changePassword(
      {required String oldPassword, required String newPassword});
}

@LazySingleton(
  as: UserProfileRemoteDataSource,
)
class UserProfileRemoteDataSourceImpl extends UserProfileRemoteDataSource {
  const UserProfileRemoteDataSourceImpl({
    required HiveInterface hiveAuth,
    required FirebaseStorage dbClient,
  })  : _hiveAuth = hiveAuth,
        _dbClient = dbClient;

  final HiveInterface _hiveAuth;
  final FirebaseStorage _dbClient;

  @override
  Future<LocalUserModel> initUserProfile() async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final response = await APIRequest.get(
        url: '${ApiConstants.usersEndpoint}/profile',
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        throw ServerException(
          message: response.body.toString(),
          statusCode: response.statusCode.toString(),
        );
      }
      return LocalUserModel.fromJson(response.body);
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
  Future<void> updateUserProfile({
    required String userId,
    required String fullName,
    required String email,
    required String avatarUrl,
    required File? newImage,
  }) async {
    try {
      if (newImage != null) {
        final ref = _dbClient.ref().child('profile_pics/$userId.png');

        await ref.putFile(newImage);
        avatarUrl = await ref.getDownloadURL();
      }

      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final response = await APIRequest.put(
        url: '${ApiConstants.usersEndpoint}/profile',
        body: {
          'fullName': fullName,
          'email': email,
          'avatarUrl': avatarUrl,
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
      return;
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
  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      UserToken userToken = await APIRequest.getUserToken(_hiveAuth);

      final response = await APIRequest.post(
        url: '${ApiConstants.usersEndpoint}/change-password',
        body: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        token: userToken.accessToken,
      );
      if (response.statusCode != 200) {
        logger.e('Could not finalize api due to: ${response.body.toString()}');
        if (response.statusCode == 400) {
          throw ServerException(
            message: 'Your current password is incorrect',
            statusCode: response.statusCode.toString(),
          );
        } else {
          throw ServerException(
            message: response.body.toString(),
            statusCode: response.statusCode.toString(),
          );
        }
      }
      return;
    } on ServerException {
      rethrow;
    }
  }
}
