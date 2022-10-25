import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'collections.dart';
import 'database.dart';

/// Contains all queries to Firestore.
class FirestoreService extends Database {
  FirestoreService(this.db) : super();

  /// The [FirebaseFirestore] instance used to make all requests through the Firestore plugin.
  final FirebaseFirestore db;

  @protected
  final movieCollection = MovieCollection();

  /// Check if document exists
  Future<bool> docExists(String docPath) async {
    final doc = await db.doc(docPath).get();

    return doc.exists;
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> add(
    String collection,
    Map<String, dynamic> data,
  ) =>
      db.collection(collection).add(data);

  @override
  Future<void> update(String path, Map<String, dynamic> data) => db.doc(path).update(data);

  @override
  Future<void> create(String path, Map<String, dynamic> data) => db.doc(path).set(data);

  Future<void> set(String path, Map<String, dynamic> data) => db.doc(path).set(data, SetOptions(merge: true));

  @override
  Future<void> delete(String path) => db.doc(path).delete();

  /// More about Firestore Transactions here:
  /// https://firebase.google.com/docs/firestore/manage-data/transactions
  Future<T> runGetTransaction<T>(
    DocumentReference<Map<String, dynamic>> documentRef,
    Future<T> Function(
      Transaction tx,
      DocumentSnapshot<Map<String, dynamic>> snapshot,
    )
        transaction,
  ) =>
      db.runTransaction((tx) async {
        final snapshot = await tx.get(documentRef);

        return transaction(tx, snapshot);
      });

  /// You can add more custom Firebase calls below
}
