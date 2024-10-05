import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo_app2/controllers/home_screen_controller.dart';
import 'package:riverpod_demo_app2/models/page_data.dart';

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
  late HomeScreenController _homeScreenController;
  late HomePageData _homePageData;

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
              itemCount: _homePageData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                int i = index + 1;
                return ListTile(
                  title: Text(i.toString()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
