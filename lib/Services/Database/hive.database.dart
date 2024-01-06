import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app/Util/helper.util.dart';
// import 'package:hive_flutter/hive_flutter.dart';

class CacheRepository {
  Box? _box;
  // this is done to avoid external instantiation
  CacheRepository._internal();

  static final CacheRepository instance = CacheRepository._internal();

  factory CacheRepository() => instance;

  Future<Directory> getStorageDirectory() async {
    final directory = await getExternalStorageDirectory();
    return directory!;
  }

  //create a common instance that is shared among all the resource.
  Future<Box> get box async {
    if (_box == null) {
      Hive.init(
        await getStorageDirectory().then((dir) {
          if (dir != null) {
            return dir.path;
          }
        }),
      );
      _box = await Hive.openBox('cachedBox');
    }
    print(_box);
    return _box!;
  }
}
