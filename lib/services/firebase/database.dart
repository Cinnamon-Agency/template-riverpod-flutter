/// Abstract class defining [Database] structure
abstract class Database {
  Database();

  /// Add new data to a collection
  Future<dynamic> add(String collection, Map<String, dynamic> data);

  /// Update entry
  Future<void> update(String path, Map<String, dynamic> data);

  /// Create new entry
  Future<void> create(String path, Map<String, dynamic> data);

  /// Delete entry
  Future<void> delete(String path);
}
