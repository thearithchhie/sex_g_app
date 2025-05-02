import 'package:sex_g_app/export.dart';

class AppWrapAutoHeight extends StatelessWidget {
  final EdgeInsets? padding;
  final int crossAxisCount;
  final double spacing;
  final double runSpacing;
  final List<Widget> children;

  const AppWrapAutoHeight({
    super.key,
    this.spacing = 0,
    this.runSpacing = 0,
    required this.crossAxisCount,
    this.padding,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double maxWidth = constraints.maxWidth;
      return Container(
        padding: padding,
        child: Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: List.generate(
            children.length,
            (index) => SizedBox(
              width:
                  (maxWidth - (crossAxisCount - 1) * spacing) / crossAxisCount,
              child: children[index],
            ),
          ),
        ),
      );
    });
  }
}
