import 'package:dio/dio.dart';

import '../../domain/domain.dart';
import '../mappers/pokemon_mapper.dart';

class PokemonsDataSourceImpl implements PokemonsDataSource {
  final Dio dio;

  PokemonsDataSourceImpl() : dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final response = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokeApiPokemonToEntity(response.data);
      return ( pokemon, 'Data obtenida correctamente' );
    } catch (e) {
      return ( null, 'No se pudo obtener el pokémon $e' );
    }
  }
}
