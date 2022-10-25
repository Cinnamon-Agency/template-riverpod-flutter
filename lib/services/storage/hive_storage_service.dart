import 'package:hive_flutter/hive_flutter.dart';

import './storage_service.dart';

/// Implementation of [StorageService] with [Hive]
class HiveStorageService implements StorageService {
  late Box hiveBox;

  Future<void> openBox(String boxName) async {
    hiveBox = await Hive.openBox(boxName);
  }

  Future<void> closeBox() async {
    await hiveBox.close();
  }

  @override
  Future<void> deleteValue(String key) async {
    await hiveBox.delete(key);
  }

  @override
  dynamic getValue(String key) => hiveBox.get(key);

  @override
  dynamic getAll() => hiveBox.values.toList();

  @override
  bool hasValue(String key) => hiveBox.containsKey(key);

  @override
  Future<void> setValue({String? key, data}) async {
    await hiveBox.put(key, data);
  }

  @override
  Future<void> clear() async {
    await hiveBox.clear();
  }
}
