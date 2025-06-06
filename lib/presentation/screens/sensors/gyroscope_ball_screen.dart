import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope = ref.watch(gyroscopeProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('GyroscopeBall'),
        ),
        body: SizedBox.expand(
            child: gyroscope.when(data: (GyroscopeXYZ data) {
          return MovingBall(x: data.x, y: data.y);
        }, error: (Object error, StackTrace stackTrace) {
          Text('Error: ${error.toString()}');
          return null;
        }, loading: () {
          const CircularProgressIndicator();
          return null;
        })));
  }
}

class MovingBall extends StatelessWidget {
  final double x;
  final double y;

  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    double currentYPos = (y * 100);
    double currentXPos = (x * 100);

    return Stack(alignment: Alignment.center, children: [
      Text(
        ''' x: $x, y: $y ''',
        style: const TextStyle(fontSize: 30),
      ),
      AnimatedPositioned(
          left: currentYPos - 25 + (width / 2),
          top: currentXPos - 25 + (height / 2),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 1000),
          child: const Ball()),
    ]);
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.purple, shape: BoxShape.circle, borderRadius: BorderRadius.circular(100)),
    );
  }
}
