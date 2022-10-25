import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/movie/http_movie_repository.dart';
import 'locale_provider.dart';
import 'services_providers.dart';

final movieRepositoryProvider = Provider<HttpMovieRepository>(
  (ref) => HttpMovieRepository(
    api: ref.read(dioServiceProvider),
    locale: ref.read(localeProvider),
  ),
);
