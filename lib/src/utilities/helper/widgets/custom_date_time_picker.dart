import 'package:sex_g_app/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomDateTimePicker extends StatefulWidget {
  final String hintText;
  final String? label;
  final bool isOutLineBorder;
  final TextEditingController controller;
  final DatePickerType datePickType;

  const CustomDateTimePicker({
    super.key,
    this.hintText = "select_a_date",
    this.isOutLineBorder = false,
    required this.controller,
    this.datePickType = DatePickerType.date,
    this.label,
  });

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
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
              child: Text(widget.label!,
                  style: context.typography.body14B
                      .copyWith(color: app.isDark ? AppColor.primary : null))),
        TextField(
          controller: widget.controller,
          textAlign: TextAlign.start,
          readOnly: true,
          onTap: _onSelectPicker,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: widget.hintText.localize(),
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
              color: app.isDark || !widget.isOutLineBorder
                  ? AppColor.primary
                  : const Color(0xffA4A4A4),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: app.isDark || !widget.isOutLineBorder
                  ? AppColor.primary
                  : const Color(0xffA4A4A4),
            ),
            filled: !widget.isOutLineBorder,
            fillColor: app.isDark || !widget.isOutLineBorder
                ? const Color(0xff353979)
                : const Color(0xffA4A4A4),
            errorBorder: bordered,
            focusedBorder: bordered,
            focusedErrorBorder: bordered,
            disabledBorder: bordered,
            enabledBorder: bordered,
            border: bordered,
          ),
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  DateTime date = DateTime.now();
  DateTime time = DateTime.now();
  DateTime dateTime = DateTime.now();

  void _onSelectPicker() {
    if (widget.datePickType == DatePickerType.date) {
      _showDialog(
        CupertinoDatePicker(
          initialDateTime: date,
          mode: CupertinoDatePickerMode.date,
          use24hFormat: true,
          onDateTimeChanged: (DateTime newDate) {
            widget.controller.text =
                '${newDate.month}-${newDate.day}-${newDate.year}';
            setState(() => date = newDate);
          },
        ),
      );
    } else if (widget.datePickType == DatePickerType.time) {
      _showDialog(
        CupertinoDatePicker(
          initialDateTime: time,
          mode: CupertinoDatePickerMode.time,
          use24hFormat: true,
          onDateTimeChanged: (DateTime newTime) {
            widget.controller.text = '${newTime.hour}:${newTime.minute}';
            setState(() => time = newTime);
          },
        ),
      );
    } else if (widget.datePickType == DatePickerType.dataTime) {
      _showDialog(
        CupertinoDatePicker(
          initialDateTime: dateTime,
          use24hFormat: true,
          onDateTimeChanged: (DateTime newDateTime) {
            widget.controller.text =
                '${newDateTime.month}-${newDateTime.day}-${newDateTime.year} ${newDateTime.hour}:${newDateTime.minute}';
            setState(() => dateTime = newDateTime);
          },
        ),
      );
    }
  }

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  void _showDialog(Widget child) {
    showMaterialModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text('cancel'.localize(), style: labelStyle),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text('filter_time'.localize(), style: labelStyle),
                TextButton(
                    child: Text('confirm'.localize(), style: confirmLabelStyle),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
            Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SafeArea(top: false, child: child),
            ),
          ],
        );
      },
    );
  }

  final labelStyle = TextStyle(
      color: app.isDark ? Colors.white : Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 14);
  final confirmLabelStyle = const TextStyle(
      color: AppColor.primary, fontWeight: FontWeight.w700, fontSize: 14);
}
