import 'package:quick_actions/quick_actions.dart';

import '../config.dart';

class QuickActionsPlugin {
  static registerActions() {
    const quickActions = QuickActions();
    quickActions.initialize((shortcutType) {
      switch (shortcutType) {
        case 'biometric':
          router.push('/biometrics');
          break;
        case 'compass':
          router.push('/compass');
          break;
        case 'pokemons':
          router.push('/pokemons');
          break;
        case 'charmander':
          router.push('/pokemons/4');
          break;
        default:
          break;
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'biometric', localizedTitle: 'Biometrics', icon: 'finger'),
      const ShortcutItem(type: 'compass', localizedTitle: 'Compass', icon: 'compass'),
      const ShortcutItem(type: 'pokemons', localizedTitle: 'Pokemons', icon: 'pokemons'),
      const ShortcutItem(type: 'charmander', localizedTitle: 'Charmander', icon: 'charmander'),
    ]);
  }
}
