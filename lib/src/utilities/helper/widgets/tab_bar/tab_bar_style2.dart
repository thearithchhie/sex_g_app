import 'package:sex_g_app/export.dart';

class TabBarStyle2 extends StatefulWidget {
  const TabBarStyle2({
    super.key,
    this.onChanged,
    required this.data,
    this.controller,
  });

  final TabController? controller;
  final List<String> data;
  final ValueChanged<int>? onChanged;

  @override
  State<TabBarStyle2> createState() => _TabBarStyle2State();
}

class _TabBarStyle2State extends State<TabBarStyle2> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.controller,
      isScrollable: true,
      labelPadding: 4.px(),
      padding: app.screenPaddingX,
      onTap: (i) => widget.onChanged?.call(i),
      splashBorderRadius: 44.r(),
      indicatorColor: Colors.transparent,
      tabs: List.generate(
        widget.data.length,
        (i) => Container(
          padding: 10.px(y: 3),
          decoration: BoxDecoration(
            color: widget.controller?.index == i
                ? AppColor.primary
                : AppColor.neutral200,
            borderRadius: 44.r(),
          ),
          child: Text(
            widget.data[i],
            style: context.typography.body14R.copyWith(
              color: widget.controller?.index == i ? AppColor.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
