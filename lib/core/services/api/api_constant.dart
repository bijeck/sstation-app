class ApiConstants {
  // static String baseUrl = 'http://192.168.1.7:8080'; //wifi home
  // static String baseUrl = 'http://10.0.2.2:8080'; //localhost mobile
  static String baseUrl = 'https://shipperstation.runasp.net';
  static String appLink = 'https://sstation-ac2ef.web.app/result/';

  static String authEndpoint = '$baseUrl/api/auth';
  static String usersEndpoint = '$baseUrl/api/users';
  static String paymentEndpoint = '$baseUrl/api/payments';
  static String devicesEndpoint = '$baseUrl/api/devices';
  static String packagesEndpoint = '$baseUrl/api/users/packages';
  static String stationsEndpoint = '$baseUrl/api/stations';
  static String transactionsEndpoint = '$baseUrl/api/transactions';
  static String notificationsEndpoint = '$baseUrl/api/notifications';
}
