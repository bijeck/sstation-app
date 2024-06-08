// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_token_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTokenModelAdapter extends TypeAdapter<UserTokenModel> {
  @override
  final int typeId = 1;

  @override
  UserTokenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTokenModel(
      tokenType: fields[0] as String,
      accessToken: fields[1] as String,
      expiresIn: fields[2] as int,
      refreshToken: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserTokenModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.tokenType)
      ..writeByte(1)
      ..write(obj.accessToken)
      ..writeByte(2)
      ..write(obj.expiresIn)
      ..writeByte(3)
      ..write(obj.refreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTokenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}