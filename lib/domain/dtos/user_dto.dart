import 'package:bus_teste/domain/dtos/dob_dto.dart';
import 'package:bus_teste/domain/dtos/id_dto.dart';
import 'package:bus_teste/domain/dtos/location_dto.dart';
import 'package:bus_teste/domain/dtos/login_dto.dart';
import 'package:bus_teste/domain/dtos/name_dto.dart';
import 'package:bus_teste/domain/entities/user_entity.dart';

class UserDto {
  final String gender;
  final NameDto name;
  final LocationDto location;
  final String email;
  final LoginDto login;
  final DobDto dob;
  final String registered;
  final String phone;
  final String cell;
  final IdDto id;
  final String picture;
  final String nat;

  UserDto({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    String registeredDate = '';
    if (json['registered'] is Map) {
      registeredDate = json['registered']['date'] ?? '';
    } else if (json['registered'] is String) {
      registeredDate = json['registered'];
    }

    String pictureUrl = '';
    if (json['picture'] is Map) {
      pictureUrl = json['picture']['medium'] ?? '';
    } else if (json['picture'] is String) {
      pictureUrl = json['picture'];
    }

    return UserDto(
      gender: json['gender'] ?? '',
      name: NameDto.fromJson(json['name'] ?? {}),
      location: LocationDto.fromJson(json['location'] ?? {}),
      email: json['email'] ?? '',
      login: LoginDto.fromJson(json['login'] ?? {}),
      dob: DobDto.fromJson(json['dob'] ?? {}),
      registered: registeredDate,
      phone: json['phone'] ?? '',
      cell: json['cell'] ?? '',
      id: IdDto.fromJson(json['id'] ?? {}),
      picture: pictureUrl,
      nat: json['nat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'name': name.toJson(),
      'location': location.toJson(),
      'email': email,
      'login': login.toJson(),
      'dob': dob.toJson(),
      'registered': registered,
      'phone': phone,
      'cell': cell,
      'id': id.toJson(),
      'picture': picture,
      'nat': nat,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      gender: gender,
      name: name.toEntity(),
      location: location.toEntity(),
      email: email,
      login: login.toEntity(),
      dob: dob.toEntity(),
      registered: registered,
      phone: phone,
      cell: cell,
      id: id.toEntity(),
      picture: picture,
      nat: nat,
    );
  }

  factory UserDto.fromEntity(UserEntity entity) {
    return UserDto(
      gender: entity.gender,
      name: NameDto.fromEntity(entity.name),
      location: LocationDto.fromEntity(entity.location),
      email: entity.email,
      login: LoginDto.fromEntity(entity.login),
      dob: DobDto.fromEntity(entity.dob),
      registered: entity.registered,
      phone: entity.phone,
      cell: entity.cell,
      id: IdDto.fromEntity(entity.id),
      picture: entity.picture,
      nat: entity.nat,
    );
  }
}
