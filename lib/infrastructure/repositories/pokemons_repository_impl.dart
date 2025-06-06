import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/datasources/pokemons_datasources_impl.dart';

class PokemonsRepositoryImpl implements PokemonRepository {
  final PokemonsDataSource dataSource;

  PokemonsRepositoryImpl({PokemonsDataSource? dataSource})
      : dataSource = dataSource ?? PokemonsDataSourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return await dataSource.getPokemon(id);
  }

}