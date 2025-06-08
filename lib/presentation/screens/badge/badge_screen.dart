import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../providers/providers.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final badgeCounter = ref.watch(badgeCounterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Badge Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
                label: Text(badgeCounter.toString()),
                alignment: Alignment.lerp(Alignment.topRight, Alignment.bottomRight, 0.2),
                child:
                    Text(badgeCounter.toString(), style: Theme.of(context).textTheme.displayLarge)),
            FilledButton(
                onPressed: () {
                  ref.invalidate(badgeCounterProvider);
                  AppBadgePlugin.removeBadge();
                },
                child: const Text('Borrar Badge')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(badgeCounterProvider.notifier).state++;
          AppBadgePlugin.updateBadgeCount(ref.read(badgeCounterProvider));
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
