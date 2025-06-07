import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userLocation = ref.watch(userLocationProvider);
    final watchUserLocation = ref.watch(watchLocationProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Ubicación')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ubicación actual'),
            userLocation.when(
                data: (data) => Text(data.toString()),
                error: (error, stackTrace) => Text('Error: $error'),
                loading: () => const CircularProgressIndicator()),
            const SizedBox(height: 20),
            const Text('Seguimiento de ubicación'),
            watchUserLocation.when(
                data: (data) => Text(data.toString()),
                error: (error, stackTrace) => Text('Error: $error'),
                loading: () => const CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
