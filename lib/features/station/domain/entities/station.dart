
class Station {
  final int id;
  final String name;
  final String address;
  final String latitude;
  final String longitude;
  final String contactPhone;
  final List<String> stationImages;
  Station({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.contactPhone,
    required this.stationImages,
  });
}
