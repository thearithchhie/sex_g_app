import 'package:sex_g_app/export.dart';

class AppListViewBuilder extends StatelessWidget {
  const AppListViewBuilder({
    super.key,
    this.controller,
    required this.children,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap,
    this.physics,
    this.padding,
  });

  final ScrollController? controller;
  final List<Widget> children;
  final Axis scrollDirection;
  final bool? shrinkWrap;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding ?? EdgeInsets.zero,
      cacheExtent: 100,
      physics: physics ?? app.scrollPhysics,
      itemCount: children.length,
      controller: controller,
      scrollDirection: scrollDirection,
      addAutomaticKeepAlives: false,
      shrinkWrap: shrinkWrap ?? false,
      itemBuilder: (BuildContext context, int index) {
        return children[index];
      },
    );
  }
}
