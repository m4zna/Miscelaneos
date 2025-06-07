import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {}

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {}
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate({bool biometricOnly = false}) async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Por favor autentiquese para continuar',
          options: AuthenticationOptions(biometricOnly: biometricOnly));
      return (didAuthenticate, didAuthenticate ? 'Autenticación exitosa' : 'Autenticación fallida');
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) return (false, 'No hay biometricos registrados');
      if (e.code == auth_error.lockedOut) return (false, 'Muchos intentos fallidos');
      if (e.code == auth_error.notAvailable) return (false, 'No hay biometricos disponibles');
      if (e.code == auth_error.passcodeNotSet) return (false, 'No hay un PIN configurado');
      if (e.code == auth_error.permanentlyLockedOut) {
        return (false, 'Se requiere desbloquear el dispositivo');
      }
      return (false, e.toString());
    }
  }
}
