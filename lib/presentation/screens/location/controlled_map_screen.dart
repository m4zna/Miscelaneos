import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userInitialLocation = ref.watch(userLocationProvider);
    return Scaffold(
        body: userInitialLocation.when(
            data: (data) => MapAndControls(latitud: data.$1, longitud: data.$2),
            error: (error, stackTrace) => Text('Error: $error'),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

class MapAndControls extends ConsumerWidget {
  final double latitud;
  final double longitud;

  const MapAndControls({super.key, required this.latitud, required this.longitud});

  @override
  Widget build(BuildContext context, ref) {
    final mapControllerState = ref.watch(mapControllerProvider);
    return Stack(
      children: [
        _MapView(initialLatitude: latitud, initialLongitude: longitud),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).goToLocation(latitud, longitud);
              },
              icon: const Icon(Icons.location_searching)),
        ),
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).toggleFollowUser();
              },
              icon: Icon(mapControllerState.followUser
                  ? Icons.directions_run_outlined
                  : Icons.accessibility_new_outlined)),
        ),
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).addMarkerCurrentPosition();
              },
              icon: const Icon(Icons.pin_drop)),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const _MapView({required this.initialLatitude, required this.initialLongitude});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapControllerState = ref.watch(mapControllerProvider);
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLatitude, widget.initialLongitude),
        zoom: 12,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
      markers: mapControllerState.markersSet,
      onLongPress: (latLng) => ref
          .read(mapControllerProvider.notifier)
          .addMarker(latLng.latitude, latLng.longitude, 'Nueva ubicación'),
    );
  }
}
