import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/movie/movie.dart';
import '../../../providers/repositories_providers.dart';
import '../../../repositories/movie/http_movie_repository.dart';

final currentPageProvider = StateProvider<int>((ref) => 1);
final totalPagesProvider = StateProvider<int>((ref) => 1);

final homeControllerProvider = StateNotifierProvider<HomeController, AsyncValue<List<Movie>>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return HomeController(ref, movieRepository);
});

class HomeController extends StateNotifier<AsyncValue<List<Movie>>> {
  HomeController(this.ref, this.movieRepository) : super(const AsyncLoading()) {
    getMovies();
  }
  final HttpMovieRepository movieRepository;
  final Ref ref;

  Future<void> getMovies() async {
    state = const AsyncLoading();

    /// AsyncValue.guard() automatically catches all exceptions
    state = await AsyncValue.guard(() async {
      /// Fetch movies
      final movieData = await movieRepository.getMovies(
        page: ref.read(currentPageProvider),
      );

      /// Set total pages
      ref.read(totalPagesProvider.notifier).state = movieData.totalPages;

      /// Return list of movies
      return movieData.movies;
    });
  }
}
