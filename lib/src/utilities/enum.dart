import 'package:six_g_app/gen/assets.gen.dart';

enum AppStateStatus {
  none,
  initial,
  loading,
  failure,
  empty,
  success,
  noInternet,
  created,
  updated
}

enum AuthStateStatus {
  none,
  initial,
  loading,
  failure,
  empty,
  noInternet,
  phoneNumberVerified,
  otpSent,
  otpReSent,
  otpVerified,
  registered,
  loggedIn,
  changedPassword,
  changedLoginPassword,
  loggedOut,
}

enum AccountSafeStateStatus {
  none,
  initial,
  loading,
  failure,
  empty,
  noInternet,
  checkPayPassword,
  closeBiometricLogin,
  closeBiometricPay,
  createBiometricLogin,
  createBiometricPay,
  getInfo,
  setPayPassword,
  verifiedPayPassword,
}

enum AuthTypeId { login, register, verify, change_mobile, add_bank }

enum OtpVerificationType { sent1, sent2 }

enum AppEnvEnum { production, development, local }

enum DatePickerType { date, time, dataTime }

enum FormStyle { style1, style2, style3 }

enum DocumentType {
  idCard(id: 1, title: 'id_card'),
  passport(id: 2, title: 'passport'),
  driverLicense(id: 3, title: 'driver_license');

  const DocumentType({required this.id, required this.title});

  final int id;
  final String title;
}

enum CurrencyType {
  USD(title: 'US Dollar', path: 'assets/svgs/transfer/dollar_symbol.svg'),
  KHR(title: 'Khmer Riel', path: 'assets/svgs/transfer/riel_symbol.svg');
  // USTD(title: 'USDT', path: 'assets/svgs/usdt_icon.svg');

  const CurrencyType({required this.title, required this.path});

  final String title;
  final String path;
}
