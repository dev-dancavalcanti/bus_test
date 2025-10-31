import 'package:bus_teste/data/repositories/user/i_user_repository.dart';
import 'package:bus_teste/data/services/user/user_client_http.dart';
import 'package:bus_teste/data/services/user/user_local_storage.dart';
import 'package:bus_teste/domain/dtos/user_dto.dart';
import 'package:bus_teste/domain/entities/user_entity.dart';
import 'package:bus_teste/utils/exceptions/exceptions.dart';
import 'package:result_dart/result_dart.dart';

class UserRepository implements IUserRepository {
  final UserLocalStorage _localStorage;
  final UserClientHttp _clientHttp;
  UserRepository(this._localStorage, this._clientHttp);

  @override
  AsyncResult<Unit> saveUser(List<UserEntity> users) {
    List<UserDto> userDtos = users.map(UserDto.fromEntity).toList();
    return _localStorage
        .saveUserData(userDtos)
        .flatMap((_) => Success(unit))
        .mapError((e) => GlobalException('Falha ao salvar usuário'));
  }

  @override
  AsyncResult<Unit> clearLocalStorage() {
    return _localStorage
        .clearUserData()
        .flatMap((_) => Success(unit))
        .mapError(
          (e) => GlobalException('Falha ao limpar armazenamento local'),
        );
  }

  @override
  AsyncResult<List<UserEntity>> getUserLocalStorage() {
    return _localStorage
        .getUserData()
        .flatMap(
          (userDtos) => Success(userDtos.map((dto) => dto.toEntity()).toList()),
        )
        .mapError(
          (e) => GlobalException(
            'Falha ao obter dados de usuário do armazenamento local',
          ),
        );
  }

  @override
  AsyncResult<UserEntity> getUser() {
    return _clientHttp
        .getUser()
        .flatMap((dto) {
          return Success(dto.toEntity());
        })
        .mapError((e) => GlobalException('Falha ao buscar usuário'));
  }
}
