import 'package:sex_g_app/export.dart';

class RadioField extends StatelessWidget {
  const RadioField(
      {super.key, this.isChecked = false, this.scale, this.onChanged});

  final bool isChecked;
  final double? scale;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppGestureDetector(
      onTap: onChanged == null ? null : () => onChanged?.call(!isChecked),
      child: Transform.scale(
        scale: scale ?? 1,
        child: isChecked
            ? Assets.icons.checked.image(scale: 4)
            : const Icon(Icons.radio_button_unchecked,
                size: 20, color: AppColor.pr500),
      ),
    );
  }
}
