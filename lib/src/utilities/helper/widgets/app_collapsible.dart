import 'package:collapsible/collapsible.dart';
import 'package:sex_g_app/export.dart';

class AppCollapsible extends StatefulWidget {
  final Widget child;
  final bool isCollapse;
  final CollapsibleAxis axis;

  const AppCollapsible({
    Key? key,
    required this.child,
    this.isCollapse = false,
    this.axis = CollapsibleAxis.vertical,
  }) : super(key: key);

  @override
  State<AppCollapsible> createState() => _AppCollapsibleState();
}

class _AppCollapsibleState extends State<AppCollapsible> {
  final int duration = 150;

  @override
  Widget build(BuildContext context) {
    return Collapsible(
      collapsed: widget.isCollapse,
      axis: widget.axis,
      duration: Duration(milliseconds: duration),
      maintainAnimation: true,
      curve: Curves.easeIn,
      fade: true,
      child: widget.child,
    );
  }
}
