import 'package:sex_g_app/export.dart';
import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static late BuildContext _context;

  static init(BuildContext context) {
    _context = context;
  }

  static Future<int> biometricAuthentication() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if (canAuthenticate) {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty) {
        if (availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.face)) {
          try {
            final bool didAuthenticate = await auth.authenticate(
              localizedReason:
                  'please_authenticate_to_show_account_balance'.localize(),
              options: const AuthenticationOptions(biometricOnly: true),
            );
            if (didAuthenticate) {
              int biometricType =
                  availableBiometrics.contains(BiometricType.face) == true
                      ? AuthVerifyType.faceId
                      : AuthVerifyType.fingerPrint;
              return biometricType;
            }
          } catch (e) {
            return AuthVerifyType.error;
          }
        }
      }
      return AuthVerifyType.error;
    } else {
      app.showError(_context, "your_device_not_supported_biometric".localize());
      return AuthVerifyType.error;
    }
  }
}
