import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final accelerometerGravity = ref.watch(accelerometerGravityProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Acelerometro'),
        ),
        body: Center(
          child: accelerometerGravity.when(data: (AccelerometerXYZ data) {
            return Text(data.toString(), style: TextStyle(fontSize: 20));
          }, error: (Object error, StackTrace stackTrace) {
            Text('Error: ${error.toString()}');
          }, loading: () {
            CircularProgressIndicator();
          }),
        ));
  }
}
