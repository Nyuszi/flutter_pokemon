import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon/core/entities/pokemon.dart';
import 'package:flutter_pokemon/core/entities/pokemon_type.dart';
import 'package:flutter_pokemon/core/repositories/pokeapi_service.dart';
import 'package:flutter_pokemon/features/feed/presentation/cubit/pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final PokeApiService _pokeApiService;
  List<PokemonType> types = [];
  PokemonType? selectedType;
  String searchedName = '';
  TextEditingController controller = TextEditingController();
  bool showCaughtOnly = false;

  PokemonCubit(this._pokeApiService) : super(const PokemonState.initial());

  Future<void> loadAllPokemons() async {
    emit(const PokemonState.loading());
    try {
      types = await _pokeApiService.getPokemonTypes();
      final List<Pokemon> pokemons;

      pokemons = await _pokeApiService.getPokemonList(
          name: searchedName,
          type: selectedType == null ? null : selectedType!.name,
          showCaughtOnly: showCaughtOnly);

      emit(PokemonState.loaded(pokemons));
    } catch (error) {
      emit(PokemonState.error('Failed to load pokemons: $error'));
    }
  }

  void setSelectedType(PokemonType selected) {
    selectedType = selected;
    loadAllPokemons();
  }

  void searchName(String name) {
    searchedName = name;
    loadAllPokemons();
  }

  Future<void> togleCatchPokemon(String pokemonName) async {
    if (await _pokeApiService.isPokemonCaught(pokemonName)) {
      _pokeApiService.releasePokemon(pokemonName);
    } else {
      _pokeApiService.catchPokemon(pokemonName);
    }
    loadAllPokemons();
  }

  void toggleShowCaughtOnly(bool value) {
    showCaughtOnly = value;
    loadAllPokemons();
  }
}
