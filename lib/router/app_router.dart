import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/detail/pages/detail_page.dart';
import '../features/home/pages/home_page.dart';
import '../models/detail_page_args.dart';
import '../models/movie/movie.dart';
import '../utils/not_found_page.dart';
import 'route_names.dart';
import 'route_paths.dart';

class AppRouter {
  AppRouter(WidgetRef ref) {
    appRouter = _getAppRouter(ref);
  }

  /// Use this for testing to change the initial
  /// location and quickly access some page
  @visibleForTesting
  String setInitialLocation(String location) => initialLocation = location;

  late GoRouter appRouter;
  static String initialLocation = RoutePaths.home;

  GoRouter _getAppRouter(WidgetRef ref) => GoRouter(
        initialLocation: initialLocation,
        debugLogDiagnostics: true,
        errorBuilder: (context, state) => const NotFoundPage(),
        routes: [
          GoRoute(
            path: RoutePaths.home,
            name: RouteNames.home,
            builder: (context, state) => HomePage(
              key: state.pageKey,
            ),
            routes: [
              GoRoute(
                path: '${RoutePaths.detail}/:id',
                name: RouteNames.detail,
                builder: (context, state) {
                  final movie = state.extra as Movie?;

                  return DetailPage(
                    args: DetailPageArgs(
                      id: state.params['id'],
                      movie: movie,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      );
}
