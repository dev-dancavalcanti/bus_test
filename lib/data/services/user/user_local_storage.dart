import 'dart:convert';

import 'package:bus_teste/data/services/local_storage.dart';
import 'package:bus_teste/domain/dtos/user_dto.dart';
import 'package:result_dart/result_dart.dart';

final _userKey = 'user_data';

class UserLocalStorage {
  final LocalStorage _localStorage;
  UserLocalStorage(this._localStorage);

  AsyncResult<Unit> saveUserData(List<UserDto> userData) {
    final json = jsonEncode(userData.map((dto) => dto.toJson()).toList());
    return _localStorage //
        .saveData(_userKey, json)
        .mapError((e) => Exception('Failed to save user data: $e'))
        .flatMap((_) => Success(unit));
  }

  AsyncResult<List<UserDto>> getUserData() {
    return _localStorage //
        .getData(_userKey)
        .flatMap((json) {
          final List<dynamic> decoded = jsonDecode(json);
          return Success(
            decoded.map((item) => UserDto.fromJson(item)).toList(),
          );
        })
        .mapError((e) => Exception('Failed to get user data: $e'));
  }

  AsyncResult<Unit> clearUserData() {
    return _localStorage //
        .deleteData(_userKey)
        .mapError((e) => Exception('Failed to clear user data: $e'))
        .flatMap((_) => Success(unit));
  }
}
