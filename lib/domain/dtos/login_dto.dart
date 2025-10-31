import 'package:bus_teste/domain/entities/login_entity.dart';

class LoginDto {
  final String uuid;
  final String username;
  final String password;

  LoginDto({
    required this.uuid,
    required this.username,
    required this.password,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(
      uuid: json['uuid'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'uuid': uuid, 'username': username, 'password': password};
  }

  LoginEntity toEntity() {
    return LoginEntity(uuid: uuid, username: username, password: password);
  }

  factory LoginDto.fromEntity(LoginEntity entity) {
    return LoginDto(
      uuid: entity.uuid,
      username: entity.username,
      password: entity.password,
    );
  }
}
