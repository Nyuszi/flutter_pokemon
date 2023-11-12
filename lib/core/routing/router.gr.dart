// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter_pokemon/core/entities/pokemon.dart' as _i5;
import 'package:flutter_pokemon/features/feed/presentation/pages/feed_page.dart'
    as _i1;
import 'package:flutter_pokemon/features/feed/presentation/pages/pokemon_detail_page.dart'
    as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    FeedRoute.name: (routeData) {
      final args =
          routeData.argsAs<FeedRouteArgs>(orElse: () => const FeedRouteArgs());
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.FeedPage(key: args.key),
      );
    },
    PokemonDetailRoute.name: (routeData) {
      final args = routeData.argsAs<PokemonDetailRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.PokemonDetailPage(
          key: args.key,
          id: args.id,
          pokemon: args.pokemon,
          onButtonTap: args.onButtonTap,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.FeedPage]
class FeedRoute extends _i3.PageRouteInfo<FeedRouteArgs> {
  FeedRoute({
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          FeedRoute.name,
          args: FeedRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'FeedRoute';

  static const _i3.PageInfo<FeedRouteArgs> page =
      _i3.PageInfo<FeedRouteArgs>(name);
}

class FeedRouteArgs {
  const FeedRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'FeedRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.PokemonDetailPage]
class PokemonDetailRoute extends _i3.PageRouteInfo<PokemonDetailRouteArgs> {
  PokemonDetailRoute({
    _i4.Key? key,
    required int id,
    required _i5.Pokemon pokemon,
    required void Function() onButtonTap,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          PokemonDetailRoute.name,
          args: PokemonDetailRouteArgs(
            key: key,
            id: id,
            pokemon: pokemon,
            onButtonTap: onButtonTap,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'PokemonDetailRoute';

  static const _i3.PageInfo<PokemonDetailRouteArgs> page =
      _i3.PageInfo<PokemonDetailRouteArgs>(name);
}

class PokemonDetailRouteArgs {
  const PokemonDetailRouteArgs({
    this.key,
    required this.id,
    required this.pokemon,
    required this.onButtonTap,
  });

  final _i4.Key? key;

  final int id;

  final _i5.Pokemon pokemon;

  final void Function() onButtonTap;

  @override
  String toString() {
    return 'PokemonDetailRouteArgs{key: $key, id: $id, pokemon: $pokemon, onButtonTap: $onButtonTap}';
  }
}
