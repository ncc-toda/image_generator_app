import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/adjective_roulette_page.dart';
import '../pages/home_page.dart';
import '../pages/image_display_page.dart';
import '../pages/noun_input_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: NounInputRoute.page,
        ),
        AutoRoute(
          page: AdjectiveRouletteRoute.page,
        ),
        AutoRoute(
          page: ImageDisplayRoute.page,
        ),
      ];
}
