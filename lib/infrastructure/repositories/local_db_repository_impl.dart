import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/datasources/isar_local_db_datasource.dart';

class LocalDbRepositoryImpl extends LocalDbRepository {
  final LocalDbDataSource _dataSource;

  LocalDbRepositoryImpl({LocalDbDataSource? dataSource})
      : _dataSource = dataSource ?? IsarLocalDbDatasource();

  @override
  Future<void> insertPokemons(Pokemon pokemons) {
    print('inserted');
    return _dataSource.insertPokemons(pokemons);
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _dataSource.loadPokemons();
  }

  @override
  Future<int> pokemonCount() {
    return _dataSource.pokemonCount();
  }
}
