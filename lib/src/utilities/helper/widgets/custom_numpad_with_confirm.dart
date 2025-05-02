import 'package:sex_g_app/export.dart';

class CustomNumpadWithConfirm extends StatefulWidget {
  const CustomNumpadWithConfirm(
      {super.key, this.onSuccess, this.onCancel, this.onSuccessBiometric});

  final Function(String)? onSuccess;
  final Function(int)? onSuccessBiometric;
  final GestureTapCallback? onCancel;

  @override
  State<CustomNumpadWithConfirm> createState() =>
      _CustomNumpadWithConfirmState();
}

class _CustomNumpadWithConfirmState extends State<CustomNumpadWithConfirm> {
  final TextEditingController controller = TextEditingController();
  late final AccountSafeCubit accountSafeCubit =
      context.read<AccountSafeCubit>();
  String? errorText;
  bool forceErrorState = false;

  @override
  void initState() {
    onAuthenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountSafeCubit, AccountSafeState>(
      listenWhen: (previous, current) =>
          current.stateStatus != previous.stateStatus,
      listener: _accountSafeListener,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: 10.px(y: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                25.widthBox,
                Expanded(
                  child: Text(
                    'verify_payment_password'.localize(),
                    style: context.typography.body16Sb,
                    textAlign: TextAlign.center,
                  ),
                ),
                AppGestureDetector(
                  onTap: () {
                    context.pop();
                    widget.onCancel?.call();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          CustomPinPut(
            controller: controller,
            showBgColor: true,
            hideKeyBoard: true,
            obscureText: true,
            customBgColor:
                app.isDark ? AppColor.black : AppColor.colorHex('D1D3D9'),
            onCompleted: (pi) {},
            forceErrorState: forceErrorState,
            errorText: errorText,
          ),
          20.heightBox,
          Container(
            padding: app.screenPaddingX,
            child: CustomSubmitButton(
                text: "confirm".localize(),
                onTap: () => verifiedPaymentPassword()),
          ),
          20.heightBox,
          Container(
            color: app.isDark
                ? const Color(0xff050532)
                : AppColor.colorHex('D1D3D9'),
            child: SafeArea(
              top: false,
              child: CustomNumpadSub(
                isRadius: false,
                onNumberTap: (number) {
                  // Handle number tap
                  if (controller.text.length >= 6) {
                    return;
                  }
                  controller.text = controller.text + number.toString();
                },
                onBackspace: () {
                  // Handle backspace
                  if (controller.text.isNotEmpty) {
                    controller.text = controller.text
                        .substring(0, controller.text.length - 1);
                  }
                },
                onAuthenticate: onAuthenticate,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onAuthenticate() async {
    if (app.getBiometricPay == null) return;
    int biometricType = await BiometricHelper.biometricAuthentication();
    if (biometricType == AuthVerifyType.error) return;
    widget.onSuccessBiometric?.call(biometricType);
    context.pop();
  }

  void verifiedPaymentPassword() {
    if (controller.text.length < 6) return;
    accountSafeCubit.verifiedPaymentPassword(
      req: {
        //
        "code": controller.text,
      },
    );
  }

  void _accountSafeListener(BuildContext context, AccountSafeState state) {
    if (state.stateStatus == AccountSafeStateStatus.verifiedPayPassword) {
      //
      widget.onSuccess
          ?.call(accountSafeCubit.verifyPaymentPasswordRes?.vkey ?? '');
      context.pop();
    } else if (state.stateStatus == AccountSafeStateStatus.failure) {
      setState(() {
        forceErrorState = true;
        errorText = state.errorMessage;
      });
    }
  }
}
