import 'package:sex_g_app/export.dart';
import 'package:dv_pay_mobile/src/utilities/extensions/string_extension.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DocumentTypeField extends StatefulWidget {
  final String hintText;
  final bool isOutLineBorder;
  final String? label;
  final DocumentType? value;
  final ValueChanged<DocumentType>? onChanged;

  const DocumentTypeField({
    super.key,
    this.hintText = "choose_document",
    this.isOutLineBorder = false,
    this.label,
    this.value,
    this.onChanged,
  });

  @override
  State<DocumentTypeField> createState() => _DocumentTypeFieldState();
}

class _DocumentTypeFieldState extends State<DocumentTypeField> {
  @override
  void initState() {
    final GetCountryCubit _getCountryCubit = context.read<GetCountryCubit>();
    if (_getCountryCubit.state.response.result == null) {
      _getCountryCubit.getCountry();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final InputBorder bordered = OutlineInputBorder(
      borderSide: widget.isOutLineBorder
          ? BorderSide(
              color: app.isDark ? AppColor.pr900 : const Color(0xffA4A4A4),
              width: 1)
          : BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Container(
            margin: 5.pb(),
            child: Text(
              widget.label!,
              style: context.typography.body14B
                  .copyWith(color: app.isDark ? AppColor.primary : null),
            ),
          ),
        TextFormField(
          controller:
              TextEditingController(text: widget.value?.title.localize()),
          style: context.typography.body12R,
          readOnly: true,
          onTap: () {
            app.showDocumentType(context,
                onChanged: widget.onChanged, value: widget.value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.hintText.localize();
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: widget.hintText.tr(),
            errorStyle:
                context.typography.body12R.copyWith(color: AppColor.danger),
            contentPadding: const EdgeInsets.all(15),
            hintStyle: context.typography.body12R.copyWith(
                color: app.isDark ? AppColor.pr400 : AppColor.neutral300),
            filled: !widget.isOutLineBorder,
            fillColor: const Color(0xff353979),
            errorBorder: bordered,
            focusedBorder: bordered,
            focusedErrorBorder: bordered,
            disabledBorder: bordered,
            enabledBorder: bordered,
            border: bordered,
            suffixIcon: const Icon(Icons.arrow_forward_ios_outlined,
                size: 12, color: AppColor.pr300),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
