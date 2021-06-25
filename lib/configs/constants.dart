class AppConstants {
  AppConstants._();

  static const String appName = 'Movie App';
  static const String apiKey="4eec8b69c7d354b31b3d15d1403c04c1";
  static const String baseUrl="https://api.themoviedb.org/3/";

  // Dio
  static const int receiveTimeout = 5000;
  static const int connectTimeout = 5000;

  static const int defaultOffset = 0;
  static const int defaultLimit = 10;
}
