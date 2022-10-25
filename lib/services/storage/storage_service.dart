/// Static class for defining keys for storing values
class StorageKeys {
  static const String currentLocale = 'current_locale';
}

/// Abstract class defining [StorageService] structure
abstract class StorageService {
  /// Delete value by key
  Future<void> deleteValue(String key);

  /// Get value by key
  dynamic getValue(String key);

  /// Get all keys and values
  dynamic getAll();

  /// Clear storage
  Future<void> clear();

  /// Check if key has value
  bool hasValue(String key);

  /// Store new value
  Future<void> setValue({String key, data});
}
