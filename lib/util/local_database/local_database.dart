import 'package:get_storage/get_storage.dart';

class LocalStorage {
  //initialzie get storeage
  final GetStorage _box = GetStorage();

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  //Write data from storage
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  //read data from database
  D? read<D>(String key) {
    return _box.read<D>(key);
  }

  //remove data from storage
  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  //clear all data from  storage
  Future<void> clear() async {
    await _box.erase();
  }
}