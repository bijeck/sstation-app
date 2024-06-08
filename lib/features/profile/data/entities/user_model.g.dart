// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalUserModelAdapter extends TypeAdapter<LocalUserModel> {
  @override
  final int typeId = 5;

  @override
  LocalUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalUserModel(
      id: fields[0] as String,
      userName: fields[1] as String,
      phoneNumber: fields[2] as String,
      fullName: fields[3] as String,
      avatarUrl: fields[4] as String,
      email: fields[5] as String,
      wallet: fields[6] as WalletModel,
      devices: (fields[7] as List).cast<DeviceModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocalUserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.avatarUrl)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.wallet)
      ..writeByte(7)
      ..write(obj.devices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
