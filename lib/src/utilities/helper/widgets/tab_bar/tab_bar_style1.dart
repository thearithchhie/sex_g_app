import 'package:sex_g_app/export.dart';
import 'package:flutter/gestures.dart';

class TabBarStyle1 extends StatefulWidget {
  const TabBarStyle1({
    super.key,
    this.onChanged,
    required this.data,
    this.controller,
  });
  final TabController? controller;
  final List<String> data;
  final ValueChanged<int>? onChanged;

  @override
  State<TabBarStyle1> createState() => _TabBarStyle1State();
}

class _TabBarStyle1State extends State<TabBarStyle1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 15.p(b: 0, l: 0),
      decoration: BoxDecoration(
        color: AppColor.colorHex('#29377E'),
        borderRadius: 0.r(tr: 20, br: 20),
      ),
      child: TabBar(
        controller: widget.controller,
        isScrollable: true,
        padding: 0.p(),
        onTap: (i) => widget.onChanged?.call(i),
        tabs: List.from(widget.data.map((e) => Text(e))),
      ),
    );
  }
}
