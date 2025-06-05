import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class PermissionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permisos'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionsState = ref.watch(permissionsStateProvider);

    return ListView(
      children: [
        CheckboxListTile(
            value: permissionsState.cameraGranted,
            title: const Text('Camara'),
            subtitle: Text('Estado actual${permissionsState.camera}'),
            onChanged: (value) {
              ref.read(permissionsStateProvider.notifier).requestCameraAccess();
            }),

        CheckboxListTile(
            value: permissionsState.photoLibraryGranted,
            title: const Text('Galeria de fotos'),
            subtitle: Text('Estado actual${permissionsState.photoLibrary}'),
            onChanged: (value) {
              ref.read(permissionsStateProvider.notifier).requestPhotoLibraryAccess();
            }),
        CheckboxListTile(
            value: permissionsState.locationGranted,
            title: const Text('Location'),
            subtitle: Text('Estado actual${permissionsState.location}'),
            onChanged: (value) {
              ref.read(permissionsStateProvider.notifier).requestLocationAccess();
            }),
        CheckboxListTile(
            value: permissionsState.sensorsGranted,
            title: const Text('Sensores'),
            subtitle: Text('Estado actual${permissionsState.sensors}'),
            onChanged: (value) {
              ref.read(permissionsStateProvider.notifier).requestSensorsAccess();
            }),

      ],
    );
  }
}
