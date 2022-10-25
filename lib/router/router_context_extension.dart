import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

/// Extension on [BuildContext] to simplify navigation
extension RouterContextExtension on BuildContext {
  void pop() {
    GoRouter.of(this).pop();
  }

  void goHome({
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) {
    GoRouter.of(this).goNamed(
      RouteNames.home,
      queryParams: queryParams,
      extra: extra,
    );
  }

  void replaceHome({
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) {
    GoRouter.of(this).replaceNamed(
      RouteNames.home,
      queryParams: queryParams,
      extra: extra,
    );
  }

  void pushDetailPage({
    Object? args,
    String? id,
  }) =>
      GoRouter.of(this).pushNamed(
        RouteNames.detail,
        extra: args,
        params: {'id': id ?? '0'},
      );
}
