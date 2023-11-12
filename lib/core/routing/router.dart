import 'package:auto_route/auto_route.dart';
import 'package:flutter_pokemon/core/routing/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    RedirectRoute(path: '/', redirectTo: '/menu'),
    AutoRoute(
      path: '/menu',
      page: FeedRoute.page,
    ),
    AutoRoute(
      path: '/pokemon/:id',
      page: PokemonDetailRoute.page,
      
    ),
  ];
}
