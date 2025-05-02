import 'package:sex_g_app/export.dart';

class TransactionListWidget extends StatefulWidget {
  const TransactionListWidget({super.key, this.isGroup = false});

  final bool isGroup;

  @override
  State<TransactionListWidget> createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends State<TransactionListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        if (widget.isGroup) date('today'.localize()),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(
            title: 'Earning',
            date: '04-18-2025 11:16',
            amount: 0.99,
            isSuccess: false),
        item(
            title: 'Earning',
            date: '04-18-2025 11:16',
            amount: 0.99,
            isSuccess: false),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        if (widget.isGroup) date('yesterday'.localize()),
        item(
            title: 'Earning',
            date: '04-18-2025 11:16',
            amount: 0.99,
            isSuccess: false),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        if (widget.isGroup) date('02/04/2025'.localize()),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
        item(title: 'Earning', date: '04-18-2025 11:16', amount: 0.99),
      ],
    );
  }

  Widget item(
      {required String title,
      required String date,
      required double amount,
      bool isSuccess = true}) {
    return Container(
      padding: 10.pb(),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: app.isDark
                ? AppColor.colorHex('#F8F9FE').withValues(alpha: 0.2)
                : AppColor.neutral200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        spacing: 10,
        children: [
          SizedBox(
            width: 42,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.colorHex('#253783'))),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(title, style: context.typography.body14Sb),
                Text(date,
                    style: context.typography.body12M
                        .copyWith(color: AppColor.neutral300)),
              ],
            ),
          ),
          Text(
            (isSuccess ? '+' : '-') + " \$ " + amount.toString(),
            style: context.typography.body14Sb
                .copyWith(color: isSuccess ? AppColor.green : AppColor.danger),
          ),
        ],
      ),
    );
  }

  Widget date(String value) {
    return Text(value,
        style: context.typography.body12R.copyWith(
            color: app.isDark ? AppColor.pr300 : AppColor.neutral500));
  }
}
