import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class AdRewardedScreen extends ConsumerWidget {
  const AdRewardedScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adRewarded = ref.watch(adRewardedProvider);
    final adPoints = ref.watch(adPointsProvider);

    ref.listen(adRewardedProvider, (previous, next) {
      print('previous: $previous');
      if (!next.hasValue) return;
      if (next.value == null) return;
      next.value!.show(onUserEarnedReward: (ad, reward) {
        print('Puntos ganados: ${reward.amount}');
        ref.read(adPointsProvider.notifier).update((state) => state + 10);
      });
    });

    if (adRewarded.isLoading) {
      return const Scaffold(
          body: Center(
        child: Text('Cargando el anuncio'),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Rewarded'),
      ),
      body: Center(
        child: Text('Puntos actuales:$adPoints'),
      ),
    );
  }
}
