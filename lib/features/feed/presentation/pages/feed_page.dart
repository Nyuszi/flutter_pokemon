import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon/core/entities/pokemon_type.dart';
import 'package:flutter_pokemon/core/routing/router.gr.dart';
import 'package:flutter_pokemon/features/feed/presentation/cubit/pokemon_cubit.dart';
import 'package:flutter_pokemon/features/feed/presentation/cubit/pokemon_state.dart';
import 'package:flutter_pokemon/features/feed/presentation/widgets/custom_appbar.dart';
import 'package:flutter_pokemon/features/feed/presentation/widgets/custom_drawer.dart';
import 'package:flutter_pokemon/features/feed/presentation/widgets/pokemon_list_tile.dart';
import 'package:flutter_pokemon/features/feed/presentation/widgets/pokemon_type_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class FeedPage extends StatelessWidget {
  FeedPage({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Uri _url = Uri.parse('https://pokeapi.co/');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: CustomDrawer(
        onApiPressed: () async {
          if (!await launchUrl(_url)) {
            throw Exception('Could not launch $_url');
          }
        },
      ),
      body: Column(children: [
        BlocConsumer<PokemonCubit, PokemonState>(
          listener: (context, state) {
            state.maybeWhen(
              initial: () {
                context.read<PokemonCubit>().loadAllPokemons();
              },
              error: (error) {
                Fluttertoast.showToast(
                  msg: "An error occurred!$error",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loaded: (pokemon) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(kIsWeb ? 20 : 10),
                      child: Column(
                        children: [
                          TextField(
                            controller: context.read<PokemonCubit>().controller,
                            onChanged: (value) {
                              context.read<PokemonCubit>().searchName(value);
                            },
                            decoration: InputDecoration(
                              labelText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text('Pokemon Types'),
                          const SizedBox(
                            height: 16,
                          ),
                          PokemonTypeDropdown(
                            types: context.read<PokemonCubit>().types,
                            selectedType:
                                context.read<PokemonCubit>().selectedType,
                            selectType: (PokemonType? selectedType) {
                              context
                                  .read<PokemonCubit>()
                                  .setSelectedType(selectedType!);
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Show Caught Only'),
                              Checkbox(
                                value:
                                    context.read<PokemonCubit>().showCaughtOnly,
                                onChanged: (value) {
                                  context
                                      .read<PokemonCubit>()
                                      .toggleShowCaughtOnly(value ?? false);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      color: Colors.blue.shade100,
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('name'),
                              Text('type'),
                              Text('status'),
                              SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: kIsWeb ? 800 : 391,
                          child: ListView.builder(
                            itemCount: pokemon.length,
                            itemBuilder: (context, index) {
                              return PokemonListTile(
                                pokemon: pokemon[index],
                                onTap: () {
                                  AutoRouter.of(context)
                                      .push(PokemonDetailRoute(
                                          id: index,
                                          pokemon: pokemon[index],
                                          onButtonTap: () {
                                            context
                                                .read<PokemonCubit>()
                                                .togleCatchPokemon(
                                                    pokemon[index].name);

                                            AutoRouter.of(context).back();
                                          }));
                                },
                                onButtonTap: () {
                                  context
                                      .read<PokemonCubit>()
                                      .togleCatchPokemon(pokemon[index].name);
                                },
                              );
                            },
                          ),
                        ),
                      ]),
                    )
                  ],
                );
              },
              orElse: () {
                context.read<PokemonCubit>().loadAllPokemons();
                return const SizedBox(
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          },
        ),
      ]),
    );
  }
}
