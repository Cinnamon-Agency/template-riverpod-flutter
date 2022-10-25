// ignore_for_file: unnecessary_lambdas

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/movie/movie.dart';
import '../../models/movie_response/movie_response.dart';
import '../../services/api/dio_service.dart';
import 'movie_repository.dart';

class HttpMovieRepository implements MovieRepository {
  final DioService api;
  final String locale;

  HttpMovieRepository({
    required this.api,
    required this.locale,
  });

  @override
  Future<MovieResponse> getMovies({int page = 1}) => api.request(
        method: HttpMethod.get,
        url: 'movie/popular',
        parameters: {'language': locale, 'page': page},
        builder: (data) => MovieResponse.fromJson(data),
        token: dotenv.env['TMDB_TOKEN'],
      );

  @override
  Future<Movie> getMovie(String id) => api.request(
        method: HttpMethod.get,
        url: 'movie/$id',
        builder: (data) => Movie.fromJson(data),
        token: dotenv.env['TMDB_TOKEN'],
      );
}
