import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:micit/l10n/app_localizations.dart';

import '../../../features/login_feature/presentation/cubit/login_cubit.dart';
import '../../cubit/language_cubit.dart';
import '../../dependency_injection/configure_dependencies.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  MainAppBar({
    super.key,
    required this.title,
    required this.leading,
  });

  final LanguageCubit languageCubit = serviceLocator<LanguageCubit>();
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppBar(
      title: Text(title),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: leading,
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'darkMode':
                AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                break;
              case 'changeLanguage':
                final LanguageCubit languageCubit =
                    serviceLocator<LanguageCubit>();
                if (languageCubit.local == 'ar') {
                  languageCubit.changeLanguage('en');
                } else {
                  languageCubit.changeLanguage('ar');
                }
                break;
              case 'logout':
                serviceLocator<AuthCubit>().logout();
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: 'darkMode',
              child: Row(
                children: [
                  const Icon(Icons.dark_mode, color: Colors.black),
                  const SizedBox(width: 10),
                  Text(
                    AdaptiveTheme.of(context).isDefault
                        ? l10n.activateDarkMode
                        : l10n.activateLightMode,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'changeLanguage',
              child: Row(
                children: [
                  const Icon(Icons.language, color: Colors.black),
                  const SizedBox(width: 10),
                  Text(
                    l10n.changeLanguage,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  const Icon(Icons.logout, color: Colors.black),
                  const SizedBox(width: 10),
                  Text(l10n.logout),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
