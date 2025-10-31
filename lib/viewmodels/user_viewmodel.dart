import 'package:bus_teste/data/repositories/user/user_repository.dart';
import 'package:bus_teste/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  UserViewModel(this._userRepository);

  late final userCommand = Command0(_getUser);
  late final saveUserCommand = Command1(toggleUserSaved);
  late final deleteUserCommand = Command1(_deleteUser);
  late final clearLocalStorageCommand = Command0(
    _userRepository.clearLocalStorage,
  );
  late final getUserLocalStorageCommand = Command0(_getUserLocalStorage);

  List<UserEntity> users = [];
  List<UserEntity> savedUsers = [];

  AsyncResult<UserEntity> _getUser() {
    return _userRepository.getUser().flatMap((user) {
      users.add(user);
      notifyListeners();
      return Success(user);
    });
  }

  AsyncResult<List<UserEntity>> _getUserLocalStorage() {
    return _userRepository.getUserLocalStorage().flatMap((users) {
      savedUsers = [...users];
      notifyListeners();
      return Success(savedUsers);
    });
  }

  AsyncResult<Unit> _deleteUser(String uuid) {
    savedUsers.removeWhere((user) => user.login.uuid == uuid);
    notifyListeners();
    return _userRepository.saveUser(savedUsers);
  }

  bool isUserSaved(String uuid) {
    return savedUsers.any((user) => user.login.uuid == uuid);
  }

  AsyncResult<Unit> toggleUserSaved(UserEntity user) {
    if (savedUsers.any((u) => u.login.uuid == user.login.uuid)) {
      return _deleteUser(user.login.uuid);
    } else {
      savedUsers.add(user);
      notifyListeners();
      return _userRepository.saveUser(savedUsers);
    }
  }
}
