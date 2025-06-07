import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class BiometricsScreen extends ConsumerWidget {
  const BiometricsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Biómetricos')),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FilledButton(
              onPressed: () {
                ref.read(localAuthNotifierProvider.notifier).authenticateUser(biometricOnly: true);
              },
              child: const Text('Autenticar')),
          canCheckBiometrics.when(
              data: (canCheckBiometrics) =>
                  Text('Puede verificar biometricos: $canCheckBiometrics'),
              error: (error, stackTrace) => const Text('Error'),
              loading: () => const CircularProgressIndicator()),
          const SizedBox(height: 20),
          const Text('Estado del biometrico', style: TextStyle(fontSize: 30)),
          Text('Estado: $localAuthState', style: const TextStyle(fontSize: 20)),
        ],
      )),
    );
  }
}
