import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

///state notifier provider

final permissionsStateProvider = StateNotifierProvider<PermissionsStateNotifier, PermissionsState>(
  (ref) => PermissionsStateNotifier(),
);

class PermissionsStateNotifier extends StateNotifier<PermissionsState> {
  PermissionsStateNotifier() : super(PermissionsState()) {
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final permissionArray = await Future.wait([
      Permission.camera.request(),
      Permission.photos.request(),
      Permission.sensors.request(),
      Permission.location.request(),
      Permission.locationAlways.request(),
      Permission.locationWhenInUse.request(),
    ]);
    state = state.copyWith(
      camera: permissionArray[0],
      photoLibrary: permissionArray[1],
      sensors: permissionArray[2],
      location: permissionArray[3],
      locationAlways: permissionArray[4],
      locationWhenInUse: permissionArray[5],
    );
  }

  openAppSettingsScreen() async {
    await openAppSettings();
  }

  _checkPermission(PermissionStatus status) async {
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettingsScreen();
    }
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);
    _checkPermission(status);
  }

  requestPhotoLibraryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);
    _checkPermission(status);
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);
    _checkPermission(status);
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);
    _checkPermission(status);
  }




}

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
    this.camera = PermissionStatus.denied,
    this.photoLibrary = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  get cameraGranted => camera == PermissionStatus.granted;

  get photoLibraryGranted => photoLibrary == PermissionStatus.granted;

  get sensorsGranted => sensors == PermissionStatus.granted;

  get locationGranted => location == PermissionStatus.granted;

  get locationAlwaysGranted => locationAlways == PermissionStatus.granted;

  get locationWhenInUseGranted => locationWhenInUse == PermissionStatus.granted;

  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) =>
      PermissionsState(
        camera: camera ?? this.camera,
        photoLibrary: photoLibrary ?? this.photoLibrary,
        sensors: sensors ?? this.sensors,
        location: location ?? this.location,
        locationAlways: locationAlways ?? this.locationAlways,
        locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
      );
}
