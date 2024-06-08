extension MapExtension on Map {
  String toQueryString() {
    return '?${entries.map((e) => '${e.key}=${e.value}').join('&')}';
  }
}
