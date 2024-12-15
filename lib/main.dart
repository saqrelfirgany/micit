import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'core/cubit/language_cubit.dart';
import 'core/dependency_injection/configure_dependencies.dart';
import 'core/router/router.dart';
import 'core/theme/adaptive_theme.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// flutter packages pub run build_runner build
// flutter packages pub run build_runner watch
Future<void> setupDependencies() async {
  await configureDependencies();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  // Initialize Firebase
  // project-695200015194
  await Firebase.initializeApp(
    name: 'micit-b0a5e',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.savedThemeMode,
  });

  final AdaptiveThemeMode? savedThemeMode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: serviceLocator<LanguageCubit>()..getSavedLanguage(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, ChangeLocaleState>(
        builder: (context, state) {
          return AdaptiveTheme(
            light: AppThemes.lightTheme,
            dark: AppThemes.darkTheme,
            initial: savedThemeMode ?? AdaptiveThemeMode.light,
            builder: (theme, darkTheme) => MaterialApp.router(
              title: 'MICIT',
              debugShowCheckedModeBanner: false,
              theme: theme,
              darkTheme: darkTheme,
              supportedLocales: L10n.all,
              locale: state.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              builder: FlutterSmartDialog.init(),
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
            ),
          );
        },
      ),
    );
  }
}
