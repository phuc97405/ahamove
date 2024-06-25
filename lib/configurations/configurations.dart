import 'default_env.dart';

class Configurations {
  static String _environment = DefaultConfig.environment;
  static String _baseUrl = DefaultConfig.baseUrl;
  static const String appId = '';
  static const String appName = 'Ahamove';
  static const String version = '1.0.0';

  static bool _isDebug = DefaultConfig.isDebug;
  static bool _isProduction = DefaultConfig.isProduction;

  void setConfigurationValues(Map<String, dynamic> value) {
    _environment = value['environment'] ?? DefaultConfig.environment;
    _baseUrl = value['baseUrl'] ?? DefaultConfig.baseUrl;
    _isDebug = value['isDebug'] ?? DefaultConfig.isDebug;
    _isProduction = value['isProduction'] ?? DefaultConfig.isProduction;
  }

  static String get environment => _environment;
  static String get baseUrl => _baseUrl;

  static bool get isDebug => _isDebug;
  static bool get isProduction => _isProduction;
}
