import 'package:flutter_config/flutter_config.dart';

String apiUrl() {
  return FlutterConfig.get('api_url');
}

String apiKey() {
  return FlutterConfig.get('api_key');
}
String apiUrlImage() {
  String url = FlutterConfig.get('api_url_image');
  return url;
}
