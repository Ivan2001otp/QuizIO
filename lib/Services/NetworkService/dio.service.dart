import 'package:dio/dio.dart' as DioPackage;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/Services/Database/hive.database.dart';
import 'package:quiz_app/Util/helper.util.dart';

class DioService {
  final dio = DioPackage.Dio(
    DioPackage.BaseOptions(
      connectTimeout: Duration(seconds: 20),
      sendTimeout: Duration(seconds: 12),
      receiveTimeout: Duration(seconds: 12),
    ),
  );
  final String _URL =
      'https://quizapi.io/api/v1/questions?apiKey=hrtG3piTvZLbwHnQsBH4Uu7oxDDXGpKLZ6OkUCDj';

  String? _cacheData = null;

  dynamic request(String category, String limit, String level) async {
    DioPackage.Response response;

    //check in cache

    //if not present only make the api call.
    dynamic cacheResult = await CacheRepository.instance.box.then((hiveDb) {
      return hiveDb.get('cachedBox').toString();
    });

    if (cacheResult != null) {
      print('The cache result is : $cacheResult');
      return cacheResult;
    } else {
      print('Cache result is null bro!');
    }

    try {
      response = await dio
          .get('$_URL&category=${category}&difficulty=$level&limit=$limit');

      if (response.statusCode! > 199 && response.statusCode! <= 299) {
        print("success reponse -  ${response.statusCode}");
        CacheRepository.instance.box.then(
          (hiveDb) => hiveDb.put('cachedBox', response.data),
        );
      } else {
        print("something went wrong");
      }

      return response.data;
    } on DioPackage.DioException catch (e) {
      print('error occured due to exception-1 : ${e.message}');
      print(e.error.toString());
    } catch (e) {
      print('error occured due to exception-2');
      print(e);
    } finally {
      dio.close(force: true);
    }
    return 'No Response';
  }

  Future<String> cachedResponse(
      String _category, String _limit, String _level) async {
    Box box = await CacheRepository.instance.box;
    if (box.get('response') != null &&
        box.get('category') == _category &&
        box.get('limit') == _limit &&
        box.get('level') == _level) {
      return box.get(Constants.cachedBox.toString(), defaultValue: '');
    }
    //add the category and params
    box.put('category', _category);
    box.put('limit', _limit);
    box.put('level', _level);
    return '';
  }
}
