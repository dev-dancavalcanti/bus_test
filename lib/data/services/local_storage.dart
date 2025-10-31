import 'package:bus_teste/utils/exceptions/exceptions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  AsyncResult<Unit> saveData(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
      return Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<String> getData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(key);
      return value != null
          ? Success(value)
          : Failure(GlobalException('No data found for key: $key'));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Unit> deleteData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
      return Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
