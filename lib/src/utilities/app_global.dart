import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:six_g_app/export.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path/path.dart' as p;
import 'package:six_g_app/src/utilities/app_env.dart';
import 'package:six_g_app/src/utilities/helper/form_validation_helper.dart';

class AppGlobal {
  static final AppGlobal _instance = AppGlobal._internal();

  factory AppGlobal() {
    return _instance;
  }

  AppGlobal._internal() {
    _env = _envs[_envEnum.name] ?? const AppEnv();
  }

  FormValidationHelper validation = FormValidationHelper();
  final screenX = 15;
  final screenPaddingX = const EdgeInsets.symmetric(horizontal: 15);
  final screenY = 20;
  final screenPaddingY = const EdgeInsets.symmetric(vertical: 20);
  final screenPadding =
      const EdgeInsets.symmetric(vertical: 20, horizontal: 15);

  DateTime now = DateTime.now();

  ThemeLight themeLight = ThemeLight();
  ThemeDark themeDark = ThemeDark();

  ScrollPhysics get scrollPhysics =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  void focusNew(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void showConfirmPinCode(
    BuildContext context, {
    GestureTapCallback? onCancel,
    Function(String)? onSuccess,
    Function(int)? onSuccessBiometric,
    Color? barrierColor,
  }) {
    showMaterialModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      barrierColor: barrierColor,
      backgroundColor:
          app.isDark ? AppColor.colorHex('#353979') : AppColor.white,
      builder: (BuildContext context) {
        return CustomNumpadWithConfirm(
          onCancel: onCancel,
          onSuccess: onSuccess,
          onSuccessBiometric: onSuccessBiometric,
        );
      },
    );
  }

  void showBankList(BuildContext context,
      {ValueChanged<dynamic>? onChanged, dynamic value}) {
    showMaterialModalBottomSheet<void>(
      context: context,
      backgroundColor: app.isDark ? AppColor.pr950 : AppColor.white,
      builder: (BuildContext context) {
        return BanksDialogWidget(onChanged: onChanged, value: value);
      },
    );
  }

  void showCurrency(BuildContext context,
      {ValueChanged<CurrencyType>? onChanged, CurrencyType? value}) {
    showMaterialModalBottomSheet<void>(
      context: context,
      backgroundColor: app.isDark ? AppColor.pr950 : AppColor.white,
      builder: (BuildContext context) {
        return CurrencyDialogWidget(onChanged: onChanged, value: value);
      },
    );
  }

  void showSelectAccount(BuildContext context,
      {ValueChanged<String>? onChanged, String? value}) {
    showMaterialModalBottomSheet<void>(
      context: context,
      backgroundColor: app.isDark ? AppColor.pr950 : AppColor.white,
      builder: (BuildContext context) {
        return SelectAccountDialogWidget(value: value, onChanged: onChanged);
      },
    );
  }

  void showTerm(BuildContext context) {
    showMaterialModalBottomSheet<void>(
      context: context,
      backgroundColor: app.isDark ? AppColor.pr950 : AppColor.white,
      builder: (BuildContext context) {
        return const TermDialogWidget();
      },
    );
  }

  void showDocumentType(BuildContext context,
      {ValueChanged<DocumentType>? onChanged, DocumentType? value}) {
    showMaterialModalBottomSheet<void>(
      context: context,
      backgroundColor: app.isDark ? AppColor.pr950 : AppColor.white,
      builder: (BuildContext context) {
        return DocumentTypeDialogWidget(value: value, onChanged: onChanged);
      },
    );
  }

  LoginRes? get data => UserStorage.getToken();

  /// Biometric login ==================
  CreateBiometricLoginRes? get getBiometricLogin =>
      UserStorage.getBiometricLogin();

  void saveBiometricLogin(CreateBiometricLoginRes biometricLogin) {
    UserStorage.saveBiometricLogin(biometricLogin);
  }

  void deleteBiometricLogin() {
    UserStorage.deleteBiometricLogin();
  }

  /// Biometric login ====================
  ///=====================================
  /// /// Biometric Pay ==================
  CreateBiometricPayRes? get getBiometricPay => UserStorage.getBiometricPay();

  void saveBiometricPay(CreateBiometricPayRes biometricPay) {
    UserStorage.saveBiometricPay(biometricPay);
  }

  void deleteBiometricPay() {
    UserStorage.deleteBiometricPay();
  }

  /// Biometric Pay ==================

  String get token => _token;
  String _token = '';

  String get sign => _sign;
  String _sign = '';

  void setSign(String sign) {
    _sign = sign;
  }

  void setToken(String token) {
    _token = token;
  }

  bool get authenticated => UserStorage.hasToken();

  bool get isHideMyAsset => _isHideMyAsset;
  bool _isHideMyAsset = false;

  void setHideMyAsset(bool value) {
    _isHideMyAsset = value;
  }

  AppEnvEnum get envEnum => _envEnum;
  AppEnvEnum _envEnum = AppEnvEnum.development;

  AppEnv get env => _env ?? const AppEnv();
  AppEnv? _env;

  void setEnv(AppEnvEnum envEnum) {
    _envEnum = envEnum;
    _env = _envs[envEnum.name];

    // Debug print to verify environment change
    debugPrint('Environment set to: ${envEnum.name}');
    debugPrint('Base URL: ${_env?.baseUrl}');
  }

  static const int limitSize = 10;

  bool get isDark => _isDark;
  bool _isDark = false;

  ThemeMode get themeMode => _themeMode;
  ThemeMode _themeMode = ThemeMode.system;

  void setTheme(BuildContext context, ThemeMode val) {
    if (val == ThemeMode.system) {
      _isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else if (val == ThemeMode.dark) {
      _isDark = true;
    } else {
      _isDark = false;
    }
    _themeMode = val;
  }

  final List<Locale> supportedLanguages = [
    const Locale('en', 'US'),
    const Locale('zh', 'CN'),
    const Locale('vi', 'VN'),
    const Locale('th', 'TH'),
    const Locale('km', 'KH'),
  ];
  final Map<String, dynamic> mapSupportLanguages = {
    'en': 'English',
    'zh': '中文',
    'vi': 'Tiếng Việt',
    'th': 'ภาษาไทย',
    'km': 'ភាសាខ្មែរ',
  };

  Locale get locale => _locale;
  Locale _locale = const Locale('en', 'US');

  void setLocale(Locale locale) {
    _locale = locale;
  }

  void openLoader(BuildContext context) {
    context.loaderOverlay.show();
  }

  void closeLoader(BuildContext context) {
    context.loaderOverlay.hide();
  }

  final List<ThemeMode> themeModesList = [
    ThemeMode.system,
    ThemeMode.dark,
    ThemeMode.light
  ];
  final Map<ThemeMode, dynamic> themeModeMap = {
    ThemeMode.system: 'system'.localize(),
    ThemeMode.dark: 'night'.localize(),
    ThemeMode.light: 'day'.localize(),
  };

  static final Map<String, AppEnv> _envs = {
    AppEnvEnum.local.name: const AppEnv(baseUrl: "http://192.168.10.140:8081"),
    AppEnvEnum.development.name:
        const AppEnv(baseUrl: "http://13.228.78.217:8081"),
    AppEnvEnum.production.name: const AppEnv(),
  };

  String extension(String value) {
    String extension = p.extension(value);
    return extension.replaceFirst('.', '');
  }

  Color iconColor(BuildContext context) {
    return Theme.of(context).appBarTheme.iconTheme!.color!;
  }

  Future<void> request<T>({
    required Future<BaseResponse<T>> Function() request,
    required void Function(BaseBlocState<T> value) response,
  }) async {
    response(BaseBlocState<T>(stateStatus: AppStateStatus.loading));
    try {
      final result = await request();
      if (result.success) {
        response(BaseBlocState<T>(
            stateStatus: AppStateStatus.success, data: result.result));
      } else {
        response(BaseBlocState<T>(
            stateStatus: AppStateStatus.failure, message: result.message));
      }
    } catch (e) {
      response(
        BaseBlocState<T>(
            stateStatus: AppStateStatus.failure,
            message: 'something_unexpected_went_wrong'.localize()),
      );
    }
  }

  void showSuccess(BuildContext context, String title,
      {Function()? onDismissed}) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      autoDismiss: true,
      autoHide: const Duration(seconds: 3),
      dialogBackgroundColor: app.isDark ? AppColor.pr900 : AppColor.white,
      dialogBorderRadius: BorderRadius.circular(16),
      width: 300,
      barrierColor: Colors.white54.withAlpha(20),
      desc: title,
      onDismissCallback: (_) {
        onDismissed?.call();
      },
    )..show();
  }

  void showError(BuildContext context, String title) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      autoDismiss: true,
      autoHide: const Duration(seconds: 3),
      dialogBackgroundColor: app.isDark ? AppColor.pr900 : AppColor.white,
      dialogBorderRadius: BorderRadius.circular(16),
      width: 300,
      barrierColor: Colors.white54.withAlpha(20),
      desc: title,
      isDense: true,
    )..show();
  }

  void showInfo(BuildContext context, String title) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      autoDismiss: true,
      autoHide: const Duration(seconds: 3),
      dialogBackgroundColor: app.isDark ? AppColor.pr900 : AppColor.white,
      dialogBorderRadius: BorderRadius.circular(16),
      width: 300,
      barrierColor: Colors.white54.withAlpha(20),
      desc: title,
    )..show();
  }

  void showWarning(BuildContext context, String title) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      autoDismiss: true,
      autoHide: const Duration(seconds: 3),
      dialogBackgroundColor: app.isDark ? AppColor.pr900 : AppColor.white,
      dialogBorderRadius: BorderRadius.circular(16),
      width: 300,
      barrierColor: Colors.white54.withAlpha(20),
      desc: title,
    )..show();
  }

  Map<String, dynamic> get deviceInfo => _devInfo;
  final Map<String, dynamic> _devInfo = {
    "product": "panther",
    "display": "BP1A.250305.019",
    "uuid": "DA5A2008-3DE5-4E4A-B140-D48BA7AFB405",
    "deviceId": "566b72e6b4f7c53e74d5eb6557527a72",
    "manufacturer": "Google",
    "serial": "unknown",
    "androidVersion": "15",
    "width": 1080,
    "fingerprint":
        "google/panther/panther:15/BP1A.250305.019/13003188:user/release-keys",
    "host": "r-456ae1c9fa6a8c5c-5gx4",
    "model": "Pixel 7",
    "id": "BP1A.250305.019",
    "sdk": 35,
    "brand": "google",
    "device": "panther",
    "user": "android-build",
    "androidId": "739727a85ec9100a",
    "board": "panther",
    "height": 2201,
    "hardware": "panther",
  };

  String get pusKey => "";
}
