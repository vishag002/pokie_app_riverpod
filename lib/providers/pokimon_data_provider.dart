import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_demo_app2/models/pokemon.dart';
import 'package:riverpod_demo_app2/services/database_services.dart';
import 'package:riverpod_demo_app2/services/http_service.dart';

final PokemaonDataProvider = FutureProvider.family<Pokemon?, String>(
  (ref, url) async {
    HTTPService _httpService = GetIt.instance.get<HTTPService>();
    Response? res = await _httpService.get(url);
    if (res != null && res.data != null) {
      return Pokemon.fromJson(res.data!);
    }
    return null;
  },
);

final favoritePokemonProvider =
    StateNotifierProvider<FavoritePokemonProvider, List<String>>((ref) {
  return FavoritePokemonProvider([]);
});

class FavoritePokemonProvider extends StateNotifier<List<String>> {
  final String Favorite_Key = "Favorite_KEY";
  final DatabaseServices _databaseServices =
      GetIt.instance.get<DatabaseServices>();
  FavoritePokemonProvider(super.state) {
    _setup();
  }
  Future<void> _setup() async {
    List<String>? result = await _databaseServices.getList(Favorite_Key);
    state = result ?? [];
  }

  //add favoritePokemon
  void addFavoritePokemon(String url) async {
    state = [...state, url];
    _databaseServices.saveList(Favorite_Key, state);
  }

  void removeFavoritePokemon(String url) async {
    state = state.where((e) => e != url).toList();
    _databaseServices.saveList(Favorite_Key, state);
  }
}
