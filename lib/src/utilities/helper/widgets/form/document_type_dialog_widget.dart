import 'package:sex_g_app/export.dart';

class DocumentTypeDialogWidget extends StatelessWidget {
  const DocumentTypeDialogWidget({super.key, this.onChanged, this.value});

  final ValueChanged<DocumentType>? onChanged;
  final DocumentType? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: app.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('select_document_type'.localize(),
              style: context.typography.body14Sb),
          30.heightBox,
          ...List.from(
            DocumentType.values.map(
              (e) => AppGestureDetector(
                onTap: () {
                  context.pop();
                  onChanged?.call(e);
                },
                child: Container(
                  padding: 15.p(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          e.title.localize(),
                          style: context.typography.body16R,
                        ),
                      ),
                      if (value == e)
                        AppSvg(Assets.icons.checked.path, width: 20)
                    ],
                  ),
                ),
              ),
            ),
          ).separator((i) =>
              Divider(color: AppColor.neutral800, height: 1, thickness: 0.8)),
          ContextHelper.padding.bottom.heightBox,
        ],
      ),
    );
  }
}
