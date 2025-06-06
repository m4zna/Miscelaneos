import '../domain.dart';

abstract class PokemonsDataSource {
  Future<(Pokemon?, String)> getPokemon(String id);
}
