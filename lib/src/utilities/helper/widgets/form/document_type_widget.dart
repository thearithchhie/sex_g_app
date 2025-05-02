import 'package:sex_g_app/export.dart';

class DocumentTypeWidget extends StatelessWidget {
  const DocumentTypeWidget(
      {super.key, this.value = DocumentType.idCard, this.onChanged});

  final DocumentType value;
  final ValueChanged<DocumentType>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("document_type".localize(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ...DocumentType.values.map(
          (e) => AppGestureDetector(
            onTap: () => onChanged?.call(e),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioField(isChecked: value == e),
                6.widthBox,
                Text(e.title.localize(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
