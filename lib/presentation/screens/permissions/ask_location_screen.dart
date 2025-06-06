import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class AskPermissionView extends ConsumerWidget {
  const AskPermissionView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permiso Requerido'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            ref.read(permissionsStateProvider.notifier).requestLocationAccess();
          },
          child: const Text('Localizacion necearia'),
        ),
      ),
    );
  }
}
