import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:workmanager/workmanager.dart';

import '../../../domain/domain.dart';
import '../../providers/providers.dart';

class DbPokemonsScreen extends ConsumerWidget {
  const DbPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pokemons = ref.watch(pokemonDbProvider);
    final isBackgroundFetchActive = ref.watch(backgroundPokemonFetchProvider);
    if (pokemons.isLoading) return const Center(child: CircularProgressIndicator());
    final List<Pokemon> pokemonsList = pokemons.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemons'),
        actions: [
          IconButton(
              onPressed: () {
                Workmanager().registerOneOffTask(fetchBackgroundTaskKey, fetchBackgroundTaskKey,
                    initialDelay: const Duration(seconds: 3), inputData: {'howMany': '30'});
              },
              icon: const Icon(Icons.add_alarm_outlined))
        ],
      ),
      body: CustomScrollView(slivers: [
        _PokemonGrid(
          pokemons: pokemonsList,
        )
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(backgroundPokemonFetchProvider.notifier).toggleProcess();
        },
        label: isBackgroundFetchActive == true
            ? const Text('Desactivar fetc periodico')
            : const Text('Activar fetch periodico'),
        icon: const Icon(Icons.av_timer),
      ),
    );
  }
}

class _PokemonGrid extends StatelessWidget {
  final List<Pokemon> pokemons;

  const _PokemonGrid({super.key, required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemCount: pokemons.length,
      itemBuilder: (BuildContext context, int index) {
        final pokemon = pokemons[index];
        return Column(
          children: [Image.network(pokemon.spriteFront, fit: BoxFit.contain), Text(pokemon.name)],
        );
      },
    );
  }
}
