import 'package:sex_g_app/export.dart';

Future customAlertDialog(
  BuildContext bContext, {
  String title = "提示",
  String message = "是否断开当前连麦",
  Widget? content,
  required Function() tapConfirm,
  String cancel = "取消",
  String okText = "确认",
}) async {
  return showDialog(
    context: bContext,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => context.pop(),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 46),
                // padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: 24.p(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(title,
                              style: context.typography.body14Sb
                                  .copyWith(color: AppColor.black)),
                          12.heightBox,
                          content ??
                              Text(message,
                                  style: context.typography.body14Sb
                                      .copyWith(color: AppColor.black)),
                        ],
                      ),
                    ),
                    Container(height: 1, color: AppColor.grey),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => context.pop(),
                              child: Center(
                                child: Text(cancel,
                                    style: context.typography.body14M
                                        .copyWith(color: AppColor.black)),
                              ),
                            ),
                          ),
                          Container(width: 1, height: 50, color: AppColor.grey),
                          Expanded(
                            child: GestureDetector(
                              onTap: tapConfirm,
                              child: Center(
                                child: Text(
                                  okText,
                                  style: context.typography.body14M
                                      .copyWith(color: const Color(0xff325DDE)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
