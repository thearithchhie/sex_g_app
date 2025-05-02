import 'package:sex_g_app/export.dart';

class CustomNumpadSub extends StatelessWidget {
  CustomNumpadSub({
    super.key,
    required this.onNumberTap,
    required this.onBackspace,
    this.isRadius = true,
    this.onAuthenticate,
  });

  final void Function(String) onNumberTap;
  final VoidCallback onBackspace;
  final VoidCallback? onAuthenticate;
  final bool isRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: app.isDark ? const Color(0xff050532) : const Color(0xffD1D3D9),
        // color: const Color(0xff050532),
        borderRadius: isRadius
            ? const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))
            : null,
      ),
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 20),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 12,
        physics: const NeverScrollableScrollPhysics(),
        padding: 0.p(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 2.7,
        ),
        itemBuilder: (_, index) {
          if (index < 9) {
            String number = (index + 1).toString();
            return buildButton(number, onTap: () => onNumberTap(number));
          } else if (index == 9) {
            if (app.getBiometricPay == null) return const Offstage();
            return InkWell(
              onTap: onAuthenticate,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                decoration: buttonStyle.copyWith(color: Colors.transparent),
                alignment: Alignment.center,
                child: Assets.icons.faceId.image(width: 30),
              ),
            );
          } else if (index == 10) {
            return buildButton('0', onTap: () => onNumberTap('0'));
          } else {
            return InkWell(
              onTap: onBackspace,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                decoration: buttonStyle.copyWith(color: Colors.transparent),
                alignment: Alignment.center,
                child: const Icon(Icons.backspace_outlined),
              ),
            );
          }
        },
      ),
    );
  }

  final BoxDecoration buttonStyle = BoxDecoration(
    color: app.isDark ? const Color(0xff353979) : Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(6)),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withAlpha(20),
          offset: const Offset(0, 2),
          blurRadius: 1,
          spreadRadius: 0),
    ],
  );

  Widget buildButton(String text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.white.withAlpha(30),
      highlightColor: Colors.white.withAlpha(10),
      child: Container(
        decoration: buttonStyle,
        alignment: Alignment.center,
        child: Text(text,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w400)),
      ),
    );
  }
}
