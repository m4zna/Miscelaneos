import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Miscelaneos'),
        actions: [
          IconButton(
              onPressed: () {
                context.push('/permissions');
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
