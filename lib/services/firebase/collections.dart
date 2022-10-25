import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/movie/movie.dart';
import 'firestore_collection.dart';

/// Implementation of [FirestoreCollection] with [Movie] collection
class MovieCollection extends FirestoreCollection<Movie> {
  @override
  String get path => 'movies';

  @override
  CollectionReference<Movie> get withConverter => firestore.collection(path).withConverter<Movie>(
        fromFirestore: (snapshot, _) => Movie.fromFirestore(snapshot),
        toFirestore: (movie, _) => movie.toJson(),
      );

  @override
  Future<Map<String, Movie>> futureAll([
    String? orderBy,
    bool? desc = false,
  ]) async {
    final movies = <String, Movie>{};

    final moviesColl = await withConverter.get();

    for (final DocumentSnapshot<Movie> doc in moviesColl.docs) {
      final movie = doc.data()!;
      movies.addAll({doc.id: movie});
    }

    return movies;
  }

  /// You can add more custom functions for this collection below
}
/// You can add more Firestore collections collection below
