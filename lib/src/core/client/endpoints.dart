import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  Endpoints._();

  static String baseURL = dotenv.get('BASE_URL');
  static const int receiveTimeout = 5000;
  static const int connectionTimeout = 30000;
  static const Duration receiveTimeoutDuration = Duration(milliseconds: receiveTimeout);
  static const Duration connectionTimeoutDuration = Duration(milliseconds: connectionTimeout);

  static const String movies = '/movies';
}
