import 'dart:convert';

import 'package:sstation/features/station/domain/entities/station.dart';

class StationModel extends Station {
  StationModel({
    required super.id,
    required super.name,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.contactPhone,
    required super.stationImages,
  });

  StationModel copyWith({
    int? id,
    String? name,
    String? address,
    String? latitude,
    String? longitude,
    String? contactPhone,
    List<String>? stationImages,
  }) {
    return StationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      contactPhone: contactPhone ?? this.contactPhone,
      stationImages: stationImages ?? this.stationImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'contactPhone': contactPhone,
      'stationImages': stationImages,
    };
  }

  factory StationModel.fromMap(Map<String, dynamic> map) {
    return StationModel(
      id: map['id'] as int,
      name: map['name'] as String,
      address: map['address'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      contactPhone: map['contactPhone'] ?? '',
      stationImages: List<String>.from(
          (map['stationImages'] as List<dynamic>)
              .map((e) => e['imageUrl'] as String)),
    );
  }

  String toJson() => json.encode(toMap());

  factory StationModel.fromJson(String source) =>
      StationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Station(id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, contactPhone: $contactPhone, stationImages: $stationImages)';
  }
}
