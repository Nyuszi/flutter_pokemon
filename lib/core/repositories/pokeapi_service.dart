import 'package:dio/dio.dart';
import 'package:flutter_pokemon/core/entities/pokemon.dart';
import 'package:flutter_pokemon/core/entities/pokemon_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokeApiService {
  final Dio _dio = Dio();

  Future<List<Pokemon>> getPokemonList({
    String? type,
    String? name,
    bool showCaughtOnly = false,
  }) async {
    try {
      final response = await _dio.get(
        'https://pokeapi.co/api/v2/pokemon?limit=50',
      );

      final List<dynamic> results = response.data['results'] as List<dynamic>;
      final List<Pokemon> pokemonList = [];

      for (final pokemon in results) {
        final pokemonName = pokemon['name'] as String;
        final detailResponse = await _dio.get(
          'https://pokeapi.co/api/v2/pokemon/$pokemonName',
        );

        final List<String> typeNames = [];
        for (final type in detailResponse.data['types']) {
          final typeName = type['type']['name'] as String;
          typeNames.add(typeName);
        }

        final List<String> abilities = [];
        for (final type in detailResponse.data['abilities']) {
          final bool isHidden = type['is_hidden'] as bool;
          if (!isHidden) {
            abilities.add(type['ability']['name'] as String);
          }
        }

        final bool isCaught = await isPokemonCaught(pokemonName);

        final bool matchesSearchCriteria =
            (type == null || typeNames.contains(type.toLowerCase())) &&
                (name == null ||
                    pokemonName.toLowerCase().contains(name.toLowerCase())) &&
                (!showCaughtOnly || (showCaughtOnly && isCaught));

        if (matchesSearchCriteria) {
          pokemonList.add(
            Pokemon(
              name: pokemonName,
              url: pokemon['url'],
              status: isCaught,
              type: typeNames,
              weight: detailResponse.data['weight'],
              height: detailResponse.data['height'],
              abilities: abilities,
              pictureUrl: detailResponse.data['sprites']['front_default'],
            ),
          );
        }
      }

      return pokemonList;
    } catch (error) {
      print('Error fetching Pokemon list: $error');
      rethrow;
    }
  }

  Future<bool> isPokemonCaught(String pokemonName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(pokemonName) ?? false;
  }

  Future<void> catchPokemon(String pokemonName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(pokemonName, true);
  }

  Future<void> releasePokemon(String pokemonName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(pokemonName, false);
  }

  Future<List<PokemonType>> getPokemonTypes() async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/type/');
      final List<PokemonType> typeList = (response.data['results'] as List)
          .map((json) => PokemonType.fromJson(json))
          .toList();
      return typeList;
    } catch (error) {
      print('Error fetching Pokemon types: $error');
      rethrow;
    }
  }
}
