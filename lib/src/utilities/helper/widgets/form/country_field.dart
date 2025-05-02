import 'package:sex_g_app/export.dart';
import 'package:sex_g_app/src/utilities/extensions/string_extension.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CountryField extends StatefulWidget {
  final String hintText;
  final bool isOutLineBorder;
  final String? label;
  final CountryCodeRes? value;
  final ValueChanged<CountryCodeRes>? onChanged;
  final FormFieldValidator<String>? validator;

  const CountryField({
    super.key,
    this.hintText = "choose_a_country",
    this.isOutLineBorder = false,
    this.label,
    this.value,
    this.onChanged,
    this.validator,
  });

  static const String route = "/CountryField";

  @override
  State<CountryField> createState() => _CountryFieldState();
}

class _CountryFieldState extends State<CountryField> {
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
          controller: TextEditingController(
              text:
                  widget.value?.countryName?.toCountryName(widget.value?.cid)),
          style: context.typography.body12R,
          readOnly: true,
          onTap: () {
            showCountryPicker(context,
                onChanged: widget.onChanged, value: widget.value);
          },
          validator: widget.validator,
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

  void showCountryPicker(
    BuildContext context, {
    ValueChanged<CountryCodeRes>? onChanged,
    CountryCodeRes? value,
    GetCountryCubit? getCountryCubit,
  }) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (_) {
        return _CountrySelection(
          getCountryCubit: getCountryCubit ?? context.read<GetCountryCubit>(),
          onChanged: onChanged,
          value: value,
        );
      },
    );
  }
}

class _CountrySelection extends StatefulWidget {
  final GetCountryCubit getCountryCubit;
  final ValueChanged<CountryCodeRes>? onChanged;
  final CountryCodeRes? value;

  const _CountrySelection(
      {super.key, required this.getCountryCubit, this.onChanged, this.value});

  @override
  State<_CountrySelection> createState() => _CountrySelectionState();
}

class _CountrySelectionState extends State<_CountrySelection> {
  @override
  void initState() {
    widget.getCountryCubit.onClearSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * .5,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            16.heightBox,
            Text("select_your_country".localize(),
                style: context.typography.body16B),
            12.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                hintText: "search_country_code".localize(),
                isOutLineBorder: true,
                prefixIcon: const Icon(Icons.search, size: 20),
                onChanged: (searchText) {
                  EasyDebounce.debounce(
                      'searchCountryCode', const Duration(milliseconds: 500),
                      () {
                    widget.getCountryCubit.onSearchCountryCode(searchText);
                  });
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<GetCountryCubit, GetCountryState>(
                builder: (context, state) {
                  if (state.stateStatus == AppStateStatus.loading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  if (state.stateStatus == AppStateStatus.success) {
                    List<CountryCodeRes> countries =
                        state.response.result as List<CountryCodeRes>;
                    CountryCodeRes? selected = widget.value;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: countries.length,
                      itemBuilder: (context, ind) {
                        final country = countries[ind];
                        return InkWell(
                          onTap: () =>
                              {widget.onChanged?.call(country), context.pop()},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //
                                12.heightBox,
                                Container(
                                    color: AppColor.grey.withAlpha(30),
                                    height: 1),
                                12.heightBox,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${country.countryName?.toCountryName(country.cid) ?? ''}",
                                        style: context.typography.body12R,
                                      ),
                                    ),
                                    if (selected?.cid == country.cid)
                                      Image.asset(Assets.icons.checked.path,
                                          scale: 4),
                                    16.widthBox,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const EmptyWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
