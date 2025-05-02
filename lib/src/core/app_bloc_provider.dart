// import "package:sex_g_app/export.dart";

// class AppBlocsProvider extends StatelessWidget {
//   final Widget child;

//   const AppBlocsProvider({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<AuthCubit>(create: (context) => AuthCubit(DependencyHelper.dependency)),
//         BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
//         BlocProvider<GetCountryCubit>(create: (context) => GetCountryCubit(DependencyHelper.dependency)),
//         BlocProvider<AccountSafeCubit>(create: (context) => AccountSafeCubit(DependencyHelper.dependency)),
//         BlocProvider<LogCubit>(create: (context) => LogCubit(DependencyHelper.dependency)),
//         BlocProvider<UserAccountCubit>(create: (context) => UserAccountCubit(DependencyHelper.dependency)),
//       ],
//       child: child,
//     );
//   }
// }
