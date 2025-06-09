import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import '../../../config/config.dart';

class BackgroundFetchNotifier extends StateNotifier<bool> {
  final String processKeyName;

  BackgroundFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  checkCurrentStatus() async {
    state = await SharePreferencesPlugin.getBool(processKeyName) ?? false;
  }

  toggleProcess() async {
    if (state) {
      await deactivateProcess();
    } else {
      await activateProcess();
    }
  }

  activateProcess() async {
    await Workmanager().registerPeriodicTask(processKeyName, processKeyName,
        frequency: const Duration(seconds: 10),
        constraints: Constraints(networkType: NetworkType.connected),
        tag: processKeyName);
    state = true;
    await SharePreferencesPlugin.setBool(processKeyName, true);
  }

  deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    state = false;
    await SharePreferencesPlugin.setBool(processKeyName, false);
  }

}

final backgroundPokemonFetchProvider = StateNotifierProvider<BackgroundFetchNotifier, bool?>((ref) {
  return BackgroundFetchNotifier(processKeyName: fetchPeriodicBackgroundTaskKey );
});
