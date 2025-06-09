import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final pokemonDbProvider = FutureProvider.autoDispose<List<Pokemon>>((ref) async {
  final localDb = LocalDbRepositoryImpl();
  final pokemons = await localDb.loadPokemons();
  return pokemons;
});
