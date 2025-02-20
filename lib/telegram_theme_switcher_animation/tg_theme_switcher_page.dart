import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'theme_switcher_scaffold.dart';

class TelegramThemeSwitcherPage extends StatelessWidget {
  static const routeName = '/telegram-theme-switcher';
  const TelegramThemeSwitcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        // Create local theme data
        final isDarkTheme = themeMode == ThemeMode.dark;
        final theme = FlexThemeData.light(scheme: FlexScheme.mallardGreen);
        final darkTheme = FlexThemeData.dark(scheme: FlexScheme.mallardGreen);
        
        // Use Theme widget to override the theme locally
        return Theme(
          data: isDarkTheme ? darkTheme : theme,
          child: Builder(
            builder: (context) {
              final colorScheme = Theme.of(context).colorScheme;
              final textTheme = Theme.of(context).textTheme;
              return ThemeSwitcherScaffold(
                title: const Text('Telegram Theme Animation'),
                body: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          margin: EdgeInsets.zero,
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: colorScheme.primaryContainer,
                                  child: Icon(
                                    isDarkTheme
                                        ? Icons.light_mode
                                        : Icons.dark_mode,
                                    color: colorScheme.onPrimaryContainer,
                                  ),
                                ),
                                title: Text(
                                  isDarkTheme ? 'Dark Mode' : 'Light Mode',
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  'Toggle app theme',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      colorScheme.secondaryContainer,
                                  child: Icon(
                                    Icons.palette_outlined,
                                    color: colorScheme.onSecondaryContainer,
                                  ),
                                ),
                                title: Text(
                                  'Color Scheme',
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  'Mallard Green',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Preview',
                          style: textTheme.titleSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Card(
                          margin: EdgeInsets.zero,
                          child: Column(
                            children: [
                              for (var i = 0; i < 3; i++) ...[
                                if (i > 0) const Divider(height: 1),
                                ListTile(
                                  title: Text(
                                    'List Item ${i + 1}',
                                    style: textTheme.titleMedium,
                                  ),
                                  subtitle: Text(
                                    'Supporting text',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }
}
