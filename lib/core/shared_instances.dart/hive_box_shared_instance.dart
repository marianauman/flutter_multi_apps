import 'package:hive_flutter/hive_flutter.dart';
import '../constants/hive_constants.dart';
import '../managers/hive_storage_manager.dart';

class HiveBoxSharedInstance {
  static final HiveBoxSharedInstance _instance = HiveBoxSharedInstance._internal();
  final HiveStorageManager _storageService = HiveStorageManager();
  
  factory HiveBoxSharedInstance() {
    return _instance;
  }
  
  HiveBoxSharedInstance._internal();



  // Initialize all boxes
  Future<void> initializeBoxes() async {
    try {
      await _storageService.init();
      await Future.wait([
        _storageService.openBox(HiveConstants.myBooksBox),
        _storageService.openBox(HiveConstants.settingsBox),
      ]);
    } catch (e) {
      throw HiveStorageException('Failed to initialize boxes: $e');
    }
  }

 Box getBox(String boxName) {
  return _storageService.getBox(boxName);
 }

  Future<bool> boxExists({
    required String boxName,
  }) async {
    return await _storageService.boxExists(boxName);
  }

  Future<void> putData({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    await _storageService.putData(boxName: boxName, key: key, value: value);
  }

  Future<dynamic> getData({
    required String boxName,
    required String key,
  }) async {
    return await _storageService.getData(boxName: boxName, key: key);
  }

  Future<bool> containsKey({
    required String boxName,
    required String key,
  }) async {
    return await _storageService.containKey(boxName: boxName, key: key);
  }

  Future<void> deleteData({
    required String boxName,
    required String key,
  }) async {
    await _storageService.deleteData(boxName: boxName, key: key);
  }

  Future<void> clearBox({
    required String boxName,
  }) async {
    await _storageService.clearBox(boxName);
  }
 
  Future<void> deleteBox({
    required String boxName,
  }) async {
    await _storageService.deleteBox(boxName);
  }

  Future<void> replaceData({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    await _storageService.replaceData(boxName: boxName, key: key, value: value);
  }

  Future<void> addValue({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    await _storageService.addValue(boxName: boxName, key: key, value: value);
  }

  Future<void> addValues({
    required String boxName,
    required Map<String, dynamic> values,
  }) async {
    await _storageService.addValues(boxName: boxName, values: values);
  }
  
}