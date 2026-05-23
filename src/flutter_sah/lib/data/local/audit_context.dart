import 'dart:io';

/// Estado global capturado em runtime para enriquecer os audit logs.
///
/// `currentRoute` é atualizado por um listener do GoRouter em main.dart.
/// `ipAddress` e `platform` são preenchidos uma vez no boot via [init].
class AuditContext {
  static String? _currentRoute;
  static String? _ipAddress;
  static String? _platform;

  static String? get currentRoute => _currentRoute;
  static String? get ipAddress => _ipAddress;
  static String? get platform => _platform;

  static void setRoute(String route) {
    _currentRoute = route;
  }

  static Future<void> init() async {
    try {
      _platform = Platform.operatingSystem;
    } catch (_) {
      _platform = null;
    }
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLoopback: false,
        includeLinkLocal: false,
      );
      for (final iface in interfaces) {
        for (final addr in iface.addresses) {
          if (!addr.isLoopback) {
            _ipAddress = addr.address;
            return;
          }
        }
      }
    } catch (_) {
      _ipAddress = null;
    }
  }
}
