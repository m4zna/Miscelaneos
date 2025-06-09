import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class AdFullScreen extends ConsumerWidget {
  const AdFullScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final interstitialAd = ref.watch(adInterstitialProvider);
    ref.listen(adInterstitialProvider, (previous, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;
      next.value!.show();
    });

    if (interstitialAd.isLoading) {
      return const Scaffold(
          body: Center(
        child: Text('Cargando el anuncio'),
      ));
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad FullScreen'),
      ),
      body: const Center(
        child: Text('Ad FullScreen'),
      ),
    );
  }
}
