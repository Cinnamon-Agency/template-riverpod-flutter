import 'movie/movie.dart';

class DetailPageArgs {
  DetailPageArgs({
    this.id,
    this.movie,
  });

  final String? id;
  final Movie? movie;
}
