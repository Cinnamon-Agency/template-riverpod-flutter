import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/detail_page_args.dart';
import '../../../models/movie/movie.dart';
import '../../../providers/repositories_providers.dart';
import '../../../repositories/movie/http_movie_repository.dart';

final detailPageControllerProvider =
    StateNotifierProvider.family<DetailPageController, AsyncValue<Movie>, DetailPageArgs>((ref, args) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return DetailPageController(movieRepository, args);
});

class DetailPageController extends StateNotifier<AsyncValue<Movie>> {
  DetailPageController(this.movieRepository, this.args) : super(const AsyncLoading()) {
    if (args.movie != null) {
      state = AsyncData(args.movie!);
    } else if (args.id != null) {
      getMovie(args.id!);
    } else {
      state = const AsyncError('No Movie Found', StackTrace.empty);
    }
  }
  final HttpMovieRepository movieRepository;
  final DetailPageArgs args;

  Future<void> getMovie(String id) async {
    state = const AsyncLoading();

    /// Fetch movie by ID
    state = await AsyncValue.guard(() => movieRepository.getMovie(id));
  }
}
