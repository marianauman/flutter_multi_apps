import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/text_constants.dart';
import '../../../../../shared/widgets/custom_expansion_tile.dart';
import '../../../../../shared/widgets/custom_radio_list_tile.dart';
import '../../provider/theme_provider.dart';

class SetThemeView extends ConsumerWidget {
  const SetThemeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final mode = ref.watch(themeModeProvider);

    return CustomExpansionTile(
      title: TextConstants.theme,
      subtitle: _getThemeModeText(mode),
      leading: Icon(
        Icons.palette,
        color: Theme.of(context).colorScheme.primary,
      ),
      children: [
        CustomRadioListTile<ThemeMode>(
          title: TextConstants.system,
          subtitle: TextConstants.followSystemThemeSettings,
          value: ThemeMode.system,
          groupValue: mode,
          onChanged: (value) {
            if (value != null) {
              ref.read(themeModeProvider.notifier).setThemeMode(value);
            }
          },
          leading: Icon(
            Icons.brightness_auto,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        CustomRadioListTile<ThemeMode>(
          title: TextConstants.light,
          subtitle: TextConstants.alwaysUseLightTheme,
          value: ThemeMode.light,
          groupValue: mode,
          onChanged: (value) {
            if (value != null) {
              ref.read(themeModeProvider.notifier).setThemeMode(value);
            }
          },
          leading: Icon(
            Icons.light_mode,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        CustomRadioListTile<ThemeMode>(
          title: TextConstants.dark,
          subtitle: TextConstants.alwaysUseDarkTheme,
          value: ThemeMode.dark,
          groupValue: mode,
          onChanged: (value) {
            if (value != null) {
              ref.read(themeModeProvider.notifier).setThemeMode(value);
            }
          },
          leading: Icon(
            Icons.dark_mode,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
      ],
    );
  }
}

String _getThemeModeText(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.system:
      return TextConstants.system;
    case ThemeMode.light:
      return TextConstants.light;
    case ThemeMode.dark:
      return TextConstants.dark;
  }
}
