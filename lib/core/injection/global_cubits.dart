import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokemon/core/repositories/pokeapi_service.dart';
import 'package:flutter_pokemon/features/feed/presentation/cubit/pokemon_cubit.dart';

class GlobalCubits {
  static List<BlocProvider<dynamic>> getCubits() {
    final pokeApiService = PokeApiService();
    return [
      
      BlocProvider<PokemonCubit>(create: (_) => PokemonCubit(pokeApiService)),
    ];
  }
}
