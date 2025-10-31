import 'package:bus_teste/domain/entities/user_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class IUserRepository {
  AsyncResult<Unit> saveUser(List<UserEntity> users);
  AsyncResult<List<UserEntity>> getUserLocalStorage();
  AsyncResult<UserEntity> getUser();
  AsyncResult<Unit> clearLocalStorage();
}
