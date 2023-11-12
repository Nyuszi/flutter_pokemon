import 'package:flutter_pokemon/core/entities/pokemon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_state.freezed.dart';

@freezed
class PokemonState with _$PokemonState {
  const factory PokemonState.initial() = _Initial;
  const factory PokemonState.loading() = _Loading;
  const factory PokemonState.loaded(List<Pokemon> types) = _Loaded;
  const factory PokemonState.error(String error) = _Error;
}
