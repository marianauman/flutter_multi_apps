import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/features/book_tracker/settings_tab/provider/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/hive_constants.dart';
import '../../../../core/shared_instances.dart/hive_box_shared_instance.dart';

final clearDatabaseProvider = StateNotifierProvider<ClearDatabaseNotifier, bool>((
  ref,
) {
  return ClearDatabaseNotifier();
});

class ClearDatabaseNotifier extends StateNotifier<bool> {
  ClearDatabaseNotifier() : super(false);

  final HiveBoxSharedInstance _hiveManager = HiveBoxSharedInstance();

  Future<void> clearDatabase(WidgetRef ref) async {
    await _hiveManager.clearBox(boxName: HiveConstants.themeBox);
    await _hiveManager.clearBox(boxName: HiveConstants.myBooksBox);
    ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.system);
    state = true;
  }
}
