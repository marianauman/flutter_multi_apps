import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageException implements Exception {
  final String message;
  HiveStorageException(this.message);

  @override
  String toString() => 'HiveStorageException: $message';
}

class HiveStorageManager {
  static final HiveStorageManager _instance = HiveStorageManager._internal();
  
  factory HiveStorageManager() {
    return _instance;
  }
  
  HiveStorageManager._internal();

  bool _isInitialized = false;

  // Initialize Hive
  Future<void> init() async {
    try {
      if (!_isInitialized) {
        await Hive.initFlutter();
        _isInitialized = true;
      }
    } catch (e) {
      throw HiveStorageException('Failed to initialize Hive: $e');
    }
  }

  // Open a box
  Future<Box> openBox(String boxName) async {
    try {
      if (!_isInitialized) {
        throw HiveStorageException('Hive is not initialized');
      }
      if (boxName.isEmpty) {
        throw HiveStorageException('Box name cannot be empty');
      }
      return await Hive.openBox(boxName);
    } catch (e) {
      throw HiveStorageException('Failed to open box $boxName: $e');
    }
  }

  Box getBox(String boxName) {
    return Hive.box(boxName);
  }

  // Store data
  Future<void> putData({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    try {
      if (key.isEmpty) {
        throw HiveStorageException('Key cannot be empty');
      }
      final box = await openBox(boxName);
      await box.put(key, value);
    } catch (e) {
      throw HiveStorageException('Failed to store data in $boxName: $e');
    }
  }

  // Retrieve data
  Future<dynamic> getData({
    required String boxName,
    required String key,
    dynamic defaultValue,
  }) async {
    try {
      if (key.isEmpty) {
        throw HiveStorageException('Key cannot be empty');
      }
      final box = await openBox(boxName);
      return box.get(key, defaultValue: defaultValue);
    } catch (e) {
      throw HiveStorageException('Failed to retrieve data from $boxName: $e');
    }
  }

  // Contain data
  Future<bool> containKey({
    required String boxName,
    required String key,
  }) async {
    try {
      if (key.isEmpty) {
        throw HiveStorageException('Key cannot be empty');
      }
      final box = await openBox(boxName);
      return box.containsKey(key);
    } catch (e) {
      throw HiveStorageException('Failed to delete data from $boxName: $e');
    }
  }

  // Delete data
  Future<void> deleteData({
    required String boxName,
    required String key,
  }) async {
    try {
      if (key.isEmpty) {
        throw HiveStorageException('Key cannot be empty');
      }
      final box = await openBox(boxName);
      await box.delete(key);
    } catch (e) {
      throw HiveStorageException('Failed to delete data from $boxName: $e');
    }
  }

  // Clear all data in a box
  Future<void> clearBox(String boxName) async {
    try {
      final box = await openBox(boxName);
      await box.clear();
    } catch (e) {
      throw HiveStorageException('Failed to clear box $boxName: $e');
    }
  }

  // Delete box
  Future<void> deleteBox(String boxName) async {
    try {
      if (await boxExists(boxName)) {
        await Hive.deleteBoxFromDisk(boxName);
      }
    } catch (e) {
      throw HiveStorageException('Failed to delete box $boxName: $e');
    }
  }

  // Check if box exists
  Future<bool> boxExists(String boxName) async {
    try {
      return await Hive.boxExists(boxName);
    } catch (e) {
      throw HiveStorageException('Failed to check if box $boxName exists: $e');
    }
  }

  // Replace data in a box
  Future<void> replaceData({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    try {
      if (key.isEmpty) {
        throw HiveStorageException('Key cannot be empty');
      }
      final box = await openBox(boxName);
      await box.put(key, value);
    } catch (e) {
      throw HiveStorageException('Failed to replace data in $boxName: $e');
    }
  }

  // Add new value to a box
  Future<void> addValue({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    try {
      if (key.isEmpty) {
        throw HiveStorageException('Key cannot be empty');
      }
      final box = await openBox(boxName);
      await box.add(value);
    } catch (e) {
      throw HiveStorageException('Failed to add value to $boxName: $e');
    }
  }

  // Add multiple values to a box
  Future<void> addValues({
    required String boxName, 
    required Map<String, dynamic> values,
  }) async {
    try {
      final box = await openBox(boxName);
      await box.putAll(values);
    } catch (e) {
      throw HiveStorageException('Failed to add values to $boxName: $e');
    }
  }
}
