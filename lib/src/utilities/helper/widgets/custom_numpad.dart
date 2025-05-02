import 'package:sex_g_app/export.dart';

class CustomNumPad extends StatelessWidget {
  final void Function(String) onNumberTap;
  final VoidCallback onBackspace;
  final Widget child;
  final Widget? customPadHead;

  const CustomNumPad({
    super.key,
    required this.onNumberTap,
    required this.onBackspace,
    required this.child,
    this.customPadHead,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                if (customPadHead != null) customPadHead!,
                CustomNumpadSub(
                    onBackspace: onBackspace, onNumberTap: onNumberTap),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
