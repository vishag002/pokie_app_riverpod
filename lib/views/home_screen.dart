import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo_app2/controllers/home_screen_controller.dart';
import 'package:riverpod_demo_app2/models/page_data.dart';
import 'package:riverpod_demo_app2/widgets/pokemon_listtile.dart';

final homeScreenControllerProvider =
    StateNotifierProvider<HomeScreenController, HomePageData>(
  (ref) {
    return HomeScreenController(HomePageData.initial());
  },
);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _allPokemonListScrollController = ScrollController();
  late HomeScreenController _homeScreenController;
  late HomePageData _homePageData;

  @override
  void initState() {
    super.initState();
    _allPokemonListScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _allPokemonListScrollController.removeListener(_scrollListener);
    _allPokemonListScrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_allPokemonListScrollController.offset >=
            _allPokemonListScrollController.position.maxScrollExtent * 1 &&
        !_allPokemonListScrollController.position.outOfRange) {
      _homeScreenController.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    _homeScreenController = ref.watch(homeScreenControllerProvider.notifier);
    _homePageData = ref.watch(homeScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
          //  title: Text("App Name"),
          ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            allPokemonList(context),
          ],
        ),
      ),
    );
  }

  //allPokimon List
  Widget allPokemonList(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "All Pokemons",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .60,
            child: ListView.builder(
              controller: _allPokemonListScrollController,
              itemCount: _homePageData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                return PokemonListTile(
                    pokemonUrl: _homePageData.data?.results?[index].url ?? "");
              },
            ),
          )
        ],
      ),
    );
  }
}
