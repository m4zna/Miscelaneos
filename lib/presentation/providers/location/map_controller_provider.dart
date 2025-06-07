import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  final GoogleMapController? mapController;

  MapState(
      {this.isReady = false, this.followUser = false, this.markers = const [], this.mapController});

  Set<Marker> get markersSet {
    return Set.from(markers);
  }

  MapState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? mapController,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      followUser: followUser ?? this.followUser,
      markers: markers ?? this.markers,
      mapController: mapController ?? this.mapController,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  StreamSubscription? userLocation;
  (double, double)? lastKnownLocation;

  MapNotifier() : super(MapState()) {
    trackUser().listen((event) {
      lastKnownLocation = (event.$1, event.$2);
    });
  }

  Stream<(double, double)> trackUser() async* {
    await for (final pos in Geolocator.getPositionStream()) {
      yield (pos.latitude, pos.longitude);
    }
  }

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(mapController: controller, isReady: true);
  }

  goToLocation(double lat, double lng) {
    final newPosition = CameraPosition(target: LatLng(lat, lng), zoom: 15);
    state.mapController?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  void toggleFollowUser() {
    state = state.copyWith(followUser: !state.followUser);
    if (state.followUser) {
      findUser();
      userLocation = trackUser().listen((event) {
        goToLocation(event.$1, event.$2);
      });
    } else {
      userLocation?.cancel();
    }
  }

  findUser() {
    if (lastKnownLocation == null) return;
    goToLocation(lastKnownLocation!.$1, lastKnownLocation!.$2);
  }

  addMarkerCurrentPosition() {
    if (lastKnownLocation == null) return;
    addMarker(lastKnownLocation!.$1, lastKnownLocation!.$2, 'Mi ubicación');
  }

  addMarker(double lat, double lng, String name) {
    final newMarker = Marker(
        markerId: MarkerId(state.markers.length.toString()),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
            title: name, snippet: '${lat.toStringAsFixed(3)}, ${lng.toStringAsFixed(3)}'));
    state = state.copyWith(markers: [...state.markers, newMarker]);
  }
}

final mapControllerProvider = StateNotifierProvider.autoDispose<MapNotifier, MapState>((ref) {
  return MapNotifier();
});
