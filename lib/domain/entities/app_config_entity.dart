class AppConfig {
  AppConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.connectTimeOut,
    required this.receiveTimeOut,

  });


  final String baseUrl;
  final String apiKey;
  final int connectTimeOut;
  final int receiveTimeOut;
}
