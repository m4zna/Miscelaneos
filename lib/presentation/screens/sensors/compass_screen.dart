import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../screens.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionsStateProvider).locationGranted;
    final compass = ref.watch(compassProvider);
    if (!locationGranted) {
      return const AskPermissionView();
    }

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Brujula', style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
        ),
        body: Center(
            child: compass.when(
                data: (double? heading) => Compass(heading: heading ?? 0),
                error: (Object error, StackTrace stackTrace) {
                  Text('Error: ${error.toString()}', style: const TextStyle(color: Colors.white));
                },
                loading: () {
                  const CircularProgressIndicator();
                })));
  }
}

class Compass extends StatefulWidget {
  final double heading;

  const Compass({super.key, required this.heading});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double prevValue = 0.0;
  double turns = 0;

  double getTurns() {
    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction) : direction;

    double diff = direction - prevValue;
    if (diff.abs() > 180) {
      if (prevValue > direction) {
        diff = 360 - (direction - prevValue).abs();
      } else {
        diff = 360 - (prevValue - direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${widget.heading.ceil()}', style: const TextStyle(color: Colors.white, fontSize: 30)),
        const SizedBox(
          height: 20,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            // Image.asset('assets/images/quadrant-1.png'),
            // Transform.rotate(
            //   angle: (heading * (pi / 180) * -1),
            //   child: Image.asset('assets/images/needle-1.png'),
            // ),
            // AnimatedRotation(
            //   curve: Curves.easeInOut,
            //   turns: getTurns(),
            //   duration: const Duration(milliseconds: 500),
            //   child: Image.asset('assets/images/needle-1.png'),
            // )
            Image.asset('assets/images/needle-1.png'),
            AnimatedRotation(
              curve: Curves.easeInOut,
              turns: getTurns(),
              duration: const Duration(milliseconds: 500),
              child: Image.asset('assets/images/quadrant-2.png'),
            )
          ],
        )
      ],
    );
  }
}
