import 'package:first/app/utils/preference_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityStore implements PreferenceStore {
  late final FlutterSecureStorage store;

  SecurityStore(){
    store = const FlutterSecureStorage();
  }
  @override
  Future<String> read(String key)  async {
    return await store.read(key: key) ?? "";
  }

  @override
  Future<Map<String, String>> readAll() async{
    return await store.readAll();
  }

  @override
  void write(String key, String value) async {
    await store.write(key: key, value: value);
  }

}