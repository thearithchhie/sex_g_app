import 'package:sex_g_app/export.dart';

class TermDialogWidget extends StatefulWidget {
  const TermDialogWidget({super.key});

  @override
  State<TermDialogWidget> createState() => _TermDialogWidgetState();
}

class _TermDialogWidgetState extends State<TermDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ContextHelper.size.height * 0.7,
      child: AppListViewBuilder(
        padding: app.screenPadding,
        children: [
          Text('terms_&_conditions'.localize(),
              style: context.typography.body14Sb),
          Text('Effective Date: April 18, 2025',
              style: context.typography.body14R),
          Text(
            'Welcome to DV-Pay (“we”, “us”, “our”). These Terms of Service (“Terms”) govern your access to and use of our banking services, products, website, and mobile application (collectively, the “Services”).By accessing or using our Services, you agree to be bound by these Terms. If you do not agree, please do not use our Services.1. EligibilityYou must be at least 18 years old and legally capable of entering into binding contracts to use our Services. By using the Services, you represent and warrant that you meet these requirements.2. Account RegistrationTo use certain Services, you may need to create an account. You agree to:Provide accurate and complete information.Keep your login credentials secure.Notify us immediately of any unauthorized use of your account.We are not liable for any loss or damage resulting from your failure to protect your account. 3. Acceptable Use',
            style: context.typography.body14R,
          ),
          Text(
            'Welcome to DV-Pay (“we”, “us”, “our”). These Terms of Service (“Terms”) govern your access to and use of our banking services, products, website, and mobile application (collectively, the “Services”).By accessing or using our Services, you agree to be bound by these Terms. If you do not agree, please do not use our Services.1. EligibilityYou must be at least 18 years old and legally capable of entering into binding contracts to use our Services. By using the Services, you represent and warrant that you meet these requirements.2. Account RegistrationTo use certain Services, you may need to create an account. You agree to:Provide accurate and complete information.Keep your login credentials secure.Notify us immediately of any unauthorized use of your account.We are not liable for any loss or damage resulting from your failure to protect your account. 3. Acceptable Use',
            style: context.typography.body14R,
          ),
        ].separator((i) => 10.heightBox),
      ),
    );
  }
}
