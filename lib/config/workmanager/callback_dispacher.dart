import 'package:miscelaneos/infrastructure/repositories/local_db_repository_impl.dart';
import 'package:miscelaneos/infrastructure/repositories/pokemons_repository_impl.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey = 'com.m4nzna.miscelaneos.fetch-background-pokemon';
const fetchPeriodicBackgroundTaskKey = 'com.m4nzna.miscelaneos.fetch-background-pokemon';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundTaskKey:
        print('fetchBackgroundTaskKey');
        await loadNextPokemon();
        break;

      case fetchPeriodicBackgroundTaskKey:
        print('fetchPeriodicBackgroundTaskKey');
        await loadNextPokemon();
        break;
      case Workmanager.iOSBackgroundTask:
        print("Workmanager.iOSBackgroundTask");
        break;
      default:
        print("Native called background task: $task");
    }
    return true;
  });
}

Future loadNextPokemon() async {
  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonsRepositoryImpl();
  final lastPokemon = await localDbRepository.pokemonCount() + 1;
  try {
    final (pokemon, message) = await pokemonRepository.getPokemon(lastPokemon.toString());

    if (pokemon == null) throw message;
    await localDbRepository.insertPokemons(pokemon);
    print('pokemon inserted: ${pokemon.name}!!!');
  } catch (error) {
    print(error);
  }
}
