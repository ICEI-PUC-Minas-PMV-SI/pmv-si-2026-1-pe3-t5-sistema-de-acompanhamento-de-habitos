import 'dart:io';

/// Estado global capturado em runtime para enriquecer os audit logs.
///
/// `currentRoute` é atualizado por um listener do GoRouter em app.dart.
/// `ipAddress` e `platform` são preenchidos em [init] (boot) e re-capturados
/// em [refresh] (chamado ao retomar o app após troca de Wi-Fi/4G).
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

  /// Captura inicial no boot.
  static Future<void> init() async {
    try {
      _platform = Platform.operatingSystem;
    } catch (_) {
      _platform = null;
    }
    await refresh();
  }

  /// Re-captura o IP local. Útil ao retomar o app (network pode ter mudado).
  /// Plataforma não muda em runtime, então não é re-capturada.
  static Future<void> refresh() async {
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
      _ipAddress = null;
    } catch (_) {
      _ipAddress = null;
    }
  }
}
