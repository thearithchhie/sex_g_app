import 'package:sex_g_app/export.dart';

class AppBottomWrapper extends StatelessWidget {
  final Widget child;
  final bool isBoxShadow;
  final bool isWithPadding;
  final double marginTop;

  const AppBottomWrapper({
    super.key,
    required this.child,
    this.isBoxShadow = false,
    this.isWithPadding = true,
    this.marginTop = 10,
  });

  @override
  Widget build(BuildContext context) {
    final double keyBordBottom = MediaQuery.of(context).viewInsets.bottom;
    final double padding = ContextHelper.bottom;
    final double bottom =
        (keyBordBottom > 0 ? keyBordBottom + 10 : padding + keyBordBottom);
    return SizedBox(
      width: context.mediaQuery.size.width,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 50),
        margin: EdgeInsets.only(
          top: marginTop,
          bottom: bottom < padding ? padding : bottom,
          left: isWithPadding ? 16 : 0,
          right: isWithPadding ? 16 : 0,
        ),
        child: child,
      ),
    );
  }
}
