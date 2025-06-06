import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final magnetometer = ref.watch(magnetometerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Magnetometro'),
        ),
        body: Center(
          child: magnetometer.when(data: (MagnetometerXYZ data) {
            return Text(data.toString(), style: TextStyle(fontSize: 20));
          }, error: (Object error, StackTrace stackTrace) {
            Text('Error: ${error.toString()}');
          }, loading: () {
            CircularProgressIndicator();
          }),
        ));
  }
}

