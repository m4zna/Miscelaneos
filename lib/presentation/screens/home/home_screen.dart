import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: CustomScrollView(slivers: [
          SliverAppBar(title: Text('Miscelaneos'), actions: [
            IconButton(
                onPressed: () {
                  context.push('/permissions');
                },
                icon: Icon(Icons.settings))
          ]),
          MainMenu(),
        ]),
      ),
    );
  }
}
