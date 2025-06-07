import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/location/user_location_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentLocation = ref.watch(userLocationProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('Map Screen')),
        body: currentLocation.when(
            data: (data) => _MapView(initialLatitude: data.$1, initialLongitude: data.$2),
            error: (error, stackTrace) => Text('Error: $error'),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

class _MapView extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const _MapView({required this.initialLatitude, required this.initialLongitude});

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLatitude, widget.initialLongitude),
        zoom: 12,
      ),
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        // _controller.complete(controller);
      },
    );
  }
}
