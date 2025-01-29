// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AdjectiveRouletteRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AdjectiveRouletteRouteArgs>(
          orElse: () =>
              AdjectiveRouletteRouteArgs(noun: pathParams.getString('noun')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AdjectiveRoulettePage(
          key: args.key,
          noun: args.noun,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    ImageDisplayRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ImageDisplayRouteArgs>(
          orElse: () => ImageDisplayRouteArgs(
                noun: pathParams.getString('noun'),
                adjective: pathParams.getString('adjective'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ImageDisplayPage(
          key: args.key,
          noun: args.noun,
          adjective: args.adjective,
        ),
      );
    },
    NounInputRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NounInputPage(),
      );
    },
  };
}

/// generated route for
/// [AdjectiveRoulettePage]
class AdjectiveRouletteRoute extends PageRouteInfo<AdjectiveRouletteRouteArgs> {
  AdjectiveRouletteRoute({
    Key? key,
    required String noun,
    List<PageRouteInfo>? children,
  }) : super(
          AdjectiveRouletteRoute.name,
          args: AdjectiveRouletteRouteArgs(
            key: key,
            noun: noun,
          ),
          rawPathParams: {'noun': noun},
          initialChildren: children,
        );

  static const String name = 'AdjectiveRouletteRoute';

  static const PageInfo<AdjectiveRouletteRouteArgs> page =
      PageInfo<AdjectiveRouletteRouteArgs>(name);
}

class AdjectiveRouletteRouteArgs {
  const AdjectiveRouletteRouteArgs({
    this.key,
    required this.noun,
  });

  final Key? key;

  final String noun;

  @override
  String toString() {
    return 'AdjectiveRouletteRouteArgs{key: $key, noun: $noun}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ImageDisplayPage]
class ImageDisplayRoute extends PageRouteInfo<ImageDisplayRouteArgs> {
  ImageDisplayRoute({
    Key? key,
    required String noun,
    required String adjective,
    List<PageRouteInfo>? children,
  }) : super(
          ImageDisplayRoute.name,
          args: ImageDisplayRouteArgs(
            key: key,
            noun: noun,
            adjective: adjective,
          ),
          rawPathParams: {
            'noun': noun,
            'adjective': adjective,
          },
          initialChildren: children,
        );

  static const String name = 'ImageDisplayRoute';

  static const PageInfo<ImageDisplayRouteArgs> page =
      PageInfo<ImageDisplayRouteArgs>(name);
}

class ImageDisplayRouteArgs {
  const ImageDisplayRouteArgs({
    this.key,
    required this.noun,
    required this.adjective,
  });

  final Key? key;

  final String noun;

  final String adjective;

  @override
  String toString() {
    return 'ImageDisplayRouteArgs{key: $key, noun: $noun, adjective: $adjective}';
  }
}

/// generated route for
/// [NounInputPage]
class NounInputRoute extends PageRouteInfo<void> {
  const NounInputRoute({List<PageRouteInfo>? children})
      : super(
          NounInputRoute.name,
          initialChildren: children,
        );

  static const String name = 'NounInputRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
