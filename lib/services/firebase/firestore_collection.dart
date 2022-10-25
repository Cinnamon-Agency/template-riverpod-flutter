import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Abstract class defining [FirestoreCollection] structure
class FirestoreCollection<T> {
  FirestoreCollection();

  final String path = '';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Get collection data converted to a Model
  CollectionReference<T> get withConverter => throw UnimplementedError();

  /// Get ordered data
  Query<T> orderBy(String field, [bool desc = false]) => withConverter.orderBy(field, descending: desc);

  /// Get single document by ID
  Future<T?> futureSingle(String id) async => (await withConverter.doc(id).get()).data();

  /// Get all sorted documents
  Future<Map<String, T>> futureAll([String? orderBy, bool desc = false]) async {
    List<QueryDocumentSnapshot<T>> docs;

    docs = orderBy != null ? (await this.orderBy(orderBy, desc).get()).docs : (await withConverter.get()).docs;

    return {for (QueryDocumentSnapshot<T> doc in docs) doc.id: doc.data()};
  }

  /// Get a stream of a single document by ID
  Stream<T?> streamSingle(String? id) async* {
    if (id == null) {
      yield* const Stream.empty();
    } else {
      final streamController = StreamController<T?>();

      try {
        withConverter.doc(id).snapshots().listen(
          (event) {
            streamController.add(event.data());
          },
          onError: (e) {
            streamController
              ..addError(e)
              ..close();
          },
        );
      } catch (e) {
        streamController.addError(e);
        await streamController.close();
      }

      yield* streamController.stream;
    }
  }

  /// Compare one field to one value
  Query<T> whereEqual1(String field, String value) => withConverter.where(field, isEqualTo: value);

  /// Compare two fields to two values
  Query<T> whereEqual2(
    String field1,
    value1,
    String field2,
    value2,
  ) =>
      withConverter.where(field1, isEqualTo: value1).where(field2, isEqualTo: value2);
}
