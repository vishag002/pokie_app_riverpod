import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo_app2/models/pokemon.dart';
import 'package:riverpod_demo_app2/providers/pokimon_data_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonUrl;
  const PokemonListTile({super.key, required this.pokemonUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(PokemaonDataProvider(pokemonUrl));
    return pokemon.when(
      data: (data) {
        return _tile(context, false, data);
      },
      error: (error, stackTrace) {
        return Text('Error : $error');
      },
      loading: () {
        return _tile(context, true, null);
      },
    );
  }

  Widget _tile(
    context,
    bool isloading,
    Pokemon? pokemon,
  ) {
    return Skeletonizer(
      enabled: isloading,
      child: ListTile(
        leading: pokemon != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!),
              )
            : CircleAvatar(),
        title: Text(pokemon != null
            ? pokemon.name!.toUpperCase()
            : "name loading loading plse"),
        subtitle: Text(pokemon != null
            ? "Has ${pokemon.moves!.length} moves"
            : "list is loading please wait..."),
      ),
    );
  }
}
